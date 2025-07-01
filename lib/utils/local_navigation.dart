import "package:collect/views/completed_task/completed_task.dart";
import "package:collect/views/dashboard/dashboard_screen.dart";
import "package:collect/views/profile/profile_screen.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

enum Destination {
  dashboard,
  completedTasks,
  profile;

  String get route => '/${toString().split('.').last}';

  Widget get widget {
    switch (this) {
      case Destination.dashboard:
        return DashboardScreen();
      case Destination.completedTasks:
        return CompletedTask();
      case Destination.profile:
        return const ProfileScreen();
    }
  }

  static Route? getPage(RouteSettings settings) {
    final Destination? destination = Destination.values.firstWhereOrNull(
      (Destination e) => e.route == settings.name,
    );

    if (destination == null) return null;

    return PageRouteBuilder(
      settings: settings,
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => destination.widget,
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) => FadeTransition(opacity: animation, child: child),
    );
  }
}
