import 'package:flutter/foundation.dart';

class AppRuntimeSignals {
  final ValueNotifier<int> server = ValueNotifier<int>(0);
  final ValueNotifier<int> queue = ValueNotifier<int>(0);

  void bumpServer() {
    server.value++;
  }

  void bumpQueue() {
    queue.value++;
  }

  void dispose() {
    server.dispose();
    queue.dispose();
  }
}
