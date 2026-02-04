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
    decoration: BoxDecoration(color: ThemeColors.scaffoldColor),
    child: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          stretch: true,
          onStretchTrigger: () async {},
          pinned: true,
          floating: false,
          elevation: 0,
          backgroundColor: ThemeColors.scaffoldColor,
          flexibleSpace: FlexibleSpaceBar(background: HomeHeader()),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(44),
            child: SizedBox.shrink(),
          ),
        ),
        SliverToBoxAdapter(
          child: Directionality(
            textDirection: TextDirection.ltr,
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
                  16.heightBox,
                  if (controller.data.isNotEmpty) ...<Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.data.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TaskCard(
                          bookingData: controller.data[index],
                          isFromList: true,
                          currentStatus: "upcoming",
                        ),
                      ),
                    ),
                  ] else
                    NoData(
                      text: "noUpcomingTrip".tr,
                      subText: "noUpcomingTripsPlannedYet".tr,
                      withImage: true,
                    ),
                  100.heightBox,
                ],
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
      color: ThemeColors.whitePrimary,
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
      color: ThemeColors.surface,
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
                          ? ThemeColors.textPrimary
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
