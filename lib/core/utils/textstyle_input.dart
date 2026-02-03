import "package:collect/core/theme/theme_colors.dart";
import "package:flutter/material.dart";

class StyleUtils {
  static TextStyle kTextStyleSize35Weight600({
    Color color = ThemeColors.headingColor,
    double? letterSpacing,
  }) => TextStyle(
    color: color,
    fontSize: 35,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
    letterSpacing: letterSpacing,
  );

  static TextStyle kTextStyleSize24Weight500({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 24,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w500,
  );

  static TextStyle kTextStyleSize14Weight600({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 14,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
  );

  static TextStyle kTextStyleSize16Weight400({
    Color color = ThemeColors.headingColor,
    double? letterSpacing,
  }) => TextStyle(
    color: color,
    fontSize: 16,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w400,
    letterSpacing: letterSpacing,
  );
  static TextStyle kTextStyleSize16Weight600({
    Color color = ThemeColors.headingColor,
    double? letterSpacing,
  }) => TextStyle(
    color: color,
    fontSize: 16,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
    letterSpacing: letterSpacing,
  );
  static TextStyle kTextStyleSize12Weight400({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 12,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w400,
  );

  static TextStyle kTextStyleSize18Weight400({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 18,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w400,
  );

  static TextStyle kTextStyleSize12Weight600({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 12,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
  );

  static TextStyle kTextStyleSize20Weight500({Color? color}) => TextStyle(
    color: color,
    fontSize: 20,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w500,
  );

  static TextStyle kTextStyleSize14Weight400({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 14,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w400,
  );

  static TextStyle kTextStyleSize24Weight600({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 24,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
  );

  static TextStyle kTextStyleSize24Weight700({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 24,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w700,
  );

  static TextStyle kTextStyleSize18Weight500({
    Color color = ThemeColors.themeTextColor,
    bool isUnderline = false,
    double? letterSpacing,
  }) => TextStyle(
    color: color,
    fontSize: 18,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w500,
    decoration: isUnderline ? TextDecoration.underline : null,
    letterSpacing: letterSpacing,
  );

  static TextStyle kTextStyleSize54Weight600({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 54,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
  );

  static TextStyle kTextStyleSize18Weight600({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 18,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
  );

  static TextStyle kTextStyleSize20Weight600({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 20,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
  );

  static TextStyle kTextStyleSize17Weight400({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 17,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w400,
  );

  static TextStyle kTextStyleSize17Weight600({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 17,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
  );
  static TextStyle titleText({Color color = ThemeColors.themeTextColor}) =>
      TextStyle(
        color: color,
        fontSize: 18,
        fontFamily: "Outfit",
        fontWeight: FontWeight.w500,
      );

  static TextStyle kTextStyleSize28Weight700({
    Color color = ThemeColors.themeTextColor,
    double? lettingSpace,
  }) => TextStyle(
    color: color,
    fontSize: 28,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w700,
    letterSpacing: lettingSpace,
  );
  static TextStyle kTextStyleSize14Weight500({
    Color color = ThemeColors.themeTextColor,
  }) => TextStyle(
    color: color,
    fontSize: 14,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w500,
  );
  static TextStyle kTextStyleSize12Weight500({
    Color color = ThemeColors.themeTextColor,
  }) => TextStyle(
    color: color,
    fontSize: 12,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w500,
  );

  static TextStyle kTextStyleSize10Weight400({
    Color color = ThemeColors.themeTextColor,
  }) => TextStyle(
    color: color,
    fontSize: 10,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w400,
  );
  static TextStyle kTextStyleSize16Weight500({
    Color color = ThemeColors.headingColor,
    double? letterSpacing,
  }) => TextStyle(
    color: color,
    fontSize: 16,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w500,
    letterSpacing: letterSpacing,
  );
  static InputDecoration inputDecoration({
    String? hintText,
    String? labelText,
    IconData? prefixIcon,
  }) => InputDecoration(
    hintText: hintText,
    hintStyle: StyleUtils.kTextStyleSize14Weight400(
      color: ThemeColors.greyTextColor.withValues(alpha: 0.5),
    ),
    fillColor: ThemeColors.whiteColor,
    filled: true,
    prefixIcon: prefixIcon != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
            child: Icon(
              prefixIcon,
              color: ThemeColors.greyTextColor.withValues(alpha: 0.5),
            ),
          )
        : null,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: ThemeColors.border),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ThemeColors.border),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: ThemeColors.themeColor),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ThemeColors.error),
      borderRadius: BorderRadius.circular(8),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
  );

  static BoxDecoration cardView() => BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: ThemeColors.whiteColor,
    boxShadow: const <BoxShadow>[
      BoxShadow(
        color: ThemeColors.shadowHomeColor,
        blurRadius: 6,
        offset: Offset(0, 6),
      ),
    ],
  );

  static TextStyle kTextStyleSize10Weight500({
    Color color = ThemeColors.themeTextColor,
  }) => TextStyle(
    color: color,
    fontSize: 10,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w500,
  );

  static BoxDecoration cardViewSmall({bool isSelected = false}) =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isSelected ? ThemeColors.themeColor : ThemeColors.whiteColor,
        boxShadow: !isSelected
            ? <BoxShadow>[]
            : <BoxShadow>[
                BoxShadow(
                  color: ThemeColors.shadow,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
                BoxShadow(
                  color: ThemeColors.shadow,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
      );

  // OTP & Input Styles
  static TextStyle kTextStyleOtpPasted() => TextStyle(
    color: ThemeColors.statusGreen,
    fontWeight: FontWeight.bold,
    fontFamily: "Outfit",
  );

  static TextStyle kTextStyleOtpInput({double fontSize = 16}) => TextStyle(
    fontSize: fontSize,
    height: 1.2,
    fontWeight: FontWeight.w600,
    fontFamily: "Outfit",
  );

  // Theme Widget Style
  static TextStyle kTextStyleThemeMode({
    Color color = ThemeColors.themeColor,
  }) => TextStyle(
    color: color,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    fontFamily: "Outfit",
  );

  // Language Widget Style
  static TextStyle kTextStyleLanguageBadge() => TextStyle(
    color: ThemeColors.whiteColor.withValues(alpha: 0.9),
    fontSize: 10,
    fontWeight: FontWeight.w700,
    fontFamily: "Outfit",
  );

  // Terms and Conditions Title
  static TextStyle kTextStyleTermsTitle() => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: "Outfit",
    color: ThemeColors.headingColor,
  );

  // Date Answer View Style
  static TextStyle kTextStyleDateDisplay() => TextStyle(
    fontSize: 28.0,
    color: ThemeColors.whiteColor,
    fontFamily: "Outfit",
  );

  // Survey App Bar Style
  static TextStyle kTextStyleSurveyAppBar() =>
      TextStyle(color: ThemeColors.whiteColor, fontFamily: "Outfit");

  // Step View Style
  static TextStyle kTextStyleStepView({
    Color color = ThemeColors.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: "Outfit",
  );

  // Scale Answer View Styles
  static TextStyle kTextStyleScaleAnswer() =>
      TextStyle(fontSize: 16.0, fontFamily: "Outfit");

  // Pull to Refresh Indicator Style
  static TextStyle kTextStyleRefreshIndicator() =>
      const TextStyle(color: ThemeColors.greyTextColor, fontFamily: "Outfit");

  // Dialog & Menu Title Style
  static TextStyle kTextStyleDialogTitle() => TextStyle(
    color: ThemeColors.headingColor,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: "Outfit",
  );

  // Menu Item Style
  static TextStyle kTextStyleMenuItemLabel() => TextStyle(
    color: ThemeColors.headingColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: "Outfit",
  );

  // Body Text Style for content/description
  static TextStyle kTextStyleBodyText() => TextStyle(
    color: ThemeColors.themeTextColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: "Outfit",
  );
}
