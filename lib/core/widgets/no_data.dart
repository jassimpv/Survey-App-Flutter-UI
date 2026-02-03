import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/widgets/zoom_tap.dart";
import "package:flutter/material.dart";

class NoData extends StatelessWidget {
  const NoData({
    required this.text,
    required this.withImage,
    required this.subText,
    required this.buttonText,
    super.key,
    this.onTap,
    this.isLoading = false,
  });
  final String text;
  final bool withImage;
  final String subText;
  final String buttonText;
  final Function()? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/icons/register_success.png"),
        Text(
          text,
          style: StyleUtils.kTextStyleSize24Weight500(
            color: ThemeColors.themeColor,
          ),
        ),
        15.heightBox,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            subText,
            style: StyleUtils.kTextStyleSize16Weight400(
              color: ThemeColors.themeColor.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        30.heightBox,
        if (isLoading)
          const CircularProgressIndicator(color: ThemeColors.themeColor)
        else
          SizedBox(
            width: 277,
            height: 50,
            child: ZoomTapAnimation(
              onTap: onTap,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: ThemeColors.themeColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.bluetooth, color: ThemeColors.whiteColor),
                    5.widthBox,
                    Text(
                      buttonText,
                      style: StyleUtils.kTextStyleSize18Weight400(
                        color: ThemeColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
