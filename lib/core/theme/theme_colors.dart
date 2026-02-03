import 'package:flutter/material.dart';
import 'package:collect/core/theme/theme_service.dart';

/// Unified centralized theme colors system
/// Combines ThemeColors with legacy ThemeColors for complete app color palette
/// Supports both light and dark themes
class ThemeColors {
  // ============================================================================
  // THEME-AWARE COLORS (Light/Dark Mode Support)
  // ============================================================================

  // CORE COLORS (used: 29 times across app)
  static Color get primary =>
      ThemeService.isDark() ? const Color(0xFF0FA394) : const Color(0xFF186063);

  static Color get onPrimary => const Color(0xFFFFFFFF);

  // SURFACE COLORS (used: 8+ times)
  static Color get surface =>
      ThemeService.isDark() ? const Color(0xFF1A2332) : const Color(0xFFFFFFFF);

  static Color get onSurface =>
      ThemeService.isDark() ? const Color(0xFFE5E7EB) : const Color(0xFF0F3F41);

  static Color get onSurfaceSecondary =>
      ThemeService.isDark() ? const Color(0xFF9CA3AF) : const Color(0xFF5E637B);

  // BORDERS & DIVIDERS (merged - same visual purpose)
  static Color get border => ThemeService.isDark()
      ? const Color(0xFF2D3E50).withValues(alpha: 0.5)
      : const Color(0xFF186063).withValues(alpha: 0.08);

  // INPUT COLORS
  static Color get inputBackground =>
      ThemeService.isDark() ? const Color(0xFF2D3E50) : const Color(0xFFF4F7FF);

  // ERROR & SUCCESS
  static Color get error => const Color(0xFFFF0000);
  static Color get success =>
      ThemeService.isDark() ? const Color(0xFF10B981) : const Color(0xFF12B76A);

  // SHADOWS (used: 3 times)
  static Color get shadow => ThemeService.isDark()
      ? Colors.black.withValues(alpha: 0.3)
      : Colors.black.withValues(alpha: 0.08);

  // DIALOG & MODAL (merged - same background)
  static Color get surfaceOverlay => ThemeService.isDark()
      ? const Color(0xFF1A2332).withValues(alpha: 0.95)
      : Colors.white.withValues(alpha: 0.95);

  static Color get surfaceOverlayBorder => ThemeService.isDark()
      ? Colors.white.withValues(alpha: 0.08)
      : primary.withValues(alpha: 0.2);

  // TEXT (used: 8+ times)
  static Color get textPrimary => onSurface;
  static Color get textSecondary => onSurfaceSecondary;

  // GRADIENTS (used: 2+ times each)
  static LinearGradient get primaryGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      primary,
      primary.withValues(alpha: ThemeService.isDark() ? 0.7 : 0.6),
    ],
  );

  static LinearGradient get scaffoldGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: ThemeService.isDark()
        ? <Color>[const Color(0xFF0F1720), const Color(0xFF131A37)]
        : <Color>[const Color(0xFFe0f7f7), Colors.white],
  );

  // ALIASES FOR COMMON USE CASES (forward compatibility)
  static Color get background => onSurface;
  static Color get cardBackground => surface;
  static Color get cardBorder => border;
  static Color get divider => border;
  static Color get inputBorder => border;
  static Color get dialogBackground => surface;
  static Color get dialogBorder => surfaceOverlayBorder;
  static Color get modalBackground => surfaceOverlay;
  static Color get modalBorder => surfaceOverlayBorder;

  // ============================================================================
  // STATIC COLORS (Legacy ThemeColors - for backward compatibility)
  // ============================================================================

  // Primary colors
  static const Color themeColor = Color(0xFF186063);
  static const Color headingColor = Color(0xFF0F3F41);
  static const Color linkColor = Color(0xFF237F82);

  // Text colors
  static const Color themeTextColor = Color(0xFF122044);
  static const Color greyTextColor = Color(0xFF5E637B);
  static const Color hintTextColor = Color(0xFF949494);
  static const Color disabledTextColor = Color(0xFFA3BCBC);
  static const Color greyLightTextColor = Color(0xFFBAC0CF);
  static const Color greyMenuTextColor = Color(0xFFBAC0CF);

  // Background & Surface colors
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color black = Color(0xFF000000);
  static const Color bgColor = Color(0xFFF4F7FF);
  static const Color scaffoldColor = Color(0xFFe0f7f7);
  static const Color appBgMain = Color(0xFFFFFFFF);
  static const Color shadowHomeColor = Color(0xFFEBEFF6);

  // Border & UI elements
  static const Color borderColor = Color(0xFFEFEFF4);
  static const Color secondaryColor = Color(0xffbaad8c);
  static const Color backgroundDark = Color(0xFF25254B);
  static const Color metallicColor = Color(0xFFD4AF37);

  // Status & semantic colors
  static const Color completedColor = Color(0xFF12B76A);
  static const Color red = Color(0xFFFF0000);

  // Custom colors
  static const Color darkGray = Color(0xff131A37);
  static const Color indigoBlueColor = Color(0xFF566ECF);
  static const Color green = Color(0xff133714);
  static const Color darkBlue = Color(0xff364B63);
  static const Color darkGreen = Color(0xff12673F);
  static const Color orange = Color(0xffFF7E40);
  static const Color lightGreen = Color(0xffDEF1F1);
}
