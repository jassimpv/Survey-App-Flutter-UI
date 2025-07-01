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
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      CustomAppBar(title: "profile".tr),
      Expanded(child: _buildProfileContent(context)),
    ],
  );

  Widget _buildProfileContent(BuildContext context) =>
      GetBuilder<ProfileController>(
        init: Get.put<ProfileController>(ProfileController()),
        initState: (GetBuilderState<ProfileController> state) {
          // controller.getProfile();
        },
        builder: (_) => Padding(
          padding: const EdgeInsets.all(16),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                12.heightBox,
                _buildProfileCard(),
                12.heightBox,
                _buildSupervisorCard(),
                Divider(color: Colors.black.withValues(alpha: 0.1)),
                12.heightBox,
                _buildInfoContainer(context),
                const Spacer(),
                _buildFooter(),
              ],
            ),
          ),
        ),
      );

  Widget _buildProfileCard() => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 60,
              height: 60,
              decoration: const ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(color: ColorUtils.themeColor),
                ),
              ),
              child: const ClipOval(
                child: Icon(
                  CupertinoIcons.person, // Placeholder for profile image
                  size: 40,
                  color: ColorUtils.themeColor,
                ),
              ),
            ),
            12.widthBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Jassim",
                  style: StyleUtils.kTextStyleSize24Weight500(
                    color: Colors.black,
                  ),
                ),
                4.heightBox,
                Text(
                  "123456789",
                  style: StyleUtils.kTextStyleSize12Weight400(
                    color: const Color(0xff667085),
                  ),
                ),
                4.heightBox,
                Text(
                  "test@email.com",
                  style: StyleUtils.kTextStyleSize12Weight400(
                    color: const Color(0xff667085),
                  ),
                ),
              ],
            ),
          ],
        ),
        16.heightBox,
        Row(
          children: <Widget>[
            infoCard(
              "your_tasks".tr,
              "0",
              ColorUtils.secondaryColor.withValues(alpha: 0.8),
            ),
            8.widthBox,
            infoCard(
              "your_locations".tr,
              "0",
              ColorUtils.secondaryColor.withValues(alpha: 0.8),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildInfoContainer(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      ZoomTapAnimation(
        onTap: () => Get.toNamed(AppRouter.contactUsScreen),
        child: _buildInfoRow(Icons.contact_emergency, "contact_us".tr),
      ),
      Divider(color: Colors.black.withValues(alpha: 0.1)),
      ZoomTapAnimation(
        onTap: () => Get.toNamed(AppRouter.termsAndConditionScreen),
        child: _buildInfoRow(Icons.notes, "terms_and_condition".tr),
      ),
      Divider(color: Colors.black.withValues(alpha: 0.1)),
      ZoomTapAnimation(
        onTap: () async {
          await _showConfirmationDeleteDialog(context);
        },
        child: _buildInfoRow(
          Icons.delete,
          "deleteAccount".tr,
          color: Colors.red,
        ),
      ),
      Divider(color: Colors.black.withValues(alpha: 0.1)),
      ZoomTapAnimation(
        onTap: () async {
          await _showConfirmationLogoutDialog(context);
        },
        child: _buildInfoRow(Icons.logout, "logout".tr, color: Colors.red),
      ),
    ],
  );

  Widget _buildSupervisorCard() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: 60,
              height: 60,
              decoration: const ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(color: ColorUtils.themeColor),
                ),
              ),
              child: const ClipOval(
                child: Icon(
                  CupertinoIcons.person, // Placeholder for profile image
                  size: 40,
                  color: ColorUtils.themeColor,
                ),
              ),
            ),
            8.widthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "yourSupervisor".tr,
                    style: StyleUtils.kTextStyleSize14Weight400(
                      color: const Color(0xff667085),
                    ),
                  ),
                  2.heightBox,
                  Text(
                    "MOHAMMED",
                    style: StyleUtils.kTextStyleSize18Weight500(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.call, color: ColorUtils.themeColor),
              onPressed: () async {
                await Utils.dail(
                  "123456789",
                ); // Replace with actual phone number
              },
            ),
            IconButton(
              icon: const Icon(Icons.message, color: ColorUtils.themeColor),
              onPressed: () async {
                // Implement call functionality her
                await Utils.sendMessage(
                  "123456789",
                ); // Replace with actual phone number
              },
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildInfoRow(
    IconData icon,
    String text, {
    Color color = ColorUtils.themeColor,
  }) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Center(child: Icon(icon, size: 20, color: Colors.white)),
        ),
        8.widthBox,
        Text(
          text,
          style: StyleUtils.kTextStyleSize18Weight500(color: Colors.black),
        ),
        const Spacer(),
        Icon(Icons.arrow_forward_ios, color: color, size: 20),
      ],
    ),
  );

  Widget _buildFooter() => Obx(
    () => Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          controller.buildInfo.value,
          style: StyleUtils.kTextStyleSize12Weight400(
            color: const Color(0xff667085),
          ),
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

  Widget infoCard(String title, String value, Color color) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: StyleUtils.kTextStyleSize16Weight600(color: Colors.white),
          ),
          const Spacer(),

          Text(
            10.toString(),
            style: StyleUtils.kTextStyleSize24Weight500(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
