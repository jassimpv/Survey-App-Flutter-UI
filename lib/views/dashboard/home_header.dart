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
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            ColorUtils.themeColor,
            const Color(0xFF1E8F87),
            ColorUtils.scaffoldColor,
          ],
          stops: const <double>[0, 0.55, 1],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorUtils.themeColor.withValues(alpha: 0.3),
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
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: <Widget>[
            _buildProfileImage(),
            14.widthBox,
            _buildWelcomeText(),
            Row(
              children: <Widget>[
                const LanguageWidegt(),
                8.widthBox,
                _buildNotificationBadge(),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildProfileImage() => Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: CircleAvatar(
      backgroundColor: ColorUtils.whiteColor,
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
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Badge.count(
        count: 0,
        backgroundColor: ColorUtils.secondaryColor,
        child: CircleAvatar(
          radius: 22,
          backgroundColor: ColorUtils.whiteColor.withValues(alpha: 0.15),
          child: const Icon(
            CupertinoIcons.bell,
            color: ColorUtils.whiteColor,
            size: 26,
          ),
        ),
      ),
    ),
  );
}
