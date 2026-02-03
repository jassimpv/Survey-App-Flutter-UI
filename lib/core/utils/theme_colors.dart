import 'package:flutter/material.dart';
import 'package:collect/core/utils/theme_service.dart';
import 'package:collect/core/utils/colors_utils.dart';

class ThemeColors {
  static Color get primary =>
      ThemeService.isDark() ? const Color(0xFF0FA394) : ColorUtils.themeColor;

  static Color get background =>
      ThemeService.isDark() ? const Color(0xFF0F1720) : ColorUtils.appBgMain;

  static Color get surface =>
      ThemeService.isDark() ? const Color(0xFF1A2332) : Colors.white;

  static Color get onSurface =>
      ThemeService.isDark() ? const Color(0xFFE5E7EB) : ColorUtils.headingColor;

  static Color get onSurfaceSecondary => ThemeService.isDark()
      ? const Color(0xFF9CA3AF)
      : ColorUtils.greyTextColor;

  static Color get cardBackground =>
      ThemeService.isDark() ? const Color(0xFF1E2A3A) : Colors.white;

  static Color get cardBorder => ThemeService.isDark()
      ? const Color(0xFF2D3E50).withValues(alpha: 0.5)
      : ColorUtils.themeColor.withValues(alpha: 0.08);

  static Color get divider => ThemeService.isDark()
      ? const Color(0xFF2D3E50)
      : ColorUtils.themeColor.withValues(alpha: 0.08);

  static Color get scaffoldBackground =>
      ThemeService.isDark() ? const Color(0xFF0F1720) : const Color(0xFFe0f7f7);

  static Color get accentGreen =>
      ThemeService.isDark() ? const Color(0xFF12B76A) : ColorUtils.darkGreen;

  static Color get accentGold => ThemeService.isDark()
      ? const Color(0xFFD4A574)
      : ColorUtils.metallicColor;

  static Color get shadow => ThemeService.isDark()
      ? Colors.black.withValues(alpha: 0.3)
      : Colors.black.withValues(alpha: 0.08);

  static Color get inputBackground =>
      ThemeService.isDark() ? const Color(0xFF2D3E50) : const Color(0xFFF4F7FF);

  static Color get error => ColorUtils.red;

  static Color get success => ThemeService.isDark()
      ? const Color(0xFF10B981)
      : ColorUtils.completedColor;

  static LinearGradient get primaryGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      primary,
      primary.withValues(alpha: ThemeService.isDark() ? 0.7 : 0.6),
    ],
  );
}
