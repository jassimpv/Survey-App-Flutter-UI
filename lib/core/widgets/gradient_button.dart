import "package:collect/core/utils/colors_utils.dart";
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
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[ColorUtils.themeColor, Color(0xFF1E8F87)],
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(16, 24, 40, 0.20),
            blurRadius: 25,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: StyleUtils.kTextStyleSize18Weight600(color: Colors.white),
        ),
      ),
    ),
  );
}
