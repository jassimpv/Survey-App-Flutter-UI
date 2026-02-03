import "package:collect/core/theme/theme_service.dart";
import "package:collect/routes.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/widgets/language_widget.dart";
import "package:collect/core/widgets/zoom_tap.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.title,
    super.key,
    this.onBackPressed,
    this.isNotificationButton = false,
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
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      gradient: ThemeService.isDark()
          ? ThemeColors.surfaceGradient
          : ThemeColors.appBarGradient,
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
                      color: ThemeColors.whiteColor.withValues(alpha: 0.20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.back,
                        color: ThemeColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              Text(
                title,
                style: StyleUtils.kTextStyleSize20Weight600(
                  color: ThemeColors.whiteColor,
                ),
              ),
              Row(
                children: <Widget>[
                  if (isLanguageButton) ...<Widget>[LanguageWidegt()],
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
      backgroundColor: ThemeColors.metallicColor.withValues(alpha: 0.80),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: ThemeColors.whiteColor.withValues(alpha: 0.10),
        foregroundColor: ThemeColors.whiteColor.withValues(alpha: 0.10),
        child: const Icon(
          CupertinoIcons.bell,
          color: ThemeColors.whiteColor,
          size: 30,
        ),
      ),
    ),
  );
}
