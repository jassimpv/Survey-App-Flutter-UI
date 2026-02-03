import 'package:collect/core/theme/theme_controller.dart';
import 'package:collect/core/theme/theme_colors.dart';
import 'package:collect/core/utils/textstyle_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeWidget extends GetView<ThemeController> {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<ThemeController>(ThemeController());
    return GestureDetector(
      onTap: () => _showThemeMenu(context),
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: ThemeColors.whiteColor.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ThemeColors.primary.withValues(alpha: 0.10),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                controller.getThemeIcon(controller.selectedMode.value),
                size: 18,
                color: ThemeColors.primary,
              ),
              8.widthBox,
              Text(
                controller.getThemeName(controller.selectedMode.value),
                style: StyleUtils.kTextStyleThemeMode(),
              ),
              8.widthBox,
              Icon(
                CupertinoIcons.chevron_down,
                size: 16,
                color: ThemeColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showThemeMenu(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('theme'.tr, style: StyleUtils.kTextStyleDialogTitle()),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: controller.selectedMode.value == ThemeMode.light,
            child: Row(
              children: <Widget>[
                Icon(Icons.light_mode_rounded),
                12.widthBox,
                Expanded(
                  child: Text(
                    'light'.tr,
                    style: StyleUtils.kTextStyleMenuItemLabel(),
                  ),
                ),
              ],
            ),
            onPressed: () {
              controller.updateTheme(ThemeMode.light);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            isDefaultAction: controller.selectedMode.value == ThemeMode.dark,
            child: Row(
              children: <Widget>[
                Icon(Icons.dark_mode_rounded),
                12.widthBox,
                Expanded(
                  child: Text(
                    'dark'.tr,
                    style: StyleUtils.kTextStyleMenuItemLabel(),
                  ),
                ),
              ],
            ),
            onPressed: () {
              controller.updateTheme(ThemeMode.dark);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            isDefaultAction: controller.selectedMode.value == ThemeMode.system,
            child: Row(
              children: <Widget>[
                Icon(Icons.brightness_auto_rounded),
                12.widthBox,
                Expanded(
                  child: Text(
                    'system'.tr,
                    style: StyleUtils.kTextStyleMenuItemLabel(),
                  ),
                ),
              ],
            ),
            onPressed: () {
              controller.updateTheme(ThemeMode.system);
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: Text('cancel'.tr, style: StyleUtils.kTextStyleMenuItemLabel()),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

extension on int {
  SizedBox get widthBox => SizedBox(width: toDouble());
}
