import 'package:flutter/widgets.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

abstract final class LogBadgeMapper {
  static IconData levelIcon(String level) {
    return switch (level) {
      'error' => LucideIcons.circleAlert,
      'warning' => LucideIcons.triangleAlert,
      _ => LucideIcons.info,
    };
  }

  static AppStatusTone levelTone(String level) {
    return switch (level) {
      'error' => AppStatusTone.error,
      'warning' => AppStatusTone.warning,
      _ => AppStatusTone.info,
    };
  }

  static IconData eventIcon(String eventType) {
    return switch (eventType) {
      'app_start' => LucideIcons.sparkles,
      'app_error' => LucideIcons.bug,
      'server_start' => LucideIcons.play,
      'server_stop' => LucideIcons.square,
      'server_restart' => LucideIcons.rotateCw,
      'server_error' => LucideIcons.serverCrash,
      'api_auth_failure' => LucideIcons.shieldX,
      'print_job_created' => LucideIcons.printer,
      'printer_test_result' => LucideIcons.badgeCheck,
      _ => LucideIcons.activity,
    };
  }

  static AppStatusTone eventTone(String eventType) {
    return switch (eventType) {
      'app_error' => AppStatusTone.error,
      'server_error' => AppStatusTone.error,
      'api_auth_failure' => AppStatusTone.warning,
      'server_start' || 'server_stop' || 'server_restart' => AppStatusTone.warning,
      'printer_test_result' => AppStatusTone.info,
      _ => AppStatusTone.info,
    };
  }

  static String humanize(String value) {
    return value
        .split('_')
        .where((part) => part.isNotEmpty)
        .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
        .join(' ');
  }
}
