import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:win32_registry/win32_registry.dart';

import 'app_launch_mode.dart';

abstract class AppLaunchAtStartupService {
  Future<void> initialize({required bool enabled});

  Future<bool> isEnabled();

  Future<void> setEnabled(bool enabled);
}

class DesktopAppLaunchAtStartupService implements AppLaunchAtStartupService {
  DesktopAppLaunchAtStartupService({
    this.appName = 'Qintrix',
    this.identifier = 'app.tenvoro.qintrix',
    String? executablePath,
  }) : _executablePath = executablePath ?? Platform.resolvedExecutable;

  static const _windowsRunKey =
      r'Software\Microsoft\Windows\CurrentVersion\Run';

  final String appName;
  final String identifier;
  final String _executablePath;
  static const _backgroundArgument = AppLaunchMode.backgroundLaunchArgument;

  @override
  Future<void> initialize({required bool enabled}) async {
    final currentlyEnabled = await isEnabled();

    if (!enabled && !currentlyEnabled) {
      return;
    }

    if (enabled && currentlyEnabled) {
      if (Platform.isMacOS) {
        final file = await _macOsLaunchAgentFile();
        final expectedContents = _macOsLaunchAgentContents();
        if (!await file.exists()) {
          await file.create(recursive: true);
          await file.writeAsString(expectedContents);
          return;
        }

        final existingContents = await file.readAsString();
        if (existingContents != expectedContents) {
          await file.writeAsString(expectedContents);
        }
      }
      return;
    }

    await setEnabled(enabled);
  }

  @override
  Future<bool> isEnabled() async {
    if (Platform.isWindows) {
      final hkcu = Registry.currentUser;
      final runKey = hkcu.createKey(_windowsRunKey);
      try {
        return runKey.getStringValue(appName) != null;
      } finally {
        runKey.close();
      }
    }

    if (Platform.isMacOS) {
      final file = await _macOsLaunchAgentFile();
      return file.exists();
    }

    if (Platform.isLinux) {
      final file = await _linuxAutostartFile();
      return file.exists();
    }

    return false;
  }

  @override
  Future<void> setEnabled(bool enabled) async {
    if (Platform.isWindows) {
      _setWindows(enabled);
      return;
    }

    if (Platform.isMacOS) {
      final file = await _macOsLaunchAgentFile();
      if (enabled) {
        await file.create(recursive: true);
        await file.writeAsString(_macOsLaunchAgentContents());
      } else if (await file.exists()) {
        await _unloadMacOsLaunchAgent();
        await file.delete();
      }
      return;
    }

    if (Platform.isLinux) {
      final file = await _linuxAutostartFile();
      if (enabled) {
        await file.create(recursive: true);
        await file.writeAsString(_linuxDesktopEntry());
      } else if (await file.exists()) {
        await file.delete();
      }
    }
  }

  void _setWindows(bool enabled) {
    final hkcu = Registry.currentUser;
    final runKey = hkcu.createKey(_windowsRunKey);
    try {
      if (enabled) {
        runKey.createValue(
          RegistryValue.string(appName, _windowsLaunchCommand),
        );
        return;
      }

      final existingValue = runKey.getStringValue(appName);
      if (existingValue != null) {
        runKey.deleteValue(appName);
      }
    } finally {
      runKey.close();
    }
  }

  Future<File> _macOsLaunchAgentFile() async {
    final directory = Directory(
      p.join(await _macOsUserHomeDirectory(), 'Library', 'LaunchAgents'),
    );
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return File(p.join(directory.path, '$identifier.plist'));
  }

  String _macOsLaunchAgentContents() {
    final escapedPath = _xmlEscape(_executablePath);
    final workingDirectory = _xmlEscape(File(_executablePath).parent.path);
    return '''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>$identifier</string>
  <key>ProgramArguments</key>
  <array>
    <string>$escapedPath</string>
    <string>${_xmlEscape(_backgroundArgument)}</string>
  </array>
  <key>WorkingDirectory</key>
  <string>$workingDirectory</string>
  <key>RunAtLoad</key>
  <true/>
  <key>KeepAlive</key>
  <false/>
</dict>
</plist>
''';
  }

  Future<File> _linuxAutostartFile() async {
    final directory = Directory(
      p.join(Platform.environment['HOME'] ?? '', '.config', 'autostart'),
    );
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return File(p.join(directory.path, '$identifier.desktop'));
  }

  String _linuxDesktopEntry() {
    return '''
[Desktop Entry]
Type=Application
Version=1.0
Name=$appName
Exec=${_desktopEntryEscape(_executablePath)} ${_desktopEntryEscape(_backgroundArgument)}
Terminal=false
X-GNOME-Autostart-enabled=true
''';
  }

  String get _windowsLaunchCommand =>
      '"${_executablePath.replaceAll('"', '""')}" $_backgroundArgument';

  String _desktopEntryEscape(String value) {
    return value.replaceAll('\\', '\\\\').replaceAll(' ', '\\ ');
  }

  String _xmlEscape(String value) {
    return value
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');
  }

  Future<void> _unloadMacOsLaunchAgent() async {
    final domain = await _macOsLaunchDomain();
    await Process.run('launchctl', ['bootout', '$domain/$identifier']);
  }

  Future<String> _macOsLaunchDomain() async {
    final uid = Platform.environment['UID']?.trim();
    if (uid != null && uid.isNotEmpty) {
      return 'gui/$uid';
    }

    final result = await Process.run('id', ['-u']);
    final resolvedUid = '${result.stdout}'.trim();
    if (result.exitCode == 0 && resolvedUid.isNotEmpty) {
      return 'gui/$resolvedUid';
    }

    throw ProcessException(
      'id',
      ['-u'],
      'Unable to determine current macOS user id.',
      result.exitCode,
    );
  }

  Future<String> _macOsUserHomeDirectory() async {
    final home = Platform.environment['HOME']?.trim();
    if (home != null && home.isNotEmpty) {
      const marker = '/Library/Containers/';
      final markerIndex = home.indexOf(marker);
      if (markerIndex > 0) {
        return home.substring(0, markerIndex);
      }
      return home;
    }

    const homeCommand = 'printenv HOME';
    final result = await Process.run('sh', ['-c', homeCommand]);
    final resolved = '${result.stdout}'.trim();
    if (result.exitCode == 0 && resolved.isNotEmpty) {
      return resolved;
    }

    throw ProcessException(
      'sh',
      ['-c', homeCommand],
      'Unable to determine current macOS home directory.',
      result.exitCode,
    );
  }
}
