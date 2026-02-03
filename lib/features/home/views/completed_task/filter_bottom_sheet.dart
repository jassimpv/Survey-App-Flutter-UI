import "dart:ui";

import "package:collect/features/home/controller/home_controller.dart";

import "package:collect/core/theme/theme_colors.dart";

import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/theme/theme_service.dart";
import "package:collect/core/widgets/zoom_tap.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";

class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet({super.key});
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: ThemeColors.modalBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            border: Border.all(color: ThemeColors.modalBorder, width: 1),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: ThemeColors.shadow,
                blurRadius: 30,
                offset: const Offset(0, -6),
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
                    color: ThemeColors.onSurfaceSecondary.withValues(
                      alpha: 0.3,
                    ),
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
                        color: ThemeColors.onSurface,
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ThemeColors.surface,
                      ),
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.xmark,
                          color: ThemeColors.onSurface,
                          size: 18,
                        ),
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
                      gradient: ThemeColors.primaryGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: ThemeColors.primary.withValues(alpha: 0.3),
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
              color: ThemeService.isDark()
                  ? Colors.white.withValues(alpha: 0.08)
                  : ThemeColors.themeColor.withValues(alpha: 0.2),
            ),
            color: ThemeService.isDark()
                ? const Color(0xFF0F1720).withValues(alpha: 0.6)
                : ThemeColors.scaffoldColor,
          ),
          child: Row(
            children: <Widget>[
              Icon(
                CupertinoIcons.calendar,
                size: 18,
                color: ThemeService.isDark()
                    ? Colors.white.withValues(alpha: 0.8)
                    : ThemeColors.headingColor.withValues(alpha: 0.7),
              ),
              10.widthBox,
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
                  color: ThemeService.isDark()
                      ? Colors.white
                      : ThemeColors.headingColor,
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
  //               color: ThemeColors.black,
  //             ),
  //           ),
  //           const Spacer(),
  //           Obx(
  //             () => Container(
  //               width: 20,
  //               height: 20,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(4),
  //                 border: Border.all(color: ThemeColors.themeColor),
  //                 color: controller.selectedFilter.value == value
  //                     ? ThemeColors.themeColor
  //                     : ThemeColors.whiteColor,
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

