import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class NoInternetManager {
  final ValueNotifier<bool> internetState = ValueNotifier(true);

  NoInternetManager() {
    _init();
  }

  void _init() {
    checkConnectivity();
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      _updateInternet(results.any((r) => r != ConnectivityResult.none));
    });
  }

  Future<void> checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    _updateInternet(result.any((r) => r != ConnectivityResult.none));
  }

  void _updateInternet(bool status) {
    internetState.value = status;
  }

  void dispose() {
    internetState.dispose();
  }
}
