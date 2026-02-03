import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/theme/theme_service.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/utils/utils_helper.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class Complete {
  Complete({required this.todayCount, required this.totalCount});

  factory Complete.fromJson(Map<String, dynamic> json) => Complete(
    todayCount: json["today_count"],
    totalCount: json["total_count"],
  );
  int todayCount;
  int totalCount;
}

class HomeStatusView extends StatelessWidget {
  const HomeStatusView({
    required this.upcomingCount,
    required this.completedCount,
    super.key,
  });

  final Complete upcomingCount;
  final Complete completedCount;

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      Expanded(
        child: _StatusCard(
          todayCount: upcomingCount.todayCount.toString(),
          totalCount: upcomingCount.totalCount.toString(),
          label: "KG".tr,
          icon: "img_upcoming",
        ),
      ),
      16.widthBox,
      Expanded(
        child: _StatusCard(
          todayCount: completedCount.todayCount.toString(),
          totalCount: completedCount.totalCount.toString(),
          label: "Location".tr,
          icon: "img_completed",
        ),
      ),
    ],
  );
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
    final bool isCompletedCard = icon == "img_completed";
    final Color accentColor = isCompletedCard
        ? ThemeColors.secondaryColor
        : ThemeColors.themeColor;

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: ThemeColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: accentColor.withValues(alpha: 0.16)),
        boxShadow: <BoxShadow>[
          if (!ThemeService.isDark())
            BoxShadow(
              color: accentColor.withValues(alpha: 0.18),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 46,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: <Color>[
                  accentColor,
                  accentColor.withValues(alpha: 0.4),
                ],
              ),
            ),
          ),
          12.heightBox,
          Text(
            label,
            style: StyleUtils.kTextStyleSize18Weight600(
              color: ThemeColors.whitePrimary,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _StatusCount(
                heading: "KG".tr,
                count: todayCount,
                isTotal: true,
                accentColor: accentColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusCount extends StatelessWidget {
  const _StatusCount({
    required this.count,
    required this.isTotal,
    required this.accentColor,
    required this.heading,
  });
  final bool isTotal;
  final String heading;
  final String count;
  final Color accentColor;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        Utils.replaceFarsiNumber(count),
        style: StyleUtils.kTextStyleSize54Weight600(color: accentColor),
      ),
    ],
  );
}
