import 'dart:async';
import 'package:collect/controller/home_controller.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:collect/views/dashboard/home_header.dart';
import 'package:collect/views/dashboard/home_status_view.dart';
import 'package:collect/views/widget/task_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collect/extension/pull_to_refresh/pull_to_refresh_flutter.dart';

class DashboardScreen extends GetView<HomeController> {
  DashboardScreen({super.key});
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeader(),
        Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: const WaterDropMaterialHeader(
              backgroundColor: ColorUtils.themeColor,
            ),
            controller: refreshController,
            onRefresh: () {},
            footer: WaterDropHeader(),
            onLoading: () {},
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    12.heightBox,
                    HomeStatusView(
                      upcomingCount: Complete(todayCount: 10, totalCount: 20),
                      completedCount: Complete(todayCount: 10, totalCount: 20),
                    ),
                    12.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [_label("nextTask".tr)],
                    ),
                    TaskCard(
                      bookingData: controller.data[1],
                      isNext: true,
                      currentStatus: "next",
                    ),
                    12.heightBox,
                    _label("upcomingTasks".tr),
                    if (controller.data.isNotEmpty) ...[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.black.withValues(alpha: 0.10),
                          ),
                          color: Colors.white,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.data.length,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 5,
                              ),
                              child: TaskCard(
                                bookingData: controller.data[index],
                                isFromList: true,
                                currentStatus: "upcoming",
                              ),
                            );
                          },
                        ),
                      ),
                    ] else
                      NoData(
                        text: "noUpcomingTrip".tr,
                        subText: "noUpcomingTripsPlannedYet".tr,
                        withImage: true,
                      ),
                    12.heightBox,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Column(
      children: [
        Text(text, style: StyleUtils.kTextStyleSize20Weight500()),
        8.heightBox,
      ],
    );
  }
}

class NextTripTimerWidget extends StatefulWidget {
  const NextTripTimerWidget({super.key, required this.dateTime});

  final DateTime dateTime;

  @override
  State<NextTripTimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<NextTripTimerWidget> {
  Rx<DateTime> currentTime = DateTime.now().obs;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime.value = DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final remainingTime = widget.dateTime.difference(currentTime.value);
      final hours = remainingTime.inHours
          .remainder(24)
          .toString()
          .padLeft(2, '0');
      final minutes = remainingTime.inMinutes
          .remainder(60)
          .toString()
          .padLeft(2, '0');
      final seconds = remainingTime.inSeconds
          .remainder(60)
          .toString()
          .padLeft(2, '0');

      return Row(
        children: [
          _buildTimeBox(hours),
          4.widthBox,
          Text(':', style: StyleUtils.kTextStyleSize12Weight500()),
          4.widthBox,
          _buildTimeBox(minutes),
          4.widthBox,
          Text(':', style: StyleUtils.kTextStyleSize12Weight500()),
          4.widthBox,
          _buildTimeBox(seconds),
        ],
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget _buildTimeBox(String time) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        color: Color(0xff3C65F2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          time,
          style: StyleUtils.kTextStyleSize12Weight500(color: Colors.white),
        ),
      ),
    );
  }
}

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    required this.text,
    required this.withImage,
    required this.subText,
  });
  final String text;
  final bool withImage;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.10)),
        color: Colors.white,
      ),
      child: withImage
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/ic_no_data.png',
                  height: 40,
                  width: 60,
                ),
                8.heightBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: StyleUtils.kTextStyleSize14Weight500(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      subText,
                      style: StyleUtils.kTextStyleSize14Weight400(
                        color: Colors.black.withValues(alpha: .5),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Center(
              child: Text(
                text,
                style: StyleUtils.kTextStyleSize24Weight500(
                  color: Color(0xff9E9E9E),
                ),
              ),
            ),
    );
  }
}
