import "package:collect/features/home/controller/home_controller.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/theme/theme_service.dart";
import "package:collect/core/utils/local_navigation.dart";
import "package:collect/core/widgets/bottom_navigation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  bool _onWillPop() {
    if (controller.selectedMenuIndex.value == 0) {
      return true;
    }
    final NavigatorState? navigatorState = Get.nestedKey(1)?.currentState;
    if (navigatorState != null && navigatorState.canPop()) {
      navigatorState.pop();
      return false;
    }
    return true;
  }

  void _handleNavigation(int index) {
    final NavigatorState? navigator = Get.nestedKey(1)?.currentState;
    if (navigator == null) return;

    final List<Destination> destinations = Destination.values;
    if (controller.selectedMenuIndex.value == index) return;

    final int previousIndex = controller.selectedMenuIndex.value;
    navigator.pushReplacement(
      _buildTabRoute(destinations[index], previousIndex, index),
    );
    controller.selectedMenuIndex.value = index;
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<ThemeMode>(
    valueListenable: ThemeService.themeModeNotifier,
    builder: (BuildContext context, ThemeMode themeMode, Widget? child) =>
        PopScope(
          canPop: true,
          onPopInvokedWithResult: (bool didPop, dynamic result) {
            if (didPop) _onWillPop();
          },
          child: Scaffold(
            backgroundColor: ThemeColors.scaffoldColor,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Obx(
              () => BottomNavigationView(
                selectedIndex: controller.selectedMenuIndex.value,
                onItemClick: _handleNavigation,
              ),
            ),
            body: Navigator(
              key: Get.nestedKey(1),
              initialRoute: Destination.dashboard.route,
              onGenerateRoute: Destination.getPage,
              observers: <NavigatorObserver>[ViewNavigatorObserver()],
            ),
          ),
        ),
  );
}

class ViewNavigatorObserver extends NavigatorObserver {
  ViewNavigatorObserver();

  @override
  void didPop(Route route, Route? previousRoute) {
    final HomeController controller = Get.find();
    controller.selectedMenuIndex.value = _routeNameToIndex(
      previousRoute?.settings.name,
    );
  }
}

Route _buildTabRoute(Destination destination, int fromIndex, int toIndex) {
  final bool slideFromRight = toIndex > fromIndex;
  final Offset startOffset = Offset(slideFromRight ? 0.12 : -0.12, 0);
  return PageRouteBuilder(
    settings: RouteSettings(name: destination.route),
    pageBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) => destination.widget,
    transitionDuration: const Duration(milliseconds: 360),
    reverseTransitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          final Animation<double> curve = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );

          final Animation<double> fade = Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(curve);

          final Animation<Offset> slide = Tween<Offset>(
            begin: startOffset,
            end: Offset.zero,
          ).animate(curve);

          return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: slide, child: child),
          );
        },
  );
}

int _routeNameToIndex(String? routeName) {
  if (routeName == null) return 0;
  final int routeIndex = Destination.values.indexWhere(
    (Destination destination) => destination.route == routeName,
  );
  return routeIndex >= 0 ? routeIndex : 0;
}
