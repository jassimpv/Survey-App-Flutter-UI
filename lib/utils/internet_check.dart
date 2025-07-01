import "package:connectivity_plus/connectivity_plus.dart";
import "package:flutter/foundation.dart";

class NoInternetManager {
  NoInternetManager() {
    _init();
  }
  final ValueNotifier<bool> internetState = ValueNotifier(true);

  void _init() {
    checkConnectivity();
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      _updateInternet(
        results.any((ConnectivityResult r) => r != ConnectivityResult.none),
      );
    });
  }

  Future<void> checkConnectivity() async {
    final List<ConnectivityResult> result = await Connectivity()
        .checkConnectivity();
    _updateInternet(
      result.any((ConnectivityResult r) => r != ConnectivityResult.none),
    );
  }

  void _updateInternet(bool status) {
    internetState.value = status;
  }

  void dispose() {
    internetState.dispose();
  }
}
