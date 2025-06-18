import 'package:collect/utils/utils_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collect/models/task_card_model.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:collect/views/widget/zoom_tap.dart';

class SurveyCard extends StatelessWidget {
  final String? currentStatus;
  final TransferCardData bookingData;
  final bool isNext;
  final bool ongoingTrip;
  final bool isFromList;
  final bool isCompleted;

  const SurveyCard({
    super.key,
    required this.bookingData,
    required this.currentStatus,
    this.isNext = false,
    this.ongoingTrip = false,
    this.isFromList = false,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () => FocusScope.of(context).unfocus(),
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
        PassengerCount(weight: bookingData.wasteKg),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: _iconBgColor(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        Icons.restaurant,
        color: ongoingTrip ? ColorUtils.darkGreen : ColorUtils.whiteColor,
        size: 16,
      ),
    );
  }

  Widget _buildTransferInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bookingData.restaurantName,
          style: StyleUtils.kTextStyleSize14Weight600(color: _titleColor()),
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
                  size: 16,
                ),
                8.widthBox,
                Text(
                  bookingData.restaurantAddress,
                  style: StyleUtils.kTextStyleSize12Weight500(
                    color: ongoingTrip
                        ? ColorUtils.green.withValues(alpha: 0.8)
                        : ColorUtils.darkBlue.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
            10.heightBox,
            Row(
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  color: ongoingTrip ? ColorUtils.green : ColorUtils.darkBlue,
                  size: 20,
                ),
                8.widthBox,
                Text(
                  "Apple",
                  style: StyleUtils.kTextStyleSize14Weight500(
                    color: ColorUtils.black.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              CupertinoIcons.calendar,
              color: ongoingTrip ? ColorUtils.green : ColorUtils.darkBlue,
              size: 18,
            ),
            5.widthBox,
            Text(
              Utils.formatDate(
                bookingData.lastVistedDate.createdAt,
                format: 'dd/MM/yyyy',
              ),
              style: StyleUtils.kTextStyleSize12Weight500(
                color: ColorUtils.darkGray,
              ),
            ),
          ],
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

  Color _iconBgColor() {
    if (isNext) return ColorUtils.indigoBlueColor;
    if (ongoingTrip) return ColorUtils.whiteColor;
    if (isCompleted) return const Color(0xff9F9F9F);
    return ColorUtils.black;
  }

  Color _titleColor() {
    if (isNext) return ColorUtils.indigoBlueColor;
    if (ongoingTrip) return ColorUtils.green;
    if (isCompleted) return const Color(0xff9F9F9F);
    return ColorUtils.black;
  }
}

class PassengerCount extends StatelessWidget {
  final String weight;

  const PassengerCount({super.key, required this.weight});

  @override
  Widget build(BuildContext context) {
    return InfoContainer(
      text: weight,
      style: StyleUtils.kTextStyleSize14Weight600(color: Colors.white),
      backgroundColor: ColorUtils.red,
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
      child: Row(children: [Text(text, style: style)]),
    );
  }
}
