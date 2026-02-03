import "package:collect/core/models/task_card_model.dart";
import "package:collect/core/utils/asset_utils.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/utils/utils_helper.dart";
import "package:collect/core/widgets/task_dialog.dart";
import "package:collect/core/widgets/zoom_tap.dart";
import "package:flutter/material.dart";
import "dart:ui" as ui;
import "package:get/get.dart";

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.bookingData,
    required this.currentStatus,
    super.key,
    this.isNext = false,
    this.ongoingTrip = false,
    this.isFromList = false,
    this.isCompleted = false,
    this.scrollToMiddle,
  });
  final String? currentStatus;
  final TransferCardData bookingData;
  final bool isNext;
  final bool ongoingTrip;
  final bool isFromList;
  final bool isCompleted;
  final Function? scrollToMiddle;

  @override
  Widget build(BuildContext context) => ZoomTapAnimation(
    onTap: () async {
      if (scrollToMiddle != null) {
        await scrollToMiddle!() ?? () {};
      }
      FocusScope.of(context).unfocus();

      await Get.dialog(
        TaskDialog(data: bookingData),
        barrierDismissible: false,
      );
    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ThemeColors.whiteColor.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: ThemeColors.whiteColor.withValues(alpha: 0.08),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: ThemeColors.blackColor.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[_buildHeader(), 12.heightBox, _buildBody()],
          ),
        ),
      ),
    ),
  );

  Widget _buildHeader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(children: <Widget>[_buildIcon(), 8.widthBox, _buildTransferInfo()]),
      Row(
        children: <Widget>[
          _buildActionIcon(
            onTap: () => Utils.openMap(<String?>["25.2048", "55.2708"]),
            assetName: "ic_location",
            iconColor: ThemeColors.backgroundDark,
          ),
          8.widthBox,
          _buildActionIcon(
            onTap: () => Utils.dail("1234567890"),
            assetName: "ic_call",
            iconColor: ThemeColors.backgroundDark,
          ),
        ],
      ),
    ],
  );

  Widget _buildIcon() {
    final Color iconColor = ongoingTrip
        ? ThemeColors.darkGreen
        : ThemeColors.themeColor;

    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            ThemeColors.whiteColor.withValues(alpha: 0.9),
            (ongoingTrip ? ThemeColors.darkGreen : ThemeColors.themeColor)
                .withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: ThemeColors.whiteColor.withValues(alpha: 0.12),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ThemeColors.blackColor.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(Icons.restaurant, color: iconColor, size: 24),
    );
  }

  Widget _buildTransferInfo() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        bookingData.restaurantName,
        style: StyleUtils.kTextStyleSize17Weight600(
          color: ThemeColors.backgroundDark,
        ),
      ),
      Text(
        bookingData.restaurantType,
        style: StyleUtils.kTextStyleSize14Weight500(
          color: ongoingTrip
              ? ThemeColors.green.withValues(alpha: 0.7)
              : ThemeColors.darkBlue,
        ),
      ),
    ],
  );

  Widget _buildBody() => Row(
    children: <Widget>[
      Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: ongoingTrip ? ThemeColors.green : ThemeColors.darkBlue,
                  size: 18,
                ),
                8.widthBox,
                Expanded(
                  child: Text(
                    bookingData.restaurantAddress,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: StyleUtils.kTextStyleSize14Weight500(
                      color: ongoingTrip
                          ? ThemeColors.green.withValues(alpha: 0.8)
                          : ThemeColors.darkBlue.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
            10.heightBox,
            _buildLocationText(
              "last collected".tr,
              bookingData.lastVistedDate.createdAt,
            ),
          ],
        ),
      ),
      8.widthBox,
      Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            PassengerCount(emirate: bookingData.emirate),
            10.heightBox,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  AssetUtils.getIcons("ic_ride_list"),
                  height: 26,
                  color: ThemeColors.backgroundDark,
                ),
                10.widthBox,
                Text(
                  Utils.replaceFarsiNumber(bookingData.distance),
                  style: StyleUtils.kTextStyleSize14Weight500(
                    color: ongoingTrip
                        ? ThemeColors.green.withValues(alpha: 0.8)
                        : ThemeColors.darkBlue.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildActionIcon({
    required VoidCallback? onTap,
    required String assetName,
    Color iconColor = ThemeColors.themeColor,
  }) => ZoomTapAnimation(
    onTap: onTap,
    child: Container(
      height: 42,
      width: 42,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[ThemeColors.whiteColor, ThemeColors.scaffoldColor],
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: ThemeColors.themeColor.withValues(alpha: 0.08),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ThemeColors.themeColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Image.asset(
        AssetUtils.getIcons(assetName),
        color: iconColor,
        height: 24,
        width: 24,
      ),
    ),
  );

  Widget _buildLocationText(String label, DateTime time) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label.tr,
        style: StyleUtils.kTextStyleSize12Weight500(
          color: ongoingTrip
              ? ThemeColors.green.withValues(alpha: 0.8)
              : ThemeColors.darkBlue.withValues(alpha: 0.8),
        ),
      ),
      Text(
        Utils.replaceFarsiNumber(Utils.timeAgo(time)),
        style: StyleUtils.kTextStyleSize12Weight500(
          color: ThemeColors.darkGray,
        ),
      ),
    ],
  );
}

class PassengerCount extends StatelessWidget {
  const PassengerCount({required this.emirate, super.key});
  final String emirate;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    decoration: BoxDecoration(
      color: ThemeColors.whiteColor.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: ThemeColors.darkGreen.withValues(alpha: 0.12)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: ThemeColors.blackColor.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Text(
      emirate,
      style: StyleUtils.kTextStyleSize14Weight600(color: ThemeColors.darkGreen),
    ),
  );
}

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    required this.text,
    required this.style,
    super.key,
    this.backgroundColor = ThemeColors.whiteColor,
  });
  final String text;
  final TextStyle style;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text, style: style),
  );
}
