import "dart:ui";

import "package:collect/controller/home_controller.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/sized_box_extension.dart";
import "package:collect/utils/textstyle_input.dart";
import "package:collect/utils/theme_service.dart";
import "package:collect/views/widget/zoom_tap.dart";
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
            color: ThemeService.isDark()
                ? const Color(0xFF1A2332).withValues(alpha: 0.85)
                : Colors.white.withValues(alpha: 0.95),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            border: Border.all(
              color: ThemeService.isDark()
                  ? Colors.white.withValues(alpha: 0.08)
                  : ColorUtils.themeColor.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
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
                    color: ThemeService.isDark()
                        ? Colors.white.withValues(alpha: 0.2)
                        : ColorUtils.themeColor.withValues(alpha: 0.2),
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
                        color: ThemeService.isDark()
                            ? Colors.white
                            : ColorUtils.headingColor,
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ThemeService.isDark()
                            ? Colors.white.withValues(alpha: 0.08)
                            : ColorUtils.scaffoldColor,
                      ),
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.xmark,
                          color: ThemeService.isDark()
                              ? Colors.white
                              : Colors.black,
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
                      gradient: LinearGradient(
                        colors: ThemeService.isDark()
                            ? <Color>[
                                const Color(0xFF0FA394),
                                const Color(0xFF0FA394).withValues(alpha: 0.85),
                              ]
                            : <Color>[
                                ColorUtils.themeColor,
                                ColorUtils.themeColor.withValues(alpha: 0.85),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: ThemeService.isDark()
                              ? const Color(0xFF0FA394).withValues(alpha: 0.35)
                              : ColorUtils.themeColor.withValues(alpha: 0.2),
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
                  : ColorUtils.themeColor.withValues(alpha: 0.2),
            ),
            color: ThemeService.isDark()
                ? const Color(0xFF0F1720).withValues(alpha: 0.6)
                : ColorUtils.scaffoldColor,
          ),
          child: Row(
            children: <Widget>[
              Icon(
                CupertinoIcons.calendar,
                size: 18,
                color: ThemeService.isDark()
                    ? Colors.white.withValues(alpha: 0.8)
                    : ColorUtils.headingColor.withValues(alpha: 0.7),
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
                      : ColorUtils.headingColor,
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

