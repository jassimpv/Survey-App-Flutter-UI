import "package:collect/core/utils/internet_check.dart";
import "package:collect/core/widgets/no_internet_widget/no_internet_widget.dart";
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
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: noInternetManager.internetState,
      child: widget.child,
      builder: (context, isConnected, child) {
        final resolvedChild = child ?? const SizedBox.shrink();
        return Stack(
          children: [
            Positioned.fill(child: resolvedChild),
            if (!isConnected)
              Positioned.fill(
                child: NoInternetConnection(
                  onRetry: noInternetManager.checkConnectivity,
                ),
              ),
          ],
        );
      },
    );
  }
}
