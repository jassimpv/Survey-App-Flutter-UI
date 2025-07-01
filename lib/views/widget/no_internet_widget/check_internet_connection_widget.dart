import "package:collect/utils/internet_check.dart";
import "package:collect/views/widget/no_internet_widget/no_internet_widget.dart";
import "package:flutter/material.dart";

class CheckInternetConnection extends StatefulWidget {
  const CheckInternetConnection({required this.child, super.key});
  final Widget child;

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
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
    valueListenable: noInternetManager.internetState,
    builder: (BuildContext context, bool isConnected, Widget? child) {
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
