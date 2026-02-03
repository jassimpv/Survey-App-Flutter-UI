import 'package:flutter/material.dart';
import 'package:collect/core/theme/theme_service.dart';

/// Unified centralized theme colors system
/// Combines ThemeColors with legacy ThemeColors for complete app color palette
/// Supports both light and dark themes
class ThemeColors {
  // ============================================================================
  // LIGHT THEME COLORS (Constants)
  // ============================================================================
  static const Color _lightPrimary = Color(0xFF186063);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightOnSurface = Color(0xFF0F3F41);
  static const Color _lightOnSurfaceSecondary = Color(0xFF5E637B);
  static const Color _lightInputBackground = Color(0xFFF4F7FF);
  static const Color _lightBorder = Color(
    0xFF186063,
  ); // with 0.08 alpha in getter
  static const Color _lightScaffold = Color(0xFFFFFFFF);
  static const Color _lightScaffoldGradientStart = Color(0xFFe0f7f7);
  static const Color _lightScaffoldGradientEnd = Color(0xFFFFFFFF);

  // ============================================================================
  // DARK THEME COLORS (Constants)
  // ============================================================================
  static const Color _darkPrimary = Color(0xFF0FA394);
  static const Color _darkSurface = Color(0xFF1A2332);
  static const Color _darkOnSurface = Color(0xFFE5E7EB);
  static const Color _darkOnSurfaceSecondary = Color(0xFF9CA3AF);
  static const Color _darkInputBackground = Color(0xFF2D3E50);
  static const Color _darkBorder = Color(
    0xFF2D3E50,
  ); // with 0.5 alpha in getter
  static const Color _darkScaffold = Color(0xFF131A37);
  static const Color _darkScaffoldGradientStart = Color(0xFF0F1720);
  static const Color _darkScaffoldGradientEnd = Color(0xFF131A37);
  static const Color _darkSurfaceOverlay = Color(0xFF1A2332);

  // ============================================================================
  // SEMANTIC COLORS (Universal)
  // ============================================================================
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color error = Color(0xFFFF0000);
  static const Color completedColor = Color(0xFF12B76A);
  static const Color metallicColor = Color(0xFFD4AF37);

  // DARK MODE SUCCESS - Light mode uses completedColor
  static const Color _darkSuccess = Color(0xFF10B981);

  // ============================================================================
  // STATUS & SEMANTIC COLORS
  // ============================================================================
  static const Color statusPurple = Color(0xffA88FF3);
  static const Color statusYellow = Color(0xffECEC00);
  static const Color statusGreen = Color(0xff12B76A);
  static const Color statusGray = Color(0xff5B5B77);

  // ============================================================================
  // CUSTOM PALETTE COLORS
  // ============================================================================
  static const Color indigoBlueColor = Color(0xFF566ECF);
  static const Color orange = Color(0xffFF7E40);
  static const Color green = Color(0xff133714);
  static const Color darkBlue = Color(0xff364B63);
  static const Color darkGreen = Color(0xff12673F);
  static const Color lightGreen = Color(0xffDEF1F1);
  static const Color secondaryColor = Color(0xffbaad8c);

  // ============================================================================
  // DEPRECATED LEGACY COLORS (Kept for backward compatibility)
  // ============================================================================
  static const Color themeColor = _lightPrimary;
  static const Color headingColor = _lightOnSurface;
  static const Color linkColor = Color(0xFF237F82);
  static const Color themeTextColor = Color(0xFF122044);
  static const Color greyTextColor = _lightOnSurfaceSecondary;
  static const Color hintTextColor = Color(0xFF949494);
  static const Color disabledTextColor = Color(0xFFA3BCBC);
  static const Color greyLightTextColor = Color(0xFFBAC0CF);
  static const Color bgColor = _lightInputBackground;
  static const Color appBgMain = whiteColor;
  static const Color shadowHomeColor = Color(0xFFEBEFF6);
  static const Color borderColor = Color(0xFFEFEFF4);
  static const Color backgroundDark = Color(0xFF25254B);
  static const Color darkGray = Color(0xff131A37);

  // ============================================================================
  // THEME-AWARE DYNAMIC COLORS (Light/Dark Mode Support)
  // ============================================================================

  // CORE COLORS
  static Color get primary =>
      ThemeService.isDark() ? _darkPrimary : _lightPrimary;
  static const Color onPrimary = whiteColor;
  static Color get blackWhite =>
      ThemeService.isDark() ? whiteColor : blackColor;
  static Color get whitePrimary =>
      ThemeService.isDark() ? whiteColor : _lightPrimary;

  static Color get primaryWhite =>
      ThemeService.isDark() ? _lightPrimary : whiteColor;

  static Color get refreshIndicatorColor =>
      ThemeService.isDark() ? _darkSurface : _lightPrimary;
  // SURFACE COLORS
  static Color get surface =>
      ThemeService.isDark() ? _darkSurface : _lightSurface;
  static Color get onSurface =>
      ThemeService.isDark() ? _darkOnSurface : _lightOnSurface;
  static Color get onSurfaceSecondary => ThemeService.isDark()
      ? _darkOnSurfaceSecondary
      : _lightOnSurfaceSecondary;
  static Color get scaffoldColor =>
      ThemeService.isDark() ? _darkScaffold : _lightScaffold;
  static Color get inputBackground =>
      ThemeService.isDark() ? _darkInputBackground : _lightInputBackground;

  // BORDERS & DIVIDERS
  static Color get border => ThemeService.isDark()
      ? _darkBorder.withValues(alpha: 0.5)
      : _lightBorder.withValues(alpha: 0.08);

  // STATUS COLORS
  static Color get success =>
      ThemeService.isDark() ? _darkSuccess : completedColor;

  // SHADOWS
  static Color get shadow => ThemeService.isDark()
      ? blackColor.withValues(alpha: 0.3)
      : blackColor.withValues(alpha: 0.08);

  // DIALOG & MODAL
  static Color get surfaceOverlay => ThemeService.isDark()
      ? _darkSurfaceOverlay.withValues(alpha: 0.95)
      : whiteColor.withValues(alpha: 0.95);

  static Color get surfaceOverlayBorder => ThemeService.isDark()
      ? whiteColor.withValues(alpha: 0.08)
      : primary.withValues(alpha: 0.2);

  // TEXT
  static Color get textPrimary => onSurface;
  static Color get textSecondary => onSurfaceSecondary;

  // ============================================================================
  // GRADIENTS
  // ============================================================================

  static Gradient get surfaceGradient => ThemeService.isDark()
      ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_darkSurface, _darkScaffold],
        )
      : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_lightSurface, _lightInputBackground],
        );

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
        ? const <Color>[_darkScaffoldGradientStart, _darkScaffoldGradientEnd]
        : const <Color>[_lightScaffoldGradientStart, _lightScaffoldGradientEnd],
  );

  static const LinearGradient appBarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF0FA394), Color(0xFF0A7A6E), Color(0xFF0F1720)],
    stops: <double>[0, 0.55, 1],
  );

  static const LinearGradient bottomNavGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFF0FA394), Color(0xFF0A7A6E)],
  );

  // ============================================================================
  // COMMON ALIASES (forward compatibility)
  // ============================================================================
  static Color get background => onSurface;
  static Color get cardBackground => surface;
  static Color get cardBorder => border;
  static Color get divider => border;
  static Color get inputBorder => border;
  static Color get dialogBackground => surface;
  static Color get dialogBorder => surfaceOverlayBorder;
  static Color get modalBackground => surfaceOverlay;
  static Color get modalBorder => surfaceOverlayBorder;
}
