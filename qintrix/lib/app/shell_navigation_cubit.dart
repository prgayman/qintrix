import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_destination.dart';

class ShellNavigationCubit extends Cubit<AppDestination> {
  ShellNavigationCubit() : super(AppDestination.dashboard);

  void setDestination(AppDestination destination) {
    if (state == destination) {
      return;
    }

    emit(destination);
  }
}
