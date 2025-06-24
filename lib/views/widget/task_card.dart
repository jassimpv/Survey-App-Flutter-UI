import 'package:collect/utils/utils_helper.dart';
import 'package:collect/views/widget/task_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collect/models/task_card_model.dart';
import 'package:collect/utils/asset_utils.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:collect/views/widget/zoom_tap.dart';

class TaskCard extends StatelessWidget {
  final String? currentStatus;
  final TransferCardData bookingData;
  final bool isNext;
  final bool ongoingTrip;
  final bool isFromList;
  final bool isCompleted;
  final Function? scrollToMiddle;

  const TaskCard({
    super.key,
    required this.bookingData,
    required this.currentStatus,
    this.isNext = false,
    this.ongoingTrip = false,
    this.isFromList = false,
    this.isCompleted = false,
    this.scrollToMiddle,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () {
        if (scrollToMiddle != null) {
          scrollToMiddle!();
        }
        FocusScope.of(context).unfocus();

        Get.dialog(
          TaskDialog(data: bookingData),
          barrierDismissible: false,
          useSafeArea: true,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ongoingTrip ? ColorUtils.lightGreen : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: ongoingTrip
                ? _ongoingColor()
                : const Color.fromRGBO(85, 109, 220, 0.10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildHeader(), 8.heightBox, _buildBody()],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [_buildIcon(), 8.widthBox, _buildTransferInfo()]),
        Row(
          children: [
            _buildActionIcon(
              onTap: () => Utils.openMap(["25.2048", "55.2708"]),
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
  }

  Widget _buildIcon() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: ColorUtils.themeColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        Icons.restaurant,
        color: ongoingTrip ? ColorUtils.darkGreen : ColorUtils.whiteColor,
        size: 20,
      ),
    );
  }

  Widget _buildTransferInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
  }

  Widget _buildBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
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
              "lastVisited",
              bookingData.lastVistedDate.createdAt,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            PassengerCount(emirate: bookingData.emirate),
            10.heightBox,
            Row(
              children: [
                Image.asset(
                  AssetUtils.getIcons("ic_ride_list"),
                  height: 26,
                  color: ColorUtils.backgroundDark,
                ),
                10.widthBox,
                Text(
                  bookingData.distance,
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
  }

  Widget _buildActionIcon({
    required VoidCallback? onTap,
    required String assetName,
    Color iconColor = ColorUtils.themeColor,
  }) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        height: 32,
        width: 32,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Color(0xffEDF1FB),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          AssetUtils.getIcons(assetName),
          color: iconColor,
          height: 22,
          width: 22,
        ),
      ),
    );
  }

  Widget _buildLocationText(String label, DateTime time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.tr,
          style: StyleUtils.kTextStyleSize12Weight500(
            color: ongoingTrip
                ? ColorUtils.green.withValues(alpha: 0.8)
                : ColorUtils.darkBlue.withValues(alpha: 0.8),
          ),
        ),
        Text(
          Utils.timeAgo(time),
          style: StyleUtils.kTextStyleSize12Weight500(
            color: ColorUtils.darkGray,
          ),
        ),
      ],
    );
  }

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
  final String emirate;

  const PassengerCount({super.key, required this.emirate});

  @override
  Widget build(BuildContext context) {
    return InfoContainer(
      text: emirate,
      style: StyleUtils.kTextStyleSize14Weight600(color: Colors.white),
      backgroundColor: ColorUtils.secondaryColor,
    );
  }
}

class InfoContainer extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color backgroundColor;

  const InfoContainer({
    super.key,
    required this.text,
    required this.style,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: style),
    );
  }
}
