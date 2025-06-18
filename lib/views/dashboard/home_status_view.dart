import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:collect/utils/utils_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Complete {
  int todayCount;
  int totalCount;

  Complete({required this.todayCount, required this.totalCount});

  factory Complete.fromJson(Map<String, dynamic> json) => Complete(
    todayCount: json["today_count"],
    totalCount: json["total_count"],
  );
}

class HomeStatusView extends StatelessWidget {
  const HomeStatusView({
    super.key,
    required this.upcomingCount,
    required this.completedCount,
  });

  final Complete upcomingCount;
  final Complete completedCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatusCard(
            todayCount: upcomingCount.todayCount.toString(),
            totalCount: upcomingCount.totalCount.toString(),
            label: "upcoming".tr,
            icon: "img_upcoming",
          ),
        ),
        16.widthBox,
        Expanded(
          child: _StatusCard(
            todayCount: completedCount.todayCount.toString(),
            totalCount: completedCount.totalCount.toString(),
            label: "completed".tr,
            icon: "img_completed",
          ),
        ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.todayCount,
    required this.totalCount,
    required this.label,
    required this.icon,
  });

  final String todayCount;
  final String totalCount;
  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      // height: 73,
      decoration: BoxDecoration(
        color: label == "Completed"
            ? ColorUtils.themeColor.withValues(alpha: .8)
            : ColorUtils.themeColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withValues(alpha: 0.10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: StyleUtils.kTextStyleSize18Weight500(color: Colors.white),
          ),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  _StatusText(label: "today".tr),
                  5.widthBox,
                  _StatusCount(count: todayCount, isTotal: true),
                ],
              ),

              Row(
                children: [
                  _StatusText(label: "total".tr),
                  5.widthBox,
                  _StatusCount(count: totalCount, isTotal: false),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusText extends StatelessWidget {
  const _StatusText({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: StyleUtils.kTextStyleSize14Weight400(
        color: Colors.white.withValues(alpha: 0.5),
      ),
    );
  }
}

class _StatusCount extends StatelessWidget {
  final bool isTotal;
  const _StatusCount({required this.count, required this.isTotal});

  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      height: 22,
      decoration: BoxDecoration(
        color: ColorUtils.metallicColor.withValues(alpha: 0.80),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            Utils.replaceFarsiNumber(count),
            style: StyleUtils.kTextStyleSize14Weight600(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
