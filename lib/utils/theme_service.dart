import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collect/utils/prefernce_utils.dart';

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

    // Persist
    await PreferenceUtils.saveString(
      _key,
      themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
  }

  static bool isDark() => themeMode == ThemeMode.dark;
}
