import "package:collect/utils/colors_utils.dart";
import "package:flutter/material.dart";

class StyleUtils {
  static TextStyle kTextStyleSize35Weight600({
    Color color = ColorUtils.headingColor,
    double? letterSpacing,
  }) => TextStyle(
    color: color,
    fontSize: 35,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
    letterSpacing: letterSpacing,
  );

  static TextStyle kTextStyleSize24Weight500({
    Color color = ColorUtils.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 24,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w500,
  );

  static TextStyle kTextStyleSize14Weight600({
    Color color = ColorUtils.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 14,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
  );

  static TextStyle kTextStyleSize16Weight400({
    Color color = ColorUtils.headingColor,
    double? letterSpacing,
  }) => TextStyle(
    color: color,
    fontSize: 16,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w400,
    letterSpacing: letterSpacing,
  );
  static TextStyle kTextStyleSize16Weight600({
    Color color = ColorUtils.headingColor,
    double? letterSpacing,
  }) => TextStyle(
    color: color,
    fontSize: 16,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
    letterSpacing: letterSpacing,
  );
  static TextStyle kTextStyleSize12Weight400({
    Color color = ColorUtils.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 12,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w400,
  );

  static TextStyle kTextStyleSize18Weight400({
    Color color = ColorUtils.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 18,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w400,
  );

  static TextStyle kTextStyleSize12Weight600({
    Color color = ColorUtils.headingColor,
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
    Color color = ColorUtils.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 14,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w400,
  );

  static TextStyle kTextStyleSize24Weight600({
    Color color = ColorUtils.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 24,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
  );

  static TextStyle kTextStyleSize24Weight700({
    Color color = ColorUtils.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 24,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w700,
  );

  static TextStyle kTextStyleSize18Weight500({
    Color color = ColorUtils.themeTextColor,
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

  static TextStyle kTextStyleSize18Weight600({
    Color color = ColorUtils.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 18,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
  );

  static TextStyle kTextStyleSize17Weight400({
    Color color = ColorUtils.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 17,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w400,
  );

  static TextStyle kTextStyleSize17Weight600({
    Color color = ColorUtils.headingColor,
  }) => TextStyle(
    color: color,
    fontSize: 17,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w600,
  );
  static TextStyle titleText({Color color = ColorUtils.themeTextColor}) =>
      TextStyle(
        color: color,
        fontSize: 18,
        fontFamily: "Popins",
        fontWeight: FontWeight.w500,
      );

  static TextStyle kTextStyleSize28Weight700({
    Color color = ColorUtils.themeTextColor,
    double? lettingSpace,
  }) => TextStyle(
    color: color,
    fontSize: 28,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w700,
    letterSpacing: lettingSpace,
  );
  static TextStyle kTextStyleSize14Weight500({
    Color color = ColorUtils.themeTextColor,
  }) => TextStyle(
    color: color,
    fontSize: 14,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w500,
  );
  static TextStyle kTextStyleSize12Weight500({
    Color color = ColorUtils.themeTextColor,
  }) => TextStyle(
    color: color,
    fontSize: 12,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w500,
  );

  static TextStyle kTextStyleSize10Weight400({
    Color color = ColorUtils.themeTextColor,
  }) => TextStyle(
    color: color,
    fontSize: 10,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w400,
  );

  static InputDecoration inputDecoration({
    String? hintText,
    String? labelText,
    IconData? prefixIcon,
  }) => InputDecoration(
      hintText: hintText,
      hintStyle: StyleUtils.kTextStyleSize14Weight400(
        color: ColorUtils.greyTextColor.withValues(alpha: 0.5),
      ),
      fillColor: ColorUtils.whiteColor,
      filled: true,
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 13,
              ),
              child: Icon(
                prefixIcon,
                color: ColorUtils.greyTextColor.withValues(alpha: 0.5),
              ),
            )
          : null,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xffE4E4E7)),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xffE4E4E7)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorUtils.themeColor),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
    );

  static BoxDecoration cardView() => BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: ColorUtils.whiteColor,
    boxShadow: const <BoxShadow>[
      BoxShadow(
        color: ColorUtils.shadowHomeColor,
        blurRadius: 6,
        offset: Offset(0, 6),
      ),
    ],
  );

  static TextStyle kTextStyleSize10Weight500({
    Color color = ColorUtils.themeTextColor,
  }) => TextStyle(
    color: color,
    fontSize: 10,
    fontFamily: "Outfit",
    fontWeight: FontWeight.w500,
  );

  static BoxDecoration cardViewSmall({bool isSelected = false}) =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isSelected ? ColorUtils.themeColor : ColorUtils.whiteColor,
        boxShadow: !isSelected
            ? <BoxShadow>[]
            : const <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.10),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
                BoxShadow(
                  color: Color.fromRGBO(16, 24, 40, 0.10),
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
      );
}
