import "package:collect/core/models/task_card_model.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/utils/utils_helper.dart";
import "package:collect/core/widgets/zoom_tap.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class SurveyCard extends StatelessWidget {
  const SurveyCard({
    required this.bookingData,
    required this.currentStatus,
    super.key,
    this.isNext = false,
    this.ongoingTrip = false,
    this.isFromList = false,
    this.isCompleted = false,
  });
  final String? currentStatus;
  final TransferCardData bookingData;
  final bool isNext;
  final bool ongoingTrip;
  final bool isFromList;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) => ZoomTapAnimation(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ongoingTrip ? ThemeColors.lightGreen : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ongoingTrip
              ? _ongoingColor()
              : const Color.fromRGBO(85, 109, 220, 0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_buildHeader(), 8.heightBox, _buildBody()],
      ),
    ),
  );

  Widget _buildHeader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(children: <Widget>[_buildIcon(), 8.widthBox, _buildTransferInfo()]),
      PassengerCount(weight: bookingData.wasteKg),
    ],
  );

  Widget _buildIcon() => Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      color: ThemeColors.themeColor,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Icon(
      Icons.restaurant,
      color: ongoingTrip ? ThemeColors.darkGreen : ThemeColors.whiteColor,
      size: 16,
    ),
  );

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
        style: StyleUtils.kTextStyleSize16Weight400(
          color: ongoingTrip
              ? ThemeColors.green.withValues(alpha: 0.7)
              : ThemeColors.darkBlue,
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
                color: ongoingTrip ? ThemeColors.green : ThemeColors.darkBlue,
                size: 18,
              ),
              8.widthBox,
              Text(
                bookingData.restaurantAddress,
                style: StyleUtils.kTextStyleSize14Weight400(
                  color: ongoingTrip
                      ? ThemeColors.green.withValues(alpha: 0.8)
                      : ThemeColors.darkBlue.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          10.heightBox,
          Row(
            children: <Widget>[
              Icon(
                Icons.shopping_bag_outlined,
                color: ongoingTrip ? ThemeColors.green : ThemeColors.darkBlue,
                size: 20,
              ),
              8.widthBox,
              Text(
                "Fruits",
                style: StyleUtils.kTextStyleSize14Weight500(
                  color: ThemeColors.black.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Icon(
            CupertinoIcons.calendar,
            color: ongoingTrip ? ThemeColors.green : ThemeColors.darkBlue,
            size: 18,
          ),
          5.widthBox,
          Text(
            Utils.formatDate(bookingData.lastVistedDate.createdAt),
            style: StyleUtils.kTextStyleSize14Weight500(
              color: ThemeColors.darkGray,
            ),
          ),
        ],
      ),
    ],
  );

  // Helpers
  Color _ongoingColor() {
    switch (currentStatus) {
      case "dow":
        return ThemeColors.statusPurple;
      case "dpp":
        return ThemeColors.statusYellow;
      case "Trip_started":
      case "route_update":
        return ThemeColors.statusGreen;
      case "complete_trip":
        return ThemeColors.statusGray;
      default:
        return Colors.transparent;
    }
  }
}

class PassengerCount extends StatelessWidget {
  const PassengerCount({required this.weight, super.key});
  final String weight;

  @override
  Widget build(BuildContext context) => InfoContainer(
    text: weight,
    style: StyleUtils.kTextStyleSize14Weight600(color: Colors.white),
    backgroundColor: ThemeColors.secondaryColor,
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
    child: Row(children: <Widget>[Text(text, style: style)]),
  );
}
