import 'package:flutter_bloc/flutter_bloc.dart';

class SidebarCubit extends Cubit<bool> {
  SidebarCubit() : super(true);

  void toggle() => emit(!state);
}
