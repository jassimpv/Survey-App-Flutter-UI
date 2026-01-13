import "package:collect/controller/profile_controller.dart";
import "package:collect/routes.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/sized_box_extension.dart";
import "package:collect/utils/textstyle_input.dart";
import "package:collect/utils/utils_helper.dart";
import "package:collect/views/widget/custom_app_bar.dart";
import "package:collect/views/widget/zoom_tap.dart";
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
                  children: <Widget>[
                    _buildProfileCard(),
                    16.heightBox,
                    _buildStatsRow(),
                  ],
                ),
              ),
              20.heightBox,
              _buildSupervisorCard(),
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
      IconButton(
        icon: const Icon(Icons.edit_outlined, color: ColorUtils.themeColor),
        onPressed: () {},
      ),
    ],
  );

  Widget _buildStatsRow() => Row(
    children: <Widget>[
      infoCard("Total Weight".tr, "12 KG"),
      12.widthBox,
      infoCard("Total Locations".tr, "05"),
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
          child: _buildInfoRow(Icons.contact_emergency, "contact_us".tr),
        ),
        _divider(),
        ZoomTapAnimation(
          onTap: () => Get.toNamed(AppRouter.termsAndConditionScreen),
          child: _buildInfoRow(Icons.notes, "terms_and_condition".tr),
        ),
        _divider(),
        ZoomTapAnimation(
          onTap: () async {
            await _showConfirmationDeleteDialog(context);
          },
          child: _buildInfoRow(
            Icons.delete,
            "deleteAccount".tr,
            color: ColorUtils.red,
          ),
        ),
        _divider(),
        ZoomTapAnimation(
          onTap: () async {
            await _showConfirmationLogoutDialog(context);
          },
          child: _buildInfoRow(
            Icons.logout,
            "logout".tr,
            color: ColorUtils.red,
          ),
        ),
      ],
    ),
  );

  Widget _buildSupervisorCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          ColorUtils.themeColor.withValues(alpha: 0.1),
          Colors.white,
        ],
      ),
      borderRadius: BorderRadius.circular(28),
      border: Border.all(color: ColorUtils.themeColor.withValues(alpha: 0.2)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: ColorUtils.themeColor.withValues(alpha: 0.12),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorUtils.themeColor,
          ),
          child: const Icon(
            CupertinoIcons.person,
            color: Colors.white,
            size: 30,
          ),
        ),
        12.widthBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "yourSupervisor".tr,
                style: StyleUtils.kTextStyleSize14Weight400(
                  color: ColorUtils.greyTextColor,
                ),
              ),
              4.heightBox,
              Text(
                "MOHAMMED",
                style: StyleUtils.kTextStyleSize18Weight600(
                  color: ColorUtils.headingColor,
                ),
              ),
            ],
          ),
        ),
        _contactIcon(icon: Icons.call, onTap: () => Utils.dail("123456789")),
        8.widthBox,
        _contactIcon(
          icon: Icons.message,
          onTap: () => Utils.sendMessage("123456789"),
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
        Icon(Icons.arrow_forward_ios, color: color, size: 18),
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

  Future<void> _showConfirmationLogoutDialog(
    BuildContext context,
  ) => showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text("logout".tr, style: StyleUtils.kTextStyleSize18Weight500()),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              "are_you_sure_logout".tr,
              style: StyleUtils.kTextStyleSize16Weight400(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            "cancel".tr,
            style: StyleUtils.kTextStyleSize18Weight500(),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("ok".tr, style: StyleUtils.kTextStyleSize18Weight500()),
          onPressed: () async {
            await controller.logout();
          },
        ),
      ],
    ),
  );

  Future<void> _showConfirmationDeleteDialog(
    BuildContext context,
  ) => showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text("delete".tr, style: StyleUtils.kTextStyleSize18Weight500()),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              "are_you_sure_delete".tr,
              style: StyleUtils.kTextStyleSize16Weight400(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            "cancel".tr,
            style: StyleUtils.kTextStyleSize18Weight500(),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("ok".tr, style: StyleUtils.kTextStyleSize18Weight500()),
          onPressed: () {
            // controller.logout();
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );

  Widget infoCard(String title, String value) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            ColorUtils.themeColor.withValues(alpha: 0.15),
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorUtils.themeColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: StyleUtils.kTextStyleSize14Weight400(
              color: ColorUtils.greyTextColor,
            ),
          ),
          6.heightBox,
          Text(
            value,
            style: StyleUtils.kTextStyleSize24Weight600(
              color: ColorUtils.headingColor,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _divider() => Container(
    height: 1,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    color: ColorUtils.themeColor.withValues(alpha: 0.08),
  );

  Widget _contactIcon({required IconData icon, required VoidCallback onTap}) =>
      ZoomTapAnimation(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: ColorUtils.themeColor.withValues(alpha: 0.12),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: ColorUtils.themeColor),
        ),
      );
}
