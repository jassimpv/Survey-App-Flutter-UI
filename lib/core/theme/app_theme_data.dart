import 'package:flutter/material.dart';

class AppThemeData {
  // Light Theme Colors
  static const Color _lightPrimary = Color(0xFF186063);
  static const Color _lightBackground = Color(0xFFFFFFFF);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightSurfaceVariant = Color(0xFFe0f7f7);
  static const Color _lightOnPrimary = Color(0xFFFFFFFF);
  static const Color _lightOnSurface = Color(0xFF0F3F41);
  static const Color _lightOnSurfaceVariant = Color(0xFF5E637B);
  static const Color _lightOutline = Color(0xFFEFEFF4);
  static const Color _lightError = Color(0xFFFF0000);

  // Dark Theme Colors
  static const Color _darkPrimary = Color(0xFF0FA394);
  static const Color _darkBackground = Color(0xFF0F1720);
  static const Color _darkSurface = Color(0xFF1A2332);
  static const Color _darkSurfaceVariant = Color(0xFF2D3E50);
  static const Color _darkOnPrimary = Color(0xFFFFFFFF);
  static const Color _darkOnSurface = Color(0xFFE5E7EB);
  static const Color _darkOnSurfaceVariant = Color(0xFF9CA3AF);
  static const Color _darkOutline = Color(0xFF2D3E50);
  static const Color _darkError = Color(0xFFFF0000);

  static ThemeData lightTheme(BuildContext context) => ThemeData(
    fontFamily: "Outfit",
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: _lightPrimary,
    scaffoldBackgroundColor: _lightBackground,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _lightPrimary,
      onPrimary: _lightOnPrimary,
      primaryContainer: Color(0xFFD0ECEB),
      onPrimaryContainer: Color(0xFF0D2B2C),
      secondary: Color(0xFF186063),
      onSecondary: Color(0xFFFFFFFF),
      tertiary: Color(0xFF0FA394),
      onTertiary: Color(0xFFFFFFFF),
      error: _lightError,
      onError: Color(0xFFFFFFFF),
      background: _lightBackground,
      onBackground: _lightOnSurface,
      surface: _lightSurface,
      onSurface: _lightOnSurface,
      surfaceVariant: _lightSurfaceVariant,
      onSurfaceVariant: _lightOnSurfaceVariant,
      outline: _lightOutline,
    ),
    textTheme: Theme.of(context).textTheme.apply(
      bodyColor: _lightOnSurface,
      displayColor: _lightOnSurface,
      fontFamily: "Outfit",
    ),
    dialogBackgroundColor: _lightSurface,
    cardColor: _lightSurface,
    dividerColor: _lightOutline,
  );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
    fontFamily: "Outfit",
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: _darkPrimary,
    scaffoldBackgroundColor: _darkBackground,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: _darkPrimary,
      onPrimary: _darkOnPrimary,
      primaryContainer: Color(0xFF0B5751),
      onPrimaryContainer: Color(0xFF7FF7F0),
      secondary: Color(0xFF80CCBB),
      onSecondary: Color(0xFF004138),
      tertiary: Color(0xFF0FA394),
      onTertiary: Color(0xFFFFFFFF),
      error: _darkError,
      onError: Color(0xFFFFFFFF),
      background: _darkBackground,
      onBackground: _darkOnSurface,
      surface: _darkSurface,
      onSurface: _darkOnSurface,
      surfaceVariant: _darkSurfaceVariant,
      onSurfaceVariant: _darkOnSurfaceVariant,
      outline: _darkOutline,
    ),
    textTheme: Theme.of(context).textTheme.apply(
      bodyColor: _darkOnSurface,
      displayColor: _darkOnSurface,
      fontFamily: "Outfit",
    ),
    dialogBackgroundColor: _darkSurface,
    cardColor: _darkSurface,
    dividerColor: _darkOutline,
  );
}
