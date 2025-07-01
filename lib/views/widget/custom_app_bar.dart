import "package:collect/routes.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/sized_box_extension.dart";
import "package:collect/utils/textstyle_input.dart";
import "package:collect/views/widget/language_widget.dart";
import "package:collect/views/widget/zoom_tap.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.title,
    super.key,
    this.onBackPressed,
    this.isNotificationButton = true,
    this.isLanguageButton = false,
    this.tabBar,
  });
  final String title;
  final Function()? onBackPressed;
  final Widget? tabBar;
  final bool isNotificationButton;
  final bool isLanguageButton;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(bottom: 16),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      color: ColorUtils.themeColor,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MediaQuery.viewPaddingOf(context).top.heightBox,
          22.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (onBackPressed != null)
                ZoomTapAnimation(
                  onTap: onBackPressed,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(CupertinoIcons.back, color: Colors.white),
                    ),
                  ),
                ),
              Text(
                title,
                style: StyleUtils.kTextStyleSize18Weight400(
                  color: Colors.white,
                ),
              ),
              Row(
                children: <Widget>[
                  if (isLanguageButton) ...<Widget>[const LanguageWidegt()],
                  8.widthBox,
                  if (isNotificationButton) ...<Widget>[
                    _buildNotificationBadge(),
                  ] else ...<Widget>[const SizedBox.shrink()],
                ],
              ),
            ],
          ),
          if (tabBar != null) ...<Widget>[16.heightBox, tabBar!],
        ],
      ),
    ),
  );

  Widget _buildNotificationBadge() => ZoomTapAnimation(
    onTap: () {
      Get.toNamed(AppRouter.notificationScreen);
    },
    child: Badge.count(
      count: 0,
      backgroundColor: ColorUtils.metallicColor.withValues(alpha: 0.80),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: ColorUtils.whiteColor.withValues(alpha: 0.10),
        foregroundColor: ColorUtils.whiteColor.withValues(alpha: 0.10),
        child: const Icon(
          CupertinoIcons.bell,
          color: ColorUtils.whiteColor,
          size: 30,
        ),
      ),
    ),
  );
}
