import "package:collect/features/notifications/controller/notifications_controller.dart";
import "package:collect/core/models/notification_response.dart";
import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/theme/theme_service.dart";
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
      backgroundColor: ThemeColors.scaffoldColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ThemeService.isDark()
                ? [
                    ThemeColors.surface,
                    ThemeColors.blackColor.withValues(alpha: 0.1),
                  ]
                : [ThemeColors.scaffoldColor, ThemeColors.surface],
          ),
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              stretch: true,
              onStretchTrigger: () async {},
              expandedHeight: 144.0,
              pinned: true,
              floating: false,
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: CustomAppBar(
                title: "notifications".tr,
                onBackPressed: Get.back,
                isNotificationButton: false,
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(24),
                child: SizedBox.shrink(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final Notifications? notification = controller
                        .notificationsResponse
                        .value
                        .response
                        ?.notifications?[index];
                    final NotificationTypes type = index % 2 == 0
                        ? NotificationTypes.approved
                        : NotificationTypes.rejected;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _NotificationItem(
                        notifications: notification,
                        notificationTypes: type,
                      ),
                    );
                  },
                  childCount:
                      controller
                          .notificationsResponse
                          .value
                          .response
                          ?.notifications
                          ?.length ??
                      0,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () =>
                    (controller
                            .notificationsResponse
                            .value
                            .response
                            ?.notifications
                            ?.isEmpty ??
                        true)
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.notifications_none,
                                size: 64,
                                color: ThemeColors.greyTextColor.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                              16.heightBox,
                              Text(
                                "noNotifications".tr,
                                style: StyleUtils.kTextStyleSize16Weight600(
                                  color: ThemeService.isDark()
                                      ? ThemeColors.textPrimary
                                      : ThemeColors.headingColor,
                                ),
                              ),
                              8.heightBox,
                              Text(
                                "youAreAllCaughtUp".tr,
                                style: StyleUtils.kTextStyleSize14Weight400(
                                  color: ThemeColors.greyTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
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

  Color _getIconBackgroundColor() {
    if (notificationTypes == NotificationTypes.rejected) {
      return ThemeColors.error.withValues(alpha: 0.12);
    }
    return ThemeColors.success.withValues(alpha: 0.12);
  }

  Color _getIconColor() {
    if (notificationTypes == NotificationTypes.rejected) {
      return ThemeColors.error;
    }
    return ThemeColors.success;
  }

  String _getTitle() {
    return notificationTypes == NotificationTypes.rejected
        ? "Rejected"
        : "Approved";
  }

  @override
  Widget build(BuildContext context) => ZoomTapAnimation(
    child: Container(
      decoration: BoxDecoration(
        color: ThemeService.isDark()
            ? ThemeColors.surface
            : ThemeColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ThemeColors.themeColor.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: ThemeService.isDark()
              ? ThemeColors.darkGray.withValues(alpha: 0.3)
              : ThemeColors.whiteColor.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _getIconBackgroundColor(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  notificationTypes == NotificationTypes.rejected
                      ? Icons.close_rounded
                      : Icons.check_circle_outline_rounded,
                  size: 24,
                  color: _getIconColor(),
                ),
              ),
            ),
            16.widthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _getTitle(),
                    style: StyleUtils.kTextStyleSize14Weight600(
                      color: ThemeService.isDark()
                          ? ThemeColors.textPrimary
                          : ThemeColors.headingColor,
                    ),
                  ),
                  8.heightBox,
                  Text(
                    notifications?.message ?? "No message",
                    style: StyleUtils.kTextStyleSize14Weight400(
                      color: ThemeService.isDark()
                          ? ThemeColors.greyLightTextColor
                          : ThemeColors.greyTextColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            12.widthBox,
            Icon(
              Icons.chevron_right_rounded,
              size: 24,
              color: ThemeColors.greyTextColor.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    ),
  );
}
