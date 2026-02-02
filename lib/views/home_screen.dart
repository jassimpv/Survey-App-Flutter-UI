import "package:collect/controller/home_controller.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/local_navigation.dart";
import "package:collect/views/widget/bottom_navigation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:upgrader/upgrader.dart";

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

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: _onWillPop(),
    child: UpgradeAlert(
      dialogStyle: UpgradeDialogStyle.cupertino,
      showIgnore: false,
      showLater: false,
      child: Scaffold(
        backgroundColor: ColorUtils.scaffoldColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Obx(
          () => BottomNavigationView(
            selectedIndex: controller.selectedMenuIndex.value,
            onItemClick: (int index) {
              print("Tapped on index: $index");
              final List<String> routes = <String>[
                Destination.dashboard.route,
                Destination.completedTasks.route,
                Destination.profile.route,
              ];

              // Avoid pushing if already on the selected tab
              if (controller.selectedMenuIndex.value == index) return;

              // Replace current route in the nested navigator
              Get.nestedKey(
                1,
              )!.currentState!.pushReplacementNamed(routes[index]);

              // Update the selected tab index
              controller.selectedMenuIndex.value = index;
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Navigator(
                // You MUST pass an unique key to the Navigator
                key: Get.nestedKey(1),
                // Initial route (see destination.dart above)
                initialRoute: Destination.dashboard.route,

                // Generate a route based on Destination (see destination.dart above)
                onGenerateRoute: Destination.getPage,
                observers: <NavigatorObserver>[ViewNavigatorObserver()],
              ),
            ),
          ],
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
    controller.selectedMenuIndex.value = previousRoute?.settings.name != null
        ? int.parse(previousRoute!.settings.name!)
        : 0;
  }
}
