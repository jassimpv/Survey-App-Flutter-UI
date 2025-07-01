import "package:collect/controller/home_controller.dart";
import "package:collect/routes.dart";
import "package:collect/utils/asset_utils.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/sized_box_extension.dart";
import "package:collect/utils/textstyle_input.dart";
import "package:collect/utils/utils_helper.dart";
import "package:collect/views/widget/language_widget.dart";
import "package:collect/views/widget/zoom_tap.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class HomeHeader extends GetView<HomeController> {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) => Hero(
      tag: "appBar",
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: ColorUtils.themeColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: <Widget>[
            MediaQuery.viewPaddingOf(context).top.heightBox,
            16.heightBox,
            _buildHeaderRow(context),
            10.heightBox,
          ],
        ),
      ),
    );

  Widget _buildHeaderRow(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          _buildProfileImage(),
          12.widthBox,
          _buildWelcomeText(),
          Row(
            children: <Widget>[const LanguageWidegt(), 8.widthBox, _buildNotificationBadge()],
          ),
        ],
      ),
    );

  Widget _buildProfileImage() => CircleAvatar(
      backgroundColor: ColorUtils.whiteColor,
      radius: 28,
      child: Image.asset(
        AssetUtils.getDummyImage("pp.webp"),
        width: 50,
        height: 50,
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => Image.asset(
          AssetUtils.getIcons("ic_profile"),
          fit: BoxFit.contain,
          width: 50,
          height: 50,
        ),
      ),
    );

  Widget _buildWelcomeText() => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Utils.getGreeting(),
            style: StyleUtils.kTextStyleSize18Weight500(
              color: ColorUtils.whiteColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Mohammed Jassim",
            style: StyleUtils.kTextStyleSize18Weight500(
              color: ColorUtils.whiteColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );

  Widget _buildNotificationBadge() => ZoomTapAnimation(
      onTap: () {
        Get.toNamed(AppRouter.notificationScreen);
      },
      child: Badge.count(
        count: 0,
        backgroundColor: ColorUtils.secondaryColor,
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
