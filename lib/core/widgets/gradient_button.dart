import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/widgets/zoom_tap.dart";
import "package:flutter/material.dart";

class GradientButton extends StatelessWidget {
  const GradientButton({required this.onClick, required this.text, super.key});
  final Function()? onClick;
  final String text;

  @override
  Widget build(BuildContext context) => ZoomTapAnimation(
    onTap: onClick,
    child: Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: ThemeColors.primaryGradient,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ThemeColors.shadow,
            blurRadius: 25,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: StyleUtils.kTextStyleSize18Weight600(
            color: ThemeColors.whiteColor,
          ),
        ),
      ),
    ),
  );
}
