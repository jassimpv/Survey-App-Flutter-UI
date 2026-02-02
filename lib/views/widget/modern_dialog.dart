import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/theme_service.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class ModernDialog extends StatelessWidget {
  const ModernDialog({
    required this.title,
    required this.message,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.isDangerous = false,
    this.icon,
    super.key,
  });

  final String title;
  final String message;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDangerous;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final Color actionColor = isDangerous
        ? ColorUtils.red
        : ColorUtils.themeColor;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: ThemeService.isDark()
                  ? const Color(0xFF1A2332).withOpacity(0.95)
                  : Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: ThemeService.isDark()
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (icon != null) ...[
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          actionColor.withOpacity(0.2),
                          actionColor.withOpacity(0.05),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: actionColor, size: 32),
                  ),
                  20.heightBox,
                ],
                Text(
                  title,
                  style: StyleUtils.kTextStyleSize20Weight600(
                    color: ThemeService.isDark()
                        ? Colors.white
                        : ColorUtils.headingColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                12.heightBox,
                Text(
                  message,
                  style: StyleUtils.kTextStyleSize16Weight400(
                    color: ThemeService.isDark()
                        ? const Color(0xFF9CA3AF)
                        : ColorUtils.greyTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                24.heightBox,
                Row(
                  children: <Widget>[
                    if (cancelText != null) ...[
                      Expanded(
                        child: _ModernDialogButton(
                          text: cancelText!,
                          onPressed:
                              onCancel ?? () => Navigator.of(context).pop(),
                          isSecondary: true,
                        ),
                      ),
                      12.widthBox,
                    ],
                    Expanded(
                      child: _ModernDialogButton(
                        text: confirmText ?? 'ok'.tr,
                        onPressed:
                            onConfirm ?? () => Navigator.of(context).pop(),
                        color: actionColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModernDialogButton extends StatelessWidget {
  const _ModernDialogButton({
    required this.text,
    required this.onPressed,
    this.color,
    this.isSecondary = false,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = color ?? ColorUtils.themeColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: isSecondary
                ? null
                : LinearGradient(
                    colors: <Color>[buttonColor, buttonColor.withOpacity(0.8)],
                  ),
            color: isSecondary
                ? (ThemeService.isDark()
                      ? const Color(0xFF2D3E50)
                      : const Color(0xFFF4F7FF))
                : null,
            borderRadius: BorderRadius.circular(16),
            border: isSecondary
                ? Border.all(
                    color: ThemeService.isDark()
                        ? Colors.white.withOpacity(0.1)
                        : buttonColor.withOpacity(0.2),
                  )
                : null,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: StyleUtils.kTextStyleSize16Weight600(
              color: isSecondary
                  ? (ThemeService.isDark()
                        ? Colors.white
                        : ColorUtils.headingColor)
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Helper function to show modern dialog
Future<void> showModernDialog({
  required BuildContext context,
  required String title,
  required String message,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool isDangerous = false,
  IconData? icon,
}) => showDialog<void>(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) => ModernDialog(
    title: title,
    message: message,
    confirmText: confirmText,
    cancelText: cancelText,
    onConfirm: onConfirm,
    onCancel: onCancel,
    isDangerous: isDangerous,
    icon: icon,
  ),
);
