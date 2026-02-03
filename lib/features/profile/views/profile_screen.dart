import "package:collect/features/profile/controller/profile_controller.dart";
import "package:collect/routes.dart";
import "package:collect/core/utils/colors_utils.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/widgets/custom_app_bar.dart";
import "package:collect/core/widgets/language_widget.dart";
import "package:collect/core/widgets/modern_dialog.dart";
import "package:collect/core/widgets/theme_widget.dart";
import "package:collect/core/widgets/zoom_tap.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [ColorUtils.scaffoldColor, Colors.white],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        CustomAppBar(title: "profile".tr),
        Expanded(child: _buildProfileContent(context)),
      ],
    ),
  );

  Widget _buildProfileContent(BuildContext context) =>
      GetBuilder<ProfileController>(
        init: Get.put<ProfileController>(ProfileController()),
        builder: (_) => SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.white, ColorUtils.scaffoldColor],
                  ),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: ColorUtils.themeColor.withValues(alpha: 0.15),
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[_buildProfileCard(), 16.heightBox],
                ),
              ),
              20.heightBox,
              _buildInfoContainer(context),
              20.heightBox,
              _buildFooter(),
            ],
          ),
        ),
      );

  Widget _buildProfileCard() => Row(
    children: <Widget>[
      Container(
        height: 72,
        width: 72,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              ColorUtils.themeColor,
              ColorUtils.themeColor.withValues(alpha: 0.6),
            ],
          ),
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: ColorUtils.themeColor.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(CupertinoIcons.person, color: ColorUtils.themeColor),
        ),
      ),
      16.widthBox,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Jassim",
              style: StyleUtils.kTextStyleSize24Weight500(
                color: ColorUtils.headingColor,
              ),
            ),
            4.heightBox,
            Text(
              "123456789",
              style: StyleUtils.kTextStyleSize14Weight400(
                color: ColorUtils.greyTextColor,
              ),
            ),
            2.heightBox,
            Text(
              "test@email.com",
              style: StyleUtils.kTextStyleSize14Weight400(
                color: ColorUtils.greyTextColor,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildInfoContainer(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: ColorUtils.themeColor.withValues(alpha: 0.08),
          blurRadius: 20,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        ZoomTapAnimation(
          onTap: () => Get.toNamed(AppRouter.contactUsScreen),
          child: _buildInfoRow(CupertinoIcons.phone, "contact_us".tr),
        ),
        _divider(),

        // Terms
        ZoomTapAnimation(
          onTap: () => Get.toNamed(AppRouter.termsAndConditionScreen),
          child: _buildInfoRow(
            CupertinoIcons.doc_text,
            "terms_and_condition".tr,
          ),
        ),
        _divider(),

        // Language row (inline widget)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      ColorUtils.themeColor.withValues(alpha: 0.15),
                      Colors.white,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.globe,
                  size: 22,
                  color: ColorUtils.themeColor,
                ),
              ),
              12.widthBox,
              Expanded(
                child: Text(
                  "Language".tr,
                  style: StyleUtils.kTextStyleSize18Weight500(
                    color: ColorUtils.headingColor,
                  ),
                ),
              ),
              const LanguageWidegt(),
            ],
          ),
        ),
        _divider(),
        // Theme row (inline widget)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      ColorUtils.themeColor.withValues(alpha: 0.15),
                      Colors.white,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.brightness,
                  size: 22,
                  color: ColorUtils.themeColor,
                ),
              ),
              12.widthBox,
              Expanded(
                child: Text(
                  "theme".tr,
                  style: StyleUtils.kTextStyleSize18Weight500(
                    color: ColorUtils.headingColor,
                  ),
                ),
              ),
              const ThemeWidget(),
            ],
          ),
        ),
        _divider(),
        ZoomTapAnimation(
          onTap: () async {
            await _showConfirmationDeleteDialog(context);
          },
          child: _buildInfoRow(CupertinoIcons.trash, "deleteAccount".tr),
        ),
        _divider(),
        ZoomTapAnimation(
          onTap: () async {
            await _showConfirmationLogoutDialog(context);
          },
          child: _buildInfoRow(CupertinoIcons.square_arrow_right, "logout".tr),
        ),
      ],
    ),
  );

  Widget _buildInfoRow(
    IconData icon,
    String text, {
    Color color = ColorUtils.themeColor,
  }) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    child: Row(
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[color.withValues(alpha: 0.15), Colors.white],
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 22, color: color),
        ),
        12.widthBox,
        Expanded(
          child: Text(
            text,
            style: StyleUtils.kTextStyleSize18Weight500(
              color: ColorUtils.headingColor,
            ),
          ),
        ),
        Icon(CupertinoIcons.chevron_forward, color: color, size: 18),
      ],
    ),
  );

  Widget _buildFooter() => Obx(
    () => Center(
      child: Text(
        controller.buildInfo.value,
        style: StyleUtils.kTextStyleSize12Weight400(
          color: ColorUtils.greyTextColor,
        ),
      ),
    ),
  );

  Future<void> _showConfirmationLogoutDialog(BuildContext context) =>
      showModernDialog(
        context: context,
        title: "logout".tr,
        message: "are_you_sure_logout".tr,
        confirmText: "ok".tr,
        cancelText: "cancel".tr,
        isDangerous: true,
        icon: CupertinoIcons.square_arrow_right,
        onConfirm: () async {
          Navigator.of(context).pop();
          await controller.logout();
        },
      );

  Future<void> _showConfirmationDeleteDialog(BuildContext context) =>
      showModernDialog(
        context: context,
        title: "delete".tr,
        message: "are_you_sure_delete".tr,
        confirmText: "ok".tr,
        cancelText: "cancel".tr,
        isDangerous: true,
        icon: CupertinoIcons.trash,
        onConfirm: () {
          // controller.logout();
          Navigator.of(context).pop();
        },
      );

  Widget _divider() => Container(
    height: 1,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    color: ColorUtils.themeColor.withValues(alpha: 0.08),
  );
}
