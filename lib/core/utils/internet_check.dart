import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class NoInternetManager {
  NoInternetManager() {
    _init();
  }

  final ValueNotifier<bool> internetState = ValueNotifier(true);
  StreamSubscription<dynamic>? _subscription;

  void _init() {
    checkConnectivity();
    _subscription = Connectivity().onConnectivityChanged.listen((
      dynamic event,
    ) {
      bool connected = false;
      if (event is ConnectivityResult) {
        connected = event != ConnectivityResult.none;
      } else if (event is List<ConnectivityResult>) {
        connected = event.any(
          (ConnectivityResult r) => r != ConnectivityResult.none,
        );
      }

      if (connected) {
        // Connectivity reports a network interface is available; verify real internet access
        _verifyAndUpdate();
      } else {
        _updateInternet(false);
      }
    });
  }

  Future<void> checkConnectivity() async {
    final dynamic result = await Connectivity().checkConnectivity();
    bool connected = false;
    if (result is ConnectivityResult) {
      connected = result != ConnectivityResult.none;
    } else if (result is List<ConnectivityResult>) {
      connected = result.any(
        (ConnectivityResult r) => r != ConnectivityResult.none,
      );
    }

    if (connected) {
      await _verifyAndUpdate();
    } else {
      _updateInternet(false);
    }
  }

  Future<void> _verifyAndUpdate() async {
    final bool hasInternet = await _hasActualConnection();
    _updateInternet(hasInternet);
  }

  Future<bool> _hasActualConnection() async {
    try {
      final List<InternetAddress> result = await InternetAddress.lookup(
        'example.com',
      ).timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void _updateInternet(bool status) {
    internetState.value = status;
  }

  void dispose() {
    _subscription?.cancel();
    internetState.dispose();
  }
}
