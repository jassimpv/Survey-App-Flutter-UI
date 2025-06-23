import 'package:collect/controller/profile_controller.dart';
import 'package:collect/routes.dart';
import 'package:collect/utils/asset_utils.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:collect/utils/utils_helper.dart';
import 'package:collect/views/widget/custom_app_bar.dart';
import 'package:collect/views/widget/zoom_tap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomAppBar(title: "profile".tr),
        Expanded(child: _buildProfileContent(context)),
      ],
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: Get.put<ProfileController>(ProfileController()),
      initState: (state) {
        // controller.getProfile();
      },
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              12.heightBox,
              _buildProfileCard(),
              12.heightBox,
              _buildSupervisorCard(),
              12.heightBox,
              _buildInfoContainer(context),
              Spacer(),
              _buildFooter(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(color: ColorUtils.themeColor, width: 1),
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      AssetUtils.getDummyImage("pp.webp"),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        AssetUtils.getIcons("ic_profile"),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                12.widthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mohammed Jassim",
                      style: StyleUtils.kTextStyleSize24Weight500(
                        color: Colors.black,
                      ),
                    ),
                    4.heightBox,
                    Text(
                      "123456789",
                      style: StyleUtils.kTextStyleSize12Weight400(
                        color: Color(0xff667085),
                      ),
                    ),
                    4.heightBox,
                    Text(
                      "test@email.com",
                      style: StyleUtils.kTextStyleSize12Weight400(
                        color: Color(0xff667085),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            16.heightBox,
            Row(
              children: [
                infoCard("your_tasks".tr, "0", Color(0xff90D1CA)),
                8.widthBox,
                infoCard("your_locations".tr, "0", Color(0xffDEEAFF)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            onTap: () {
              _showConfirmationDeleteDialog(context);
            },
            child: _buildInfoRow(
              Icons.delete,
              "deleteAccount".tr,
              color: Colors.red,
            ),
          ),
          Divider(color: Colors.black.withValues(alpha: 0.1)),
          ZoomTapAnimation(
            onTap: () {
              _showConfirmationLogoutDialog(context);
            },
            child: _buildInfoRow(Icons.logout, "logout".tr, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildSupervisorCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(color: ColorUtils.themeColor, width: 1),
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      AssetUtils.getDummyImage("pp.webp"),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        AssetUtils.getIcons("ic_profile"),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                8.widthBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "yourSupervisor".tr,
                        style: StyleUtils.kTextStyleSize14Weight400(
                          color: Color(0xff667085),
                        ),
                      ),
                      2.heightBox,
                      Text(
                        "User Name",
                        style: StyleUtils.kTextStyleSize18Weight500(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.call, color: ColorUtils.themeColor),
                  onPressed: () {
                    Utils.dail("123456789"); // Replace with actual phone number
                  },
                ),
                IconButton(
                  icon: Icon(Icons.message, color: ColorUtils.themeColor),
                  onPressed: () {
                    // Implement call functionality her
                    Utils.sendMessage(
                      "123456789",
                    ); // Replace with actual phone number
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String text, {
    Color color = ColorUtils.themeColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        children: [
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
          Spacer(),
          Icon(Icons.arrow_forward_ios, color: color, size: 20),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Obx(
      () => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            controller.buildInfo.value,
            style: StyleUtils.kTextStyleSize12Weight400(
              color: Color(0xff667085),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showConfirmationLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'logout'.tr,
            style: StyleUtils.kTextStyleSize18Weight500(),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'are_you_sure_logout'.tr,
                  style: StyleUtils.kTextStyleSize16Weight400(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'cancel'.tr,
                style: StyleUtils.kTextStyleSize18Weight500(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'ok'.tr,
                style: StyleUtils.kTextStyleSize18Weight500(),
              ),
              onPressed: () {
                controller.logout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showConfirmationDeleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'delete'.tr,
            style: StyleUtils.kTextStyleSize18Weight500(),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'are_you_sure_delete'.tr,
                  style: StyleUtils.kTextStyleSize16Weight400(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'cancel'.tr,
                style: StyleUtils.kTextStyleSize18Weight500(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'ok'.tr,
                style: StyleUtils.kTextStyleSize18Weight500(),
              ),
              onPressed: () {
                // controller.logout();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget infoCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            4.heightBox,
            Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
