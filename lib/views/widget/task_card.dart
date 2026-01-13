import "package:collect/models/task_card_model.dart";
import "package:collect/utils/asset_utils.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/sized_box_extension.dart";
import "package:collect/utils/textstyle_input.dart";
import "package:collect/utils/utils_helper.dart";
import "package:collect/views/widget/task_dialog.dart";
import "package:collect/views/widget/zoom_tap.dart";
import "package:flutter/material.dart";
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
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ongoingTrip ? ColorUtils.lightGreen : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ongoingTrip
              ? _ongoingColor()
              : ColorUtils.themeColor.withValues(alpha: 0.12),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: ongoingTrip
                ? ColorUtils.green.withValues(alpha: 0.1)
                : ColorUtils.themeColor.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_buildHeader(), 12.heightBox, _buildBody()],
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
            iconColor: ColorUtils.backgroundDark,
          ),
          8.widthBox,
          _buildActionIcon(
            onTap: () => Utils.dail("1234567890"),
            assetName: "ic_call",
            iconColor: ColorUtils.backgroundDark,
          ),
        ],
      ),
    ],
  );

  Widget _buildIcon() {
    final Color iconColor = ongoingTrip
        ? ColorUtils.darkGreen
        : ColorUtils.themeColor;

    return Container(
      height: 52,
      width: 52,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            ColorUtils.themeColor.withValues(alpha: 0.18),
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: ColorUtils.themeColor.withValues(alpha: 0.12),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ColorUtils.themeColor.withValues(alpha: 0.15),
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
          color: ColorUtils.backgroundDark,
        ),
      ),
      Text(
        bookingData.restaurantType,
        style: StyleUtils.kTextStyleSize14Weight500(
          color: ongoingTrip
              ? ColorUtils.green.withValues(alpha: 0.7)
              : ColorUtils.darkBlue,
        ),
      ),
    ],
  );

  Widget _buildBody() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: ongoingTrip ? ColorUtils.green : ColorUtils.darkBlue,
                size: 18,
              ),
              8.widthBox,
              Text(
                bookingData.restaurantAddress,
                style: StyleUtils.kTextStyleSize14Weight500(
                  color: ongoingTrip
                      ? ColorUtils.green.withValues(alpha: 0.8)
                      : ColorUtils.darkBlue.withValues(alpha: 0.8),
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          PassengerCount(emirate: bookingData.emirate),
          10.heightBox,
          Row(
            children: <Widget>[
              Image.asset(
                AssetUtils.getIcons("ic_ride_list"),
                height: 26,
                color: ColorUtils.backgroundDark,
              ),
              10.widthBox,
              Text(
                Utils.replaceFarsiNumber(bookingData.distance),
                style: StyleUtils.kTextStyleSize14Weight500(
                  color: ongoingTrip
                      ? ColorUtils.green.withValues(alpha: 0.8)
                      : ColorUtils.darkBlue.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  Widget _buildActionIcon({
    required VoidCallback? onTap,
    required String assetName,
    Color iconColor = ColorUtils.themeColor,
  }) => ZoomTapAnimation(
    onTap: onTap,
    child: Container(
      height: 42,
      width: 42,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Colors.white, ColorUtils.scaffoldColor],
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: ColorUtils.themeColor.withValues(alpha: 0.08),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ColorUtils.themeColor.withValues(alpha: 0.1),
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
              ? ColorUtils.green.withValues(alpha: 0.8)
              : ColorUtils.darkBlue.withValues(alpha: 0.8),
        ),
      ),
      Text(
        Utils.replaceFarsiNumber(Utils.timeAgo(time)),
        style: StyleUtils.kTextStyleSize12Weight500(color: ColorUtils.darkGray),
      ),
    ],
  );

  // Helpers
  Color _ongoingColor() {
    switch (currentStatus) {
      case "dow":
        return const Color(0xffA88FF3);
      case "dpp":
        return const Color(0xffECEC00);
      case "Trip_started":
      case "route_update":
        return const Color(0xff12B76A);
      case "complete_trip":
        return const Color(0xff5B5B77);
      default:
        return Colors.transparent;
    }
  }
}

class PassengerCount extends StatelessWidget {
  const PassengerCount({required this.emirate, super.key});
  final String emirate;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: ColorUtils.secondaryColor.withValues(alpha: 0.35),
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: ColorUtils.secondaryColor.withValues(alpha: 0.18),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Text(
      emirate,
      style: StyleUtils.kTextStyleSize14Weight600(
        color: ColorUtils.secondaryColor,
      ),
    ),
  );
}

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    required this.text,
    required this.style,
    super.key,
    this.backgroundColor = Colors.white,
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
