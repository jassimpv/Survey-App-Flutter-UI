import 'package:collect/routes.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:collect/views/widget/language_widget.dart';
import 'package:collect/views/widget/zoom_tap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Function()? onBackPressed;
  final Widget? tabBar;
  final bool isNotificationButton;
  final bool isLanguageButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.isNotificationButton = true,
    this.isLanguageButton = false,
    this.tabBar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        color: ColorUtils.themeColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediaQuery.viewPaddingOf(context).top.heightBox,
            22.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      child: Center(
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
                  children: [
                    if (isLanguageButton) ...[LanguageWidegt()],
                    8.widthBox,
                    if (isNotificationButton) ...[
                      _buildNotificationBadge(),
                    ] else ...[
                      SizedBox.shrink(),
                    ],
                  ],
                ),
              ],
            ),
            if (tabBar != null) ...[16.heightBox, tabBar!],
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationBadge() {
    return ZoomTapAnimation(
      onTap: () {
        Get.toNamed(AppRouter.notificationScreen);
      },
      child: Badge.count(
        count: 0,
        isLabelVisible: true,
        backgroundColor: ColorUtils.metallicColor.withValues(alpha: 0.80),
        child: CircleAvatar(
          radius: 22,
          backgroundColor: ColorUtils.whiteColor.withValues(alpha: 0.10),
          foregroundColor: ColorUtils.whiteColor.withValues(alpha: 0.10),
          child: Icon(
            CupertinoIcons.bell,
            color: ColorUtils.whiteColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
