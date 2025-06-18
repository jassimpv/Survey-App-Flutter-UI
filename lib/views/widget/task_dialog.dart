import 'package:collect/controller/home_controller.dart';
import 'package:collect/models/task_card_model.dart';
import 'package:collect/utils/asset_utils.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:collect/utils/utils_helper.dart';
import 'package:collect/views/widget/zoom_tap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'task_card.dart';

class TaskDialog extends StatelessWidget {
  final TransferCardData data;
  TaskDialog({super.key, required this.data});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    10.heightBox,
                    _content(),
                    10.heightBox,
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Task Details",
          style: StyleUtils.kTextStyleSize17Weight600(
            color: Colors.black.withValues(alpha: 0.8),
          ),
        ),
        PassengerCount(emirate: data.emirate),
      ],
    );
  }

  Widget _buildTransferInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.restaurantName,
          style: StyleUtils.kTextStyleSize14Weight600(color: _titleColor()),
        ),
        Text(
          data.restaurantType,
          style: StyleUtils.kTextStyleSize14Weight500(
            color: ColorUtils.darkBlue,
          ),
        ),
      ],
    );
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [_buildIcon(), 8.widthBox, _buildTransferInfo()]),

            Row(
              children: [
                _buildActionIcon(
                  onTap: () => Utils.openMap(["25.2048", "55.2708"]),
                  assetName: "ic_location",
                  iconColor: _titleColor(),
                ),
                8.widthBox,
                _buildActionIcon(
                  onTap: () => Utils.dail("1234567890"),
                  assetName: "ic_call",
                  iconColor: _titleColor(),
                ),
              ],
            ),
          ],
        ),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: ColorUtils.darkBlue,
                      size: 16,
                    ),
                    8.widthBox,
                    Text(
                      data.restaurantAddress,
                      style: StyleUtils.kTextStyleSize12Weight500(
                        color: ColorUtils.darkBlue.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
                10.heightBox,
                _buildLocationText(
                  "lastVisited",
                  data.lastVistedDate.createdAt,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AssetUtils.getIcons("ic_ride_list"),
                      height: 24,
                      color: _titleColor(),
                    ),
                    10.widthBox,
                    Text(
                      data.distance,
                      style: StyleUtils.kTextStyleSize12Weight500(
                        color: ColorUtils.darkBlue.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationText(String label, DateTime time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.tr,
          style: StyleUtils.kTextStyleSize12Weight500(
            color: ColorUtils.darkBlue.withValues(alpha: 0.8),
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

  Color _titleColor() {
    return ColorUtils.black;
  }

  Widget _buildIcon() {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: ColorUtils.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(Icons.restaurant, color: ColorUtils.whiteColor, size: 16),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorUtils.themeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "New Sample",
                style: StyleUtils.kTextStyleSize18Weight400(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        6.widthBox,
        Expanded(
          child: SizedBox(
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                Get.back();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Cancel",
                style: StyleUtils.kTextStyleSize18Weight400(color: Colors.red),
              ),
            ),
          ),
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
}
