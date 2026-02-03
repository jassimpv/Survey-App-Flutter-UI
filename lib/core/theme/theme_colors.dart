import 'package:flutter/material.dart';
import 'package:collect/core/theme/theme_service.dart';

/// Optimized centralized theme colors - minimal, essential colors only
/// Merges redundant getters and removes unused declarations
class ThemeColors {
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
}
