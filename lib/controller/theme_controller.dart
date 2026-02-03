import 'package:collect/utils/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  late Rx<ThemeMode> selectedMode;

  @override
  void onInit() {
    super.onInit();
    selectedMode = ThemeService.themeMode.obs;
  }

  Future<void> updateTheme(ThemeMode mode) async {
    if (selectedMode.value == mode) return;
    selectedMode.value = mode;
    await ThemeService.setThemeMode(mode);
  }

  String getThemeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return 'dark'.tr;
      case ThemeMode.light:
        return 'light'.tr;
      case ThemeMode.system:
        return 'system'.tr;
    }
  }

  IconData getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return Icons.dark_mode_rounded;
      case ThemeMode.light:
        return Icons.light_mode_rounded;
      case ThemeMode.system:
        return Icons.brightness_auto_rounded;
    }
  }
}
