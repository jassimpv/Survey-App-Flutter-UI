import 'dart:io';

import 'package:collect/core/theme/theme_controller.dart';
import 'package:collect/core/theme/theme_colors.dart';
import 'package:collect/core/utils/textstyle_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeWidget extends GetView<ThemeController> {
  const ThemeWidget({super.key});

  static const List<ThemeMode> _themeModes = <ThemeMode>[
    ThemeMode.light,
    ThemeMode.dark,
    ThemeMode.system,
  ];

  static const Map<ThemeMode, IconData> _themeIcons = <ThemeMode, IconData>{
    ThemeMode.light: Icons.light_mode_rounded,
    ThemeMode.dark: Icons.dark_mode_rounded,
    ThemeMode.system: Icons.brightness_auto_rounded,
  };

  static const Map<ThemeMode, String> _themeLabels = <ThemeMode, String>{
    ThemeMode.light: 'light',
    ThemeMode.dark: 'dark',
    ThemeMode.system: 'system',
  };

  @override
  Widget build(BuildContext context) {
    Get.put<ThemeController>(ThemeController());
    return GestureDetector(
      onTap: () => _showThemeMenu(context),
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: ThemeColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ThemeColors.primary.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        ScaleTransition(scale: animation, child: child),
                child: Icon(
                  controller.getThemeIcon(controller.selectedMode.value),
                  key: ValueKey<ThemeMode>(controller.selectedMode.value),
                  size: 18,
                  color: ThemeColors.blackWhite,
                ),
              ),
              8.widthBox,
              Text(
                controller.getThemeName(controller.selectedMode.value),
                style: StyleUtils.kTextStyleThemeMode(
                  color: ThemeColors.blackWhite,
                ),
              ),
              8.widthBox,
              Icon(
                CupertinoIcons.chevron_down,
                size: 16,
                color: ThemeColors.blackWhite.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showThemeMenu(BuildContext context) {
    if (Platform.isIOS) {
      _showIOSThemeMenu(context);
    } else {
      _showAndroidThemeMenu(context);
    }
  }

  void _showIOSThemeMenu(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'theme'.tr,
            style: StyleUtils.kTextStyleDialogTitle(
              color: ThemeColors.blackWhite,
            ),
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          for (final ThemeMode mode in _themeModes)
            _buildIOSThemeOption(mode, context),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: Text(
            'cancel'.tr,
            style: StyleUtils.kTextStyleMenuItemLabel(
              color: ThemeColors.blackWhite,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _showAndroidThemeMenu(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: ThemeColors.surface,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'theme'.tr,
                style: StyleUtils.kTextStyleDialogTitle(
                  color: ThemeColors.blackWhite,
                ),
              ),
              16.heightBox,
              ...List<Widget>.generate(_themeModes.length, (int index) {
                final ThemeMode mode = _themeModes[index];
                if (index > 0) {
                  return Column(
                    children: <Widget>[
                      8.heightBox,
                      _buildAndroidThemeOption(mode, context),
                    ],
                  );
                }
                return _buildAndroidThemeOption(mode, context);
              }),
              16.heightBox,
              Divider(color: ThemeColors.greyTextColor.withValues(alpha: 0.2)),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'cancel'.tr,
                    style: StyleUtils.kTextStyleMenuItemLabel(
                      color: ThemeColors.whitePrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CupertinoActionSheetAction _buildIOSThemeOption(
    ThemeMode mode,
    BuildContext context,
  ) => CupertinoActionSheetAction(
    isDefaultAction: controller.selectedMode.value == mode,
    child: Row(
      children: <Widget>[
        Icon(_themeIcons[mode]!, color: ThemeColors.blackWhite),
        12.widthBox,
        Text(
          _themeLabels[mode]!.tr,
          style: StyleUtils.kTextStyleMenuItemLabel(
            color: ThemeColors.blackWhite,
          ),
        ),
        const Spacer(),
        if (controller.selectedMode.value == mode)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Icon(
              CupertinoIcons.checkmark_alt,
              color: ThemeColors.whitePrimary,
              size: 18,
            ),
          ),
      ],
    ),
    onPressed: () {
      controller.updateTheme(mode);
      Navigator.pop(context);
    },
  );

  Widget _buildAndroidThemeOption(ThemeMode mode, BuildContext context) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            controller.updateTheme(mode);
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Row(
              children: <Widget>[
                Icon(
                  _themeIcons[mode]!,
                  color: ThemeColors.blackWhite,
                  size: 24,
                ),
                12.widthBox,
                Expanded(
                  child: Text(
                    _themeLabels[mode]!.tr,
                    style: StyleUtils.kTextStyleMenuItemLabel(
                      color: ThemeColors.blackWhite,
                    ),
                  ),
                ),
                if (controller.selectedMode.value == mode)
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Icon(
                      Icons.check_rounded,
                      color: ThemeColors.whitePrimary,
                      size: 24,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}

extension on int {
  SizedBox get widthBox => SizedBox(width: toDouble());
  SizedBox get heightBox => SizedBox(height: toDouble());
}
