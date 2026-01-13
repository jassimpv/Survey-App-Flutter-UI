import "package:collect/models/task_card_model.dart";
import "package:collect/routes.dart";
import "package:collect/utils/asset_utils.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/sized_box_extension.dart";
import "package:collect/utils/textstyle_input.dart";
import "package:collect/utils/utils_helper.dart";
import "package:collect/views/widget/zoom_tap.dart";
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
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 45,
                      offset: const Offset(0, 20),
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
                color: ColorUtils.headingColor,
              ),
            ),
            8.heightBox,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: ColorUtils.scaffoldColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: ColorUtils.themeColor,
                  ),
                  6.widthBox,
                  Text(
                    data.emirate,
                    style: StyleUtils.kTextStyleSize14Weight500(
                      color: ColorUtils.darkBlue,
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
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[ColorUtils.themeColor, Color(0xFF1E8F87)],
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(17, 24, 39, 0.35),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(Icons.close, color: Colors.white),
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
          color: ColorUtils.headingColor,
        ),
      ),
      4.heightBox,
      Text(
        data.restaurantType,
        style: StyleUtils.kTextStyleSize14Weight400(
          color: ColorUtils.greyTextColor,
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
          color: ColorUtils.scaffoldColor.withValues(alpha: 0.9),
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
                      iconColor: Colors.white,
                    ),
                    12.widthBox,
                    _buildActionIcon(
                      onTap: () => Utils.dail("1234567890"),
                      icon: Icons.call,
                      iconColor: Colors.white,
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
                          const Icon(
                            Icons.location_on,
                            color: ColorUtils.darkBlue,
                            size: 18,
                          ),
                          8.widthBox,
                          Expanded(
                            child: Text(
                              data.restaurantAddress,
                              style: StyleUtils.kTextStyleSize14Weight500(
                                color: ColorUtils.darkBlue.withValues(
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
                        color: Colors.white,
                      ),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            AssetUtils.getIcons("ic_ride_list"),
                            height: 24,
                            color: ColorUtils.themeColor,
                          ),
                          8.widthBox,
                          Text(
                            Utils.replaceFarsiNumber(data.distance),
                            style: StyleUtils.kTextStyleSize14Weight500(
                              color: ColorUtils.darkBlue.withValues(
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
          color: ColorUtils.darkBlue.withValues(alpha: 0.8),
        ),
      ),
      Text(
        Utils.replaceFarsiNumber(Utils.timeAgo(time)),
        style: StyleUtils.kTextStyleSize12Weight500(color: ColorUtils.darkGray),
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
              color: Colors.white,
              border: Border.all(color: ColorUtils.themeColor, width: 1.5),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(15, 23, 42, 0.08),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "View Collection History",
                style: StyleUtils.kTextStyleSize16Weight600(
                  color: ColorUtils.themeColor,
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
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[ColorUtils.themeColor, Color(0xFF1E8F87)],
              ),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(15, 23, 42, 0.25),
                  blurRadius: 25,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "Record New Collection",
                style: StyleUtils.kTextStyleSize16Weight600(
                  color: Colors.white,
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
    Color iconColor = ColorUtils.themeColor,
  }) => ZoomTapAnimation(
    onTap: onTap,
    child: Container(
      height: 30,
      width: 30,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: <Color>[ColorUtils.themeColor, Color(0xFF1E8F87)],
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(15, 23, 42, 0.15),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Icon(icon, color: iconColor, size: 15),
    ),
  );
}
