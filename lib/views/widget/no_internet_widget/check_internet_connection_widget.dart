import 'package:collect/utils/internet_check.dart';
import 'package:flutter/material.dart';
import 'no_internet_widget.dart';

class CheckInternetConnection extends StatefulWidget {
  final Widget child;

  const CheckInternetConnection({super.key, required this.child});

  @override
  State<CheckInternetConnection> createState() =>
      _CheckInternetConnectionState();
}

class _CheckInternetConnectionState extends State<CheckInternetConnection> {
  late final NoInternetManager noInternetManager;

  @override
  void initState() {
    super.initState();
    noInternetManager = NoInternetManager();
  }

  @override
  void dispose() {
    noInternetManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: noInternetManager.internetState,
      builder: (context, isConnected, child) {
        if (isConnected) {
          return widget.child;
        } else {
          return NoInternetConnection(
            onRetry: noInternetManager.checkConnectivity,
          );
        }
      },
    );
  }
}
