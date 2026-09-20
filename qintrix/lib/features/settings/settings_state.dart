import 'package:qintrix/data/models/exports.dart';

enum SettingsStatus { initial, loading, loaded, saving, failure }

class SettingsState {
  const SettingsState({required this.status, this.settings, this.message});

  const SettingsState.initial() : this(status: SettingsStatus.initial);

  final SettingsStatus status;
  final AppSettingsModel? settings;
  final String? message;

  SettingsState copyWith({
    SettingsStatus? status,
    AppSettingsModel? settings,
    String? message,
  }) {
    return SettingsState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      message: message,
    );
  }
}
