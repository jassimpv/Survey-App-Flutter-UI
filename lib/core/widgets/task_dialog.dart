import "dart:ui";

import "package:collect/core/models/task_card_model.dart";
import "package:collect/routes.dart";
import "package:collect/core/utils/asset_utils.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/utils/utils_helper.dart";
import "package:collect/core/widgets/zoom_tap.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class TaskDialog extends StatelessWidget {
  TaskDialog({required this.data, super.key});
  final TransferCardData data;

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ThemeColors.dialogBackground.withValues(
                        alpha: 0.85,
                      ),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: ThemeColors.dialogBorder,
                        width: 1,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: ThemeColors.primary.withValues(alpha: 0.18),
                          blurRadius: 32,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildHeader(),
                        20.heightBox,
                        _content(),
                        24.heightBox,
                        _buildActionButtons(data),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Widget _buildHeader() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Location Details",
              style: StyleUtils.kTextStyleSize20Weight600(
                color: ThemeColors.onSurface,
              ),
            ),
            8.heightBox,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: ThemeColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: ThemeColors.primary,
                  ),
                  6.widthBox,
                  Text(
                    data.emirate,
                    style: StyleUtils.kTextStyleSize14Weight500(
                      color: ThemeColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ZoomTapAnimation(
        onTap: Get.back,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: ThemeColors.primaryGradient,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: ThemeColors.shadow,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(Icons.close, color: ThemeColors.whiteColor),
        ),
      ),
    ],
  );

  Widget _buildTransferInfo() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        data.restaurantName,
        style: StyleUtils.kTextStyleSize18Weight600(
          color: ThemeColors.onSurface,
        ),
      ),
      4.heightBox,
      Text(
        data.restaurantType,
        style: StyleUtils.kTextStyleSize14Weight400(
          color: ThemeColors.onSurface.withValues(alpha: 0.7),
        ),
      ),
    ],
  );

  Widget _content() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ThemeColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: _buildTransferInfo()),
                Row(
                  children: <Widget>[
                    _buildActionIcon(
                      onTap: () =>
                          Utils.openMap(<String?>["25.2048", "55.2708"]),
                      icon: Icons.location_on,
                      iconColor: ThemeColors.whiteColor,
                    ),
                    12.widthBox,
                    _buildActionIcon(
                      onTap: () => Utils.dail("1234567890"),
                      icon: Icons.call,
                      iconColor: ThemeColors.whiteColor,
                    ),
                  ],
                ),
              ],
            ),
            20.heightBox,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: ThemeColors.primary,
                            size: 18,
                          ),
                          8.widthBox,
                          Expanded(
                            child: Text(
                              data.restaurantAddress,
                              style: StyleUtils.kTextStyleSize14Weight500(
                                color: ThemeColors.onSurface.withValues(
                                  alpha: 0.85,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      12.heightBox,
                      _buildLocationText(
                        "lastVisited",
                        data.lastVistedDate.createdAt,
                      ),
                    ],
                  ),
                ),
                16.widthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: ThemeColors.surface,
                      ),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            AssetUtils.getIcons("ic_ride_list"),
                            height: 24,
                            color: ThemeColors.primary,
                          ),
                          8.widthBox,
                          Text(
                            Utils.replaceFarsiNumber(data.distance),
                            style: StyleUtils.kTextStyleSize14Weight500(
                              color: ThemeColors.onSurface.withValues(
                                alpha: 0.85,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildLocationText(String label, DateTime time) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label.tr,
        style: StyleUtils.kTextStyleSize12Weight500(
          color: ThemeColors.onSurface.withValues(alpha: 0.8),
        ),
      ),
      Text(
        Utils.replaceFarsiNumber(Utils.timeAgo(time)),
        style: StyleUtils.kTextStyleSize12Weight500(
          color: ThemeColors.onSurface.withValues(alpha: 0.6),
        ),
      ),
    ],
  );

  Widget _buildActionButtons(TransferCardData data) => Row(
    children: <Widget>[
      Expanded(
        child: ZoomTapAnimation(
          onTap: () =>
              Get.toNamed(AppRouter.collectionDataScreen, arguments: data),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ThemeColors.surface,
              border: Border.all(color: ThemeColors.primary, width: 1.5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: ThemeColors.primary.withValues(alpha: 0.15),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "View Collection History",
                style: StyleUtils.kTextStyleSize16Weight600(
                  color: ThemeColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      12.widthBox,
      Expanded(
        child: ZoomTapAnimation(
          onTap: () =>
              Get.toNamed(AppRouter.addCollectionScreen, arguments: data),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: ThemeColors.primaryGradient,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: ThemeColors.primary.withValues(alpha: 0.3),
                  blurRadius: 25,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "Record New Collection",
                style: StyleUtils.kTextStyleSize16Weight600(
                  color: ThemeColors.whiteColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget _buildActionIcon({
    required VoidCallback? onTap,
    required IconData icon,
    Color iconColor = ThemeColors.themeColor,
  }) => ZoomTapAnimation(
    onTap: onTap,
    child: Container(
      height: 30,
      width: 30,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: ThemeColors.primaryGradient,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ThemeColors.shadow,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Icon(icon, color: iconColor, size: 15),
    ),
  );
}
