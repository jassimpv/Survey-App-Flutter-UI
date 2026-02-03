import "dart:async";

import "package:collect/features/home/controller/home_controller.dart";
import "package:collect/core/extensions/pull_to_refresh/pull_to_refresh_flutter.dart";

import "package:collect/core/theme/theme_colors.dart";

import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/theme/theme_service.dart";
import "package:collect/features/home/views/dashboard/home_header.dart";
import "package:collect/features/home/views/dashboard/home_status_view.dart";
import "package:collect/core/widgets/task_card.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class DashboardScreen extends GetView<HomeController> {
  DashboardScreen({super.key});
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(gradient: ThemeColors.scaffoldGradient),
    child: Column(
      children: <Widget>[
        const HomeHeader(),
        Expanded(
          child: SmartRefresher(
            header: WaterDropMaterialHeader(
              backgroundColor: ThemeColors.success,
              color: ThemeColors.onPrimary,
            ),
            controller: refreshController,
            onRefresh: () {
              Future.delayed(
                const Duration(seconds: 1),
                refreshController.refreshCompleted,
              );
            },
            footer: const WaterDropHeader(),
            onLoading: () {},
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    20.heightBox,
                    HomeStatusView(
                      upcomingCount: Complete(todayCount: 10, totalCount: 20),
                      completedCount: Complete(todayCount: 10, totalCount: 20),
                    ),
                    24.heightBox,
                    _label("Near By".tr),
                    12.heightBox,
                    TaskCard(
                      bookingData: controller.data[1],
                      isNext: true,
                      currentStatus: "next",
                    ),
                    // 24.heightBox,
                    // _label("upcomingTasks".tr),
                    12.heightBox,
                    if (controller.data.isNotEmpty) ...<Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ThemeColors.cardBackground,
                          boxShadow: [
                            BoxShadow(
                              color: ThemeColors.primary.withValues(
                                alpha: 0.08,
                              ),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.data.length,
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: TaskCard(
                                  bookingData: controller.data[index],
                                  isFromList: true,
                                  currentStatus: "upcoming",
                                ),
                              ),
                        ),
                      ),
                    ] else
                      NoData(
                        text: "noUpcomingTrip".tr,
                        subText: "noUpcomingTripsPlannedYet".tr,
                        withImage: true,
                      ),
                    24.heightBox,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _label(String text) => Text(
    text,
    style: StyleUtils.kTextStyleSize20Weight500(
      color: ThemeColors.headingColor,
    ),
  );
}

class NextTripTimerWidget extends StatefulWidget {
  const NextTripTimerWidget({required this.dateTime, super.key});

  final DateTime dateTime;

  @override
  State<NextTripTimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<NextTripTimerWidget> {
  Rx<DateTime> currentTime = DateTime.now().obs;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      currentTime.value = DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Obx(() {
    final Duration remainingTime = widget.dateTime.difference(
      currentTime.value,
    );
    final String hours = remainingTime.inHours
        .remainder(24)
        .toString()
        .padLeft(2, "0");
    final String minutes = remainingTime.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, "0");
    final String seconds = remainingTime.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, "0");

    return Row(
      children: <Widget>[
        _buildTimeBox(hours),
        4.widthBox,
        Text(
          ":",
          style: StyleUtils.kTextStyleSize12Weight500(
            color: ThemeService.isDark()
                ? ThemeColors.whiteColor
                : ThemeColors.blackColor,
          ),
        ),
        4.widthBox,
        _buildTimeBox(minutes),
        4.widthBox,
        Text(
          ":",
          style: StyleUtils.kTextStyleSize12Weight500(
            color: ThemeService.isDark()
                ? ThemeColors.whiteColor
                : ThemeColors.blackColor,
          ),
        ),
        4.widthBox,
        _buildTimeBox(seconds),
      ],
    );
  });

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget _buildTimeBox(String time) => Container(
    height: 32,
    width: 32,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: ThemeService.isDark()
            ? <Color>[
                ThemeColors.darkGreen.withValues(alpha: 0.8),
                ThemeColors.themeColor.withValues(alpha: 0.6),
              ]
            : <Color>[
                ThemeColors.themeColor.withValues(alpha: 0.7),
                ThemeColors.scaffoldColor,
              ],
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: ThemeColors.themeColor.withValues(alpha: 0.15),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Center(
      child: Text(
        time,
        style: StyleUtils.kTextStyleSize14Weight600(
          color: ThemeColors.whiteColor,
        ),
      ),
    ),
  );
}

class NoData extends StatelessWidget {
  const NoData({
    required this.text,
    required this.withImage,
    required this.subText,
    super.key,
  });
  final String text;
  final bool withImage;
  final String subText;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: ThemeService.isDark()
          ? ThemeColors.backgroundDark
          : ThemeColors.whiteColor,
      boxShadow: [
        BoxShadow(
          color: ThemeColors.themeColor.withValues(alpha: 0.08),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: withImage
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ThemeService.isDark()
                      ? ThemeColors.darkGray
                      : ThemeColors.scaffoldColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  "assets/images/ic_no_data.png",
                  height: 48,
                  width: 64,
                ),
              ),
              16.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    text,
                    style: StyleUtils.kTextStyleSize16Weight600(
                      color: ThemeService.isDark()
                          ? ThemeColors.whiteColor
                          : ThemeColors.headingColor,
                    ),
                  ),
                  4.heightBox,
                  Text(
                    subText,
                    style: StyleUtils.kTextStyleSize14Weight400(
                      color: ThemeService.isDark()
                          ? ThemeColors.greyLightTextColor
                          : ThemeColors.greyTextColor,
                    ),
                  ),
                ],
              ),
            ],
          )
        : Center(
            child: Text(
              text,
              style: StyleUtils.kTextStyleSize18Weight500(
                color: ThemeColors.onSurfaceSecondary,
              ),
            ),
          ),
  );
}
