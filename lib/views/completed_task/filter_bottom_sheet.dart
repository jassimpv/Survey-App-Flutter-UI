import 'package:collect/controller/home_controller.dart';
import 'package:collect/utils/asset_utils.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:collect/views/widget/zoom_tap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FilterBottomSheet extends StatelessWidget {
  final HomeController controller = Get.find();

  FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "filter".tr,
                  style: StyleUtils.kTextStyleSize18Weight500(
                    color: ColorUtils.black,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
            16.heightBox,
            Row(
              children: [
                _buildDatePicker(context, true),
                10.widthBox,
                _buildDatePicker(context, false),
              ],
            ),
            // 16.heightBox,
            // ...controller.filterItems.map((item) {
            //   return _buildCheckboxListTile(
            //     item["value"]!,
            //     item["title"]!,
            //     item["icon"]!,
            //   );
            // }),
            20.heightBox,
            ZoomTapAnimation(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 10,
                height: 56,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorUtils.themeColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "applyFilter".tr,
                    style: StyleUtils.kTextStyleSize18Weight400(
                      color: ColorUtils.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
            15.heightBox,
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, bool isStart) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.pickDate(context, isStart),
        child: Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  AssetUtils.getIcons("ic_filter_calendar_blank"),
                  height: 18,
                  width: 18,
                ),
                8.widthBox,
                Text(
                  isStart
                      ? (controller.startDate.value != null
                            ? DateFormat(
                                'dd/MM/yyyy',
                              ).format(controller.startDate.value!)
                            : "start_date".tr)
                      : (controller.endDate.value != null
                            ? DateFormat(
                                'dd/MM/yyyy',
                              ).format(controller.endDate.value!)
                            : "end_date".tr),
                  style: StyleUtils.kTextStyleSize14Weight400(
                    color: ColorUtils.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildCheckboxListTile(String value, String title, String icon) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 6),
  //     child: ZoomTapAnimation(
  //       onTap: () {
  //         if (controller.selectedFilter.value == value) {
  //           controller.selectedFilter.value = '';
  //         } else {
  //           controller.selectedFilter.value = value;
  //         }
  //       },
  //       child: Row(
  //         children: [
  //           8.widthBox,
  //           Image.asset(AssetUtils.getIcons(icon), height: 18, width: 18),
  //           8.widthBox,
  //           Text(
  //             title.tr,
  //             style: StyleUtils.kTextStyleSize14Weight400(
  //               color: ColorUtils.black,
  //             ),
  //           ),
  //           const Spacer(),
  //           Obx(
  //             () => Container(
  //               width: 20,
  //               height: 20,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(4),
  //                 border: Border.all(color: ColorUtils.themeColor),
  //                 color: controller.selectedFilter.value == value
  //                     ? ColorUtils.themeColor
  //                     : ColorUtils.whiteColor,
  //               ),
  //               child: controller.selectedFilter.value == value
  //                   ? const Icon(Icons.check, size: 16, color: Colors.white)
  //                   : null,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
