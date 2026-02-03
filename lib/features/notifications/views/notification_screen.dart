import "package:collect/features/notifications/controller/notifications_controller.dart";
import "package:collect/core/models/notification_response.dart";
import "package:collect/core/utils/colors_utils.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/widgets/custom_app_bar.dart";
import "package:collect/core/widgets/zoom_tap.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

enum NotificationTypes { approved, rejected }

class NotificationScreen extends GetView<NotificationsController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<NotificationsController>(NotificationsController());
    return Scaffold(
      backgroundColor: ColorUtils.appBgMain,
      body: Container(
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
            CustomAppBar(
              title: "notifications".tr,
              onBackPressed: Get.back,
              isNotificationButton: false,
            ),
            Expanded(
              child: Obx(
                () => ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      10.heightBox,
                  itemCount:
                      controller
                          .notificationsResponse
                          .value
                          .response
                          ?.notifications
                          ?.length ??
                      0,
                  itemBuilder: (BuildContext context, int index) =>
                      _NotificationItem(
                        notifications: controller
                            .notificationsResponse
                            .value
                            .response
                            ?.notifications![index],
                        notificationTypes: index % 2 == 0
                            ? NotificationTypes.approved
                            : NotificationTypes.rejected,
                      ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shrinkWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({this.notifications, this.notificationTypes});
  final Notifications? notifications;
  final NotificationTypes? notificationTypes;

  @override
  Widget build(BuildContext context) => ZoomTapAnimation(
    child: Container(
      decoration: StyleUtils.cardView(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Center(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: ColorUtils.themeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    notificationTypes == NotificationTypes.rejected
                        ? Icons.close
                        : Icons.done,
                    size: 20,
                    color: ColorUtils.linkColor,
                  ),
                ),
              ),
            ),
          ),
          10.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  notificationTypes == NotificationTypes.rejected
                      ? "Rejected"
                      : "Approved",
                  style: StyleUtils.kTextStyleSize14Weight500(
                    color: Colors.black,
                  ),
                ),
                Text(
                  notifications?.message ?? "",
                  style: StyleUtils.kTextStyleSize14Weight400(
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
