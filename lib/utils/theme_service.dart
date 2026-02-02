import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collect/utils/prefernce_utils.dart';
import 'package:collect/utils/colors_utils.dart';

class ThemeService {
  static const String _key = 'themeMode';

  static late ThemeMode themeMode;
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  static Future<void> init() async {
    final String? stored = await PreferenceUtils.getString(_key);
    if (stored == null || stored == 'light') {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    themeModeNotifier.value = themeMode;
  }

  static Future<void> toggleTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }

    themeModeNotifier.value = themeMode;

    // Apply immediately
    Get.changeThemeMode(themeMode);

    // Notify user with a subtle snackbar
    final String message = themeMode == ThemeMode.dark
        ? 'Dark mode enabled'
        : 'Light mode enabled';
    Get.snackbar(
      '',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: themeMode == ThemeMode.dark
          ? ColorUtils.darkGreen
          : Colors.white,
      colorText: themeMode == ThemeMode.dark
          ? Colors.white
          : ColorUtils.backgroundDark,
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      duration: const Duration(seconds: 2),
    );

    // Persist
    await PreferenceUtils.saveString(
      _key,
      themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
  }

  static bool isDark() => themeMode == ThemeMode.dark;
}
