import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collect/core/utils/prefernce_utils.dart';

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
    } else if (stored == 'dark') {
      themeMode = ThemeMode.dark;
    } else if (stored == 'system') {
      themeMode = ThemeMode.system;
    }
    themeModeNotifier.value = themeMode;
  }

  static Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    themeModeNotifier.value = themeMode;

    // Apply immediately
    Get.changeThemeMode(themeMode);

    // Persist
    String modeString = 'light';
    if (mode == ThemeMode.dark) {
      modeString = 'dark';
    } else if (mode == ThemeMode.system) {
      modeString = 'system';
    }
    await PreferenceUtils.saveString(_key, modeString);
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
