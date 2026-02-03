import "package:collect/features/profile/controller/profile_controller.dart";
import "package:collect/routes.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/theme/theme_service.dart";
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

  // Constants
  static const double _iconSize = 22;
  static const double _iconContainerSize = 40;
  static const double _borderRadius = 32;
  static const double _containerBorderRadius = 24;
  static const double _horizontalPadding = 20;
  static const double _rowVerticalPadding = 12;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<ThemeMode>(
    valueListenable: ThemeService.themeModeNotifier,
    builder: (_, __, ___) => Container(
      decoration: BoxDecoration(color: ThemeColors.scaffoldColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomAppBar(title: "profile".tr),
          Expanded(child: _buildProfileContent(context)),
        ],
      ),
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
              _buildMainCard(),
              20.heightBox,
              _buildInfoContainer(context),
              20.heightBox,
              _buildFooter(),
            ],
          ),
        ),
      );

  Widget _buildMainCard() => Container(
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(),
    child: Column(children: <Widget>[_buildProfileCard(), 16.heightBox]),
  );

  Widget _buildProfileCard() => Row(
    children: <Widget>[
      _buildAvatarContainer(),
      16.widthBox,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Jassim",
              style: StyleUtils.kTextStyleSize24Weight500(
                color: ThemeColors.blackWhite,
              ),
            ),
            4.heightBox,
            Text(
              "123456789",
              style: StyleUtils.kTextStyleSize14Weight400(
                color: ThemeColors.blackWhite,
              ),
            ),
            2.heightBox,
            Text(
              "test@email.com",
              style: StyleUtils.kTextStyleSize14Weight400(
                color: ThemeColors.blackWhite,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildAvatarContainer() => Container(
    height: 72,
    width: 72,
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      gradient: ThemeColors.primaryGradient,
      shape: BoxShape.circle,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: ThemeColors.primary.withValues(alpha: 0.35),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: CircleAvatar(
      backgroundColor: ThemeColors.surface,
      child: Icon(CupertinoIcons.person, color: ThemeColors.whitePrimary),
    ),
  );

  Widget _buildInfoContainer(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: ThemeColors.surface,
      borderRadius: BorderRadius.circular(_containerBorderRadius),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: ThemeColors.primary.withValues(alpha: 0.08),
          blurRadius: 20,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        _buildMenuRow(
          icon: CupertinoIcons.phone,
          label: "contact_us".tr,
          onTap: () => Get.toNamed(AppRouter.contactUsScreen),
        ),
        _divider(),
        _buildMenuRow(
          icon: CupertinoIcons.doc_text,
          label: "terms_and_condition".tr,
          onTap: () => Get.toNamed(AppRouter.termsAndConditionScreen),
        ),
        _divider(),
        _buildLanguageRow(),
        _divider(),
        _buildThemeRow(),
        _divider(),
        _buildMenuRow(
          icon: CupertinoIcons.trash,
          label: "deleteAccount".tr,
          onTap: () => _showConfirmationDeleteDialog(context),
        ),
        _divider(),
        _buildMenuRow(
          icon: CupertinoIcons.square_arrow_right,
          label: "logout".tr,
          onTap: () => _showConfirmationLogoutDialog(context),
        ),
      ],
    ),
  );

  Widget _buildMenuRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) => ZoomTapAnimation(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: _rowVerticalPadding,
      ),
      child: Row(
        children: <Widget>[
          _buildIconContainer(icon),
          12.widthBox,
          Expanded(
            child: Text(
              label,
              style: StyleUtils.kTextStyleSize18Weight500(
                color: ThemeColors.blackWhite,
              ),
            ),
          ),
          Icon(
            CupertinoIcons.chevron_forward,
            color: ThemeColors.blackWhite,
            size: 18,
          ),
        ],
      ),
    ),
  );

  Widget _buildLanguageRow() => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: _horizontalPadding,
      vertical: _rowVerticalPadding,
    ),
    child: Row(
      children: <Widget>[
        _buildIconContainer(CupertinoIcons.globe),
        12.widthBox,
        Expanded(
          child: Text(
            "Language".tr,
            style: StyleUtils.kTextStyleSize18Weight500(
              color: ThemeColors.blackWhite,
            ),
          ),
        ),
        LanguageWidget(),
      ],
    ),
  );

  Widget _buildThemeRow() => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: _horizontalPadding,
      vertical: _rowVerticalPadding,
    ),
    child: Row(
      children: <Widget>[
        _buildIconContainer(CupertinoIcons.brightness),
        12.widthBox,
        Expanded(
          child: Text(
            "theme".tr,
            style: StyleUtils.kTextStyleSize18Weight500(
              color: ThemeColors.blackWhite,
            ),
          ),
        ),
        const ThemeWidget(),
      ],
    ),
  );

  Widget _buildIconContainer(IconData icon) => Container(
    width: _iconContainerSize,
    height: _iconContainerSize,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          ThemeColors.primary.withValues(alpha: 0.15),
          ThemeColors.surface,
        ],
      ),
      shape: BoxShape.circle,
    ),
    child: Icon(icon, size: _iconSize, color: ThemeColors.whitePrimary),
  );

  Widget _buildFooter() => Obx(
    () => Center(
      child: Text(
        controller.buildInfo.value,
        style: StyleUtils.kTextStyleSize12Weight400(
          color: ThemeColors.greyTextColor,
        ),
      ),
    ),
  );

  Widget _divider() => Container(
    height: 1,
    margin: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
    color: ThemeColors.primary.withValues(alpha: 0.08),
  );

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: ThemeColors.surface,
    borderRadius: BorderRadius.circular(_borderRadius),
    border: Border.all(color: ThemeColors.border),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: ThemeColors.blackWhite.withValues(alpha: 0.05),
        blurRadius: 30,
        offset: const Offset(0, 12),
      ),
    ],
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
        onConfirm: () => Navigator.of(context).pop(),
      );
}
