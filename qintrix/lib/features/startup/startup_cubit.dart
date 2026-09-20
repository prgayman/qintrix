import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/core/services/exports.dart';
import 'startup_service.dart';
import 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit({
    required StartupService startupService,
    required LoggerService loggerService,
    required Duration minimumSplashDuration,
  }) : _startupService = startupService,
       _loggerService = loggerService,
       _minimumSplashDuration = minimumSplashDuration,
       super(const StartupState.initial());

  final StartupService _startupService;
  final LoggerService _loggerService;
  final Duration _minimumSplashDuration;

  Future<void> start() async {
    emit(const StartupState(status: StartupStatus.loading));

    try {
      await Future.wait<void>([
        _startupService.initialize(),
        Future<void>.delayed(_minimumSplashDuration),
      ]);

      emit(const StartupState(status: StartupStatus.ready));
    } catch (error) {
      await _loggerService.logAppError(error.toString());
      emit(
        StartupState(status: StartupStatus.failure, message: error.toString()),
      );
    }
  }
}
