import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/textstyle_input.dart";
import "package:collect/views/widget/zoom_tap.dart";
import "package:flutter/material.dart";

class GradientButton extends StatelessWidget {
  const GradientButton({required this.onClick, required this.text, super.key});
  final Function()? onClick;
  final String text;

  @override
  Widget build(BuildContext context) => ZoomTapAnimation(
    onTap: onClick,
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          transform: GradientRotation(55 * 3.14159 / 180),
          colors: <Color>[ColorUtils.themeColor, Color(0xFF1e7d7d)],
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: StyleUtils.kTextStyleSize18Weight400(color: Colors.white),
        ),
      ),
    ),
  );
}
