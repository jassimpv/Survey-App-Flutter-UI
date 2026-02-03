import "package:collect/features/home/controller/home_controller.dart";
import "package:collect/routes.dart";
import "package:collect/core/utils/asset_utils.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/theme/theme_service.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/utils/utils_helper.dart";
import "package:collect/core/widgets/language_widget.dart";
import "package:collect/core/widgets/zoom_tap.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class HomeHeader extends GetView<HomeController> {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) => Hero(
    tag: "appBar",
    child: Container(
      decoration: BoxDecoration(
        gradient: ThemeColors.appBarGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: ThemeService.isDark()
                ? ThemeColors.blackColor.withValues(alpha: 0.4)
                : ThemeColors.themeColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          MediaQuery.viewPaddingOf(context).top.heightBox,
          20.heightBox,
          _buildHeaderRow(context),
          20.heightBox,
        ],
      ),
    ),
  );

  Widget _buildHeaderRow(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: <Widget>[
        // Left: profile
        _buildProfileImage(),
        12.widthBox,

        // Middle: greeting + name (compact)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Utils.getGreeting(),
                style: StyleUtils.kTextStyleSize14Weight500(
                  color: ThemeColors.whiteColor.withValues(alpha: 0.95),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              4.heightBox,
              Text(
                "Mohammed Jassim",
                style: StyleUtils.kTextStyleSize16Weight600(
                  color: ThemeColors.whiteColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // Right: actions (language + notifications) inside a subtle pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: ThemeColors.whiteColor.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: <Widget>[
              LanguageWidegt(),
              8.widthBox,
              _buildNotificationBadge(),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildProfileImage() => Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: ThemeColors.blackColor.withValues(alpha: 0.15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: CircleAvatar(
      backgroundColor: ThemeColors.surface,
      radius: 30,
      child: Image.asset(
        AssetUtils.getDummyImage("pp.webp"),
        width: 56,
        height: 56,
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) =>
                Image.asset(
                  AssetUtils.getIcons("ic_profile"),
                  fit: BoxFit.contain,
                  width: 56,
                  height: 56,
                ),
      ),
    ),
  );

  Widget _buildNotificationBadge() => ZoomTapAnimation(
    onTap: () {
      Get.toNamed(AppRouter.notificationScreen);
    },
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: ThemeColors.blackColor.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Badge.count(
        count: 0,
        backgroundColor: ThemeColors.secondaryColor,
        child: CircleAvatar(
          radius: 22,
          backgroundColor: ThemeColors.inputBackground,
          child: const Icon(
            CupertinoIcons.bell,
            color: ThemeColors.whiteColor,
            size: 26,
          ),
        ),
      ),
    ),
  );
}
