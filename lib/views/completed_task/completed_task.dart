import 'package:collect/controller/home_controller.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:collect/views/completed_task/filter_bottom_sheet.dart';
import 'package:collect/views/completed_task/tabview_widget.dart';
import 'package:collect/views/widget/custom_app_bar.dart';
import 'package:collect/views/widget/survey_card.dart';
import 'package:collect/views/widget/zoom_tap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CompletedTask extends StatelessWidget {
  CompletedTask({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomAppBar(
            title: "taskList".tr,
            tabBar: Obx(
              () => CompletedListTabView(
                selectedIndex: controller.selectedTab.value,
                onTabSelect: (tabIndex) {},
              ),
            ),
          ),
          8.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                SizedBox(
                  height: 44,
                  width: Get.width - 84,
                  child: TextFormField(
                    controller: controller.searchController,
                    decoration: StyleUtils.inputDecoration(
                      hintText: "search".tr,
                      labelText: "search".tr,
                    ),
                    onChanged: (value) {},
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
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorUtils.whiteColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.black.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Center(child: Icon(Icons.filter_list, size: 24)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
            child: _searchItem(),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.data.length,
              padding: EdgeInsets.symmetric(vertical: 5),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 6,
                  ),
                  child: SurveyCard(
                    bookingData: controller.data[index],
                    isFromList: true,
                    currentStatus: "upcoming",
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchItem() {
    return Obx(() {
      List<Widget> filterChips = [];

      if (controller.selectedFilter.value.isNotEmpty) {
        filterChips.add(
          _buildFilterChip(
            text: controller.filterItems.firstWhere(
              (e) => e['value'] == controller.selectedFilter.value,
            )['title']!,
            onClose: () {
              controller.selectedFilter.value = '';
              // controller.getTripsListData();
            },
          ),
        );
      }

      if (controller.startDate.value != null) {
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
      }

      return Row(children: filterChips);
    });
  }

  Widget _buildFilterChip({
    required String text,
    required VoidCallback onClose,
  }) {
    return Container(
      height: 24,
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFF3C65F2).withValues(alpha: 0.1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text.tr,
            style: StyleUtils.kTextStyleSize12Weight400(
              color: Color(0xFF3C65F2),
            ),
          ),
          7.widthBox,
          ZoomTapAnimation(
            onTap: onClose,
            child: Icon(Icons.close, size: 16, color: Color(0xFF3C65F2)),
          ),
        ],
      ),
    );
  }
}
