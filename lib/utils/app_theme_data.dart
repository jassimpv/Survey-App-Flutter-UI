import 'package:collect/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
    fontFamily: "Outfit",
    primaryColor: ColorUtils.themeColor,
    scaffoldBackgroundColor: ColorUtils.appBgMain,
    brightness: Brightness.light,
    textTheme: Theme.of(context).textTheme.apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
      fontFamily: "Outfit",
    ),
  );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
    fontFamily: "Outfit",
    primaryColor: ColorUtils.themeColor,
    scaffoldBackgroundColor: const Color(0xFF0F1720),
    brightness: Brightness.dark,
    textTheme: Theme.of(context).textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
      fontFamily: "Outfit",
    ),
  );
}
