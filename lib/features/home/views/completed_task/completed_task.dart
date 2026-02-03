import "package:collect/features/home/controller/home_controller.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/theme/theme_service.dart";
import "package:collect/features/home/views/completed_task/filter_bottom_sheet.dart";
import "package:collect/core/widgets/custom_app_bar.dart";
import "package:collect/core/widgets/task_card.dart";
import "package:collect/core/widgets/zoom_tap.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";

class CompletedTask extends StatelessWidget {
  CompletedTask({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomAppBar(
            title: "Collection Report".tr,
            // tabBar: Obx(
            //   () => CompletedListTabView(
            //     selectedIndex: controller.selectedTab.value,
            //     onTabSelect: (int tabIndex) {},
            //   ),
            // ),
          ),
          16.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: ThemeColors.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: ThemeColors.themeColor.withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: controller.searchController,
                      decoration: StyleUtils.inputDecoration(
                        hintText: "search".tr,
                        labelText: "search".tr,
                      ),
                      onChanged: (String value) {},
                    ),
                  ),
                  12.widthBox,
                  ZoomTapAnimation(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Get.bottomSheet(
                        FilterBottomSheet(),
                        isDismissible: false,
                        useRootNavigator: true,
                        backgroundColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            ThemeColors.themeColor,
                            ThemeColors.themeColor.withValues(alpha: 0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: ThemeColors.themeColor.withValues(
                              alpha: 0.25,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.filter_list,
                        color: ThemeColors.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
            child: _searchItem(),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.data.length,
              padding: const EdgeInsets.symmetric(vertical: 1),
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                child: TaskCard(
                  bookingData: controller.data[index],
                  isFromList: true,
                  currentStatus: "upcoming",
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _searchItem() => Obx(() {
    final RxList<Widget> filterChips = <Widget>[].obs;

    if (controller.selectedFilter.value.isNotEmpty) {
      filterChips.add(
        _buildFilterChip(
          text: controller.filterItems.firstWhere(
            (Map<String, String> e) =>
                e["value"] == controller.selectedFilter.value,
          )["title"]!,
          onClose: () {
            controller.selectedFilter.value = "";
            // controller.getTripsListData();
          },
        ),
      );
    }

    if (controller.startDate.value != null) {
      if (controller.endDate.value != null) {
        filterChips.add(
          _buildFilterChip(
            text:
                "${DateFormat('dd/MM/yyyy').format(controller.startDate.value!)} - ${DateFormat('dd/MM/yyyy').format(controller.endDate.value!)}",
            onClose: () {
              controller.startDate.value = null;
              controller.endDate.value = null;
              // controller.getTripsListData();
            },
          ),
        );
      } else {
        filterChips.add(
          _buildFilterChip(
            text: DateFormat("dd/MM/yyyy").format(controller.startDate.value!),
            onClose: () {
              controller.startDate.value = null;
              // controller.getTripsListData();
            },
          ),
        );
      }
    }

    if (controller.searchController.text.isNotEmpty) {
      controller.searchController.text = controller.searchController.text
          .trim();
      filterChips.add(
        _buildFilterChip(
          text: controller.searchController.text,
          onClose: () {
            controller.searchController.clear();
            //remove the search filter
            filterChips.remove(filterChips.last);
          },
        ),
      );
    }
    if (filterChips.isEmpty) {
      return SizedBox.shrink();
    }
    return SizedBox(
      height: 35,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: filterChips),
      ),
    );
  });

  Widget _buildFilterChip({
    required String text,
    required VoidCallback onClose,
  }) => Container(
    height: 32,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      color: ThemeColors.themeColor.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: ThemeColors.themeColor.withValues(alpha: 0.2)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          text.tr,
          style: StyleUtils.kTextStyleSize12Weight500(
            color: ThemeColors.themeColor,
          ),
        ),
        8.widthBox,
        ZoomTapAnimation(
          onTap: onClose,
          child: Icon(Icons.close, size: 16, color: ThemeColors.themeColor),
        ),
      ],
    ),
  );
}
