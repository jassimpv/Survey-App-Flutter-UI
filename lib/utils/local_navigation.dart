import 'package:collect/views/completed_task/completed_task.dart';
import 'package:collect/views/dashboard/dashboard_screen.dart';
import 'package:collect/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        return ProfileScreen();
    }
  }

  static Route? getPage(RouteSettings settings) {
    final destination = Destination.values.firstWhereOrNull(
      (e) => e.route == settings.name,
    );

    if (destination == null) return null;

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          destination.widget,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
