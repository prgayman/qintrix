import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:qintrix/data/repositories/exports.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

abstract class AppWindowBehaviorService {
  Future<void> initialize({required bool backgroundModeEnabled});

  Future<AppWindowBehaviorStatus> getStatus();

  Future<void> setBackgroundModeEnabled(bool enabled);

  Future<void> configureTrayActions({
    required Future<ServerStateModel> Function() readServerState,
    required Future<void> Function() startServer,
    required Future<void> Function() stopServer,
    required Future<void> Function() restartServer,
    required Future<void> Function() openSettings,
    required Future<void> Function() openServerOverview,
  });
}

class AppWindowBehaviorStatus {
  const AppWindowBehaviorStatus({
    required this.backgroundModeEnabled,
    required this.trayActive,
  });

  final bool backgroundModeEnabled;
  final bool trayActive;
}

class DesktopAppWindowBehaviorService extends WindowListener
    with TrayListener
    implements AppWindowBehaviorService {
  static const _macOsWindowChannel = MethodChannel('qintrix/startup');
  static const _showWindowKey = 'show_window';
  static const _startServerKey = 'start_server';
  static const _stopServerKey = 'stop_server';
  static const _restartServerKey = 'restart_server';
  static const _openSettingsKey = 'open_settings';
  static const _openServerOverviewKey = 'open_server_overview';
  static const _quitAppKey = 'quit_app';

  bool _isInitialized = false;
  bool _backgroundModeEnabled = false;
  bool _trayInitialized = false;
  String? _trayIconPath;
  Future<ServerStateModel> Function()? _readServerState;
  Future<void> Function()? _startServer;
  Future<void> Function()? _stopServer;
  Future<void> Function()? _restartServer;
  Future<void> Function()? _openSettings;
  Future<void> Function()? _openServerOverview;

  @override
  Future<void> initialize({required bool backgroundModeEnabled}) async {
    if (!_isDesktopPlatform) {
      return;
    }

    if (!_isInitialized) {
      windowManager.addListener(this);
      trayManager.addListener(this);
      _isInitialized = true;
    }

    await setBackgroundModeEnabled(backgroundModeEnabled);
  }

  @override
  Future<AppWindowBehaviorStatus> getStatus() async {
    return AppWindowBehaviorStatus(
      backgroundModeEnabled: _backgroundModeEnabled,
      trayActive: _trayInitialized,
    );
  }

  @override
  Future<void> setBackgroundModeEnabled(bool enabled) async {
    if (!_isDesktopPlatform) {
      return;
    }

    if (_backgroundModeEnabled == enabled) {
      if (enabled) {
        await _ensureTray();
        await _refreshTrayMenu();
      }
      return;
    }

    if (Platform.isMacOS) {
      await _macOsWindowChannel.invokeMethod<void>(
        'setBackgroundModeEnabled',
        enabled,
      );
    }

    _backgroundModeEnabled = enabled;
    await windowManager.setPreventClose(enabled);

    if (enabled) {
      await _ensureTray();
      await _refreshTrayMenu();
      return;
    }

    if (_trayInitialized) {
      await trayManager.destroy();
      _trayInitialized = false;
    }
  }

  bool get _isDesktopPlatform =>
      Platform.isLinux || Platform.isMacOS || Platform.isWindows;

  @override
  Future<void> configureTrayActions({
    required Future<ServerStateModel> Function() readServerState,
    required Future<void> Function() startServer,
    required Future<void> Function() stopServer,
    required Future<void> Function() restartServer,
    required Future<void> Function() openSettings,
    required Future<void> Function() openServerOverview,
  }) async {
    _readServerState = readServerState;
    _startServer = startServer;
    _stopServer = stopServer;
    _restartServer = restartServer;
    _openSettings = openSettings;
    _openServerOverview = openServerOverview;

    if (_trayInitialized) {
      await _refreshTrayMenu();
    }
  }

  @override
  Future<void> onWindowClose() async {
    final isPreventClose = await windowManager.isPreventClose();
    if (!isPreventClose) {
      return;
    }

    if (!_backgroundModeEnabled) {
      await _quitApplication();
      return;
    }

    await _ensureTray();
    await windowManager.hide();
  }

  @override
  void onTrayIconMouseDown() {
    if (Platform.isMacOS) {
      unawaited(_showTrayMenu());
      return;
    }

    _showWindow();
  }

  @override
  void onTrayIconRightMouseDown() {
    unawaited(_refreshTrayMenu());
  }

  @override
  void onTrayIconRightMouseUp() {
    if (Platform.isMacOS) {
      return;
    }

    unawaited(_showTrayMenu());
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    switch (menuItem.key) {
      case _showWindowKey:
        _showWindow();
        return;
      case _startServerKey:
        _handleServerAction(_TrayServerAction.start);
        return;
      case _stopServerKey:
        _handleServerAction(_TrayServerAction.stop);
        return;
      case _restartServerKey:
        _handleServerAction(_TrayServerAction.restart);
        return;
      case _openSettingsKey:
        _handleOpenSettings();
        return;
      case _openServerOverviewKey:
        _handleOpenServerOverview();
        return;
      case 'server_status':
        return;
      case _quitAppKey:
        _quitApplication();
        return;
    }
  }

  Future<void> _ensureTray() async {
    if (_trayInitialized) {
      return;
    }

    final iconPath = await _resolveTrayIconPath();
    await trayManager.setIcon(iconPath, isTemplate: Platform.isMacOS);
    await trayManager.setToolTip('Qintrix');
    await _refreshTrayMenu();
    _trayInitialized = true;
  }

  Future<void> _refreshTrayMenu() async {
    if (!_trayInitialized && !_backgroundModeEnabled) {
      return;
    }

    final serverState = await _safeReadServerState();
    final isRunning = serverState?.isRunning == true;
    final serverStatusLabel = isRunning ? 'Server running' : 'Server stopped';

    await trayManager.setContextMenu(
      Menu(
        items: [
          MenuItem(key: _showWindowKey, label: 'Show Qintrix'),
          MenuItem.separator(),
          MenuItem(
            key: 'server_status',
            label: serverStatusLabel,
            disabled: true,
          ),
          MenuItem(
            key: _startServerKey,
            label: 'Start server',
            disabled: isRunning,
          ),
          MenuItem(
            key: _restartServerKey,
            label: 'Restart server',
            disabled: !isRunning,
          ),
          MenuItem(
            key: _stopServerKey,
            label: 'Stop server',
            disabled: !isRunning,
          ),
          MenuItem.separator(),
          MenuItem(key: _openServerOverviewKey, label: 'Server overview'),
          MenuItem(key: _openSettingsKey, label: 'Settings'),
          MenuItem.separator(),
          MenuItem(key: _quitAppKey, label: 'Quit'),
        ],
      ),
    );
  }

  Future<String> _resolveTrayIconPath() async {
    if (_trayIconPath != null) {
      return _trayIconPath!;
    }

    final data = await rootBundle.load('assets/tray-icon.png');
    final file = File(
      p.join(Directory.systemTemp.path, 'qintrix-tray-icon.png'),
    );
    await file.writeAsBytes(_asUint8List(data), flush: true);
    _trayIconPath = file.path;
    return _trayIconPath!;
  }

  Uint8List _asUint8List(ByteData data) {
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> _showWindow() async {
    await windowManager.show();
    if (Platform.isMacOS) {
      await windowManager.focus();
      return;
    }
    await windowManager.restore();
    await windowManager.focus();
  }

  Future<void> _showTrayMenu() async {
    await _refreshTrayMenu();
    await trayManager.popUpContextMenu();
  }

  Future<ServerStateModel?> _safeReadServerState() async {
    final readServerState = _readServerState;
    if (readServerState == null) {
      return null;
    }

    try {
      return await readServerState();
    } catch (_) {
      return null;
    }
  }

  Future<void> _handleServerAction(_TrayServerAction action) async {
    final state = await _safeReadServerState();
    if (state == null) {
      return;
    }

    switch (action) {
      case _TrayServerAction.start:
        if (state.isRunning) {
          return;
        }
        await _startServer?.call();
      case _TrayServerAction.stop:
        if (!state.isRunning) {
          return;
        }
        await _stopServer?.call();
      case _TrayServerAction.restart:
        if (!state.isRunning) {
          return;
        }
        await _restartServer?.call();
    }

    await _refreshTrayMenu();
  }

  Future<void> _handleOpenSettings() async {
    await _showWindow();
    await _openSettings?.call();
  }

  Future<void> _handleOpenServerOverview() async {
    await _showWindow();
    await _openServerOverview?.call();
  }

  Future<void> _quitApplication() async {
    await windowManager.setPreventClose(false);
    if (_trayInitialized) {
      await trayManager.destroy();
      _trayInitialized = false;
    }
    await windowManager.destroy();
    await SystemNavigator.pop();
  }
}

enum _TrayServerAction { start, stop, restart }
