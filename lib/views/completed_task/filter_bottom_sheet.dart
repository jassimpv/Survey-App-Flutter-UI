import "package:collect/controller/home_controller.dart";
import "package:collect/utils/asset_utils.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/sized_box_extension.dart";
import "package:collect/utils/textstyle_input.dart";
import "package:collect/views/widget/zoom_tap.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";

class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet({super.key});
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 4,
              width: 56,
              decoration: BoxDecoration(
                color: ColorUtils.themeColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            16.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "filter".tr,
                  style: StyleUtils.kTextStyleSize18Weight600(
                    color: ColorUtils.headingColor,
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorUtils.scaffoldColor,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
            20.heightBox,
            Row(
              children: <Widget>[
                _buildDatePicker(context, true),
                12.widthBox,
                _buildDatePicker(context, false),
              ],
            ),
            24.heightBox,
            ZoomTapAnimation(
              onTap: Get.back,
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      ColorUtils.themeColor,
                      ColorUtils.themeColor.withValues(alpha: 0.85),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: ColorUtils.themeColor.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "applyFilter".tr,
                    style: StyleUtils.kTextStyleSize18Weight500(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildDatePicker(BuildContext context, bool isStart) => Expanded(
    child: GestureDetector(
      onTap: () => controller.pickDate(context, isStart),
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: ColorUtils.themeColor.withValues(alpha: 0.2),
            ),
            color: ColorUtils.scaffoldColor,
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset(
                  AssetUtils.getIcons("ic_filter_calendar_blank"),
                  height: 18,
                  width: 18,
                ),
              ),
              12.widthBox,
              Text(
                isStart
                    ? (controller.startDate.value != null
                          ? DateFormat(
                              "dd/MM/yyyy",
                            ).format(controller.startDate.value!)
                          : "start_date".tr)
                    : (controller.endDate.value != null
                          ? DateFormat(
                              "dd/MM/yyyy",
                            ).format(controller.endDate.value!)
                          : "end_date".tr),
                style: StyleUtils.kTextStyleSize14Weight500(
                  color: ColorUtils.headingColor,
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

