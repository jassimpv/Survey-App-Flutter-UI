import "dart:ui";

import "package:collect/core/models/task_card_model.dart";
import "package:collect/core/models/user_data_model.dart";
import "package:collect/core/utils/colors_utils.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/utils/theme_service.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class HomeController extends GetxController {
  // Example observable variable
  RxInt selectedMenuIndex = 0.obs;
  Rx<DriverData?> userData = DriverData().obs;
  TextEditingController searchController = TextEditingController();
  RxInt selectedTab = 0.obs;
  RxList tabList = <String>[
    "tab_all",
    "tab_pending",
    "tab_need_review",
    "tab_approved",
    "tab_rejected",
  ].obs;
  RxString selectedFilter = "".obs;

  final List<Map<String, String>> filterItems = <Map<String, String>>[
    <String, String>{
      "value": "other",
      "title": "general_transfer",
      "icon": "ic_filter_general_transfer",
    },
    <String, String>{
      "value": "airport_transfer",
      "title": "airport_transfer",
      "icon": "ic_filter_airport_arrival",
    },
    <String, String>{
      "value": "hourly_hires",
      "title": "hourly_hires",
      "icon": "ic_filter_hourly_hire",
    },
    <String, String>{
      "value": "shuttle_service",
      "title": "shuttle_service",
      "icon": "ic_filter_shuttle_service",
    },
  ];

  Rxn<DateTime> startDate = Rxn<DateTime>();
  Rxn<DateTime> endDate = Rxn<DateTime>();

  Future<void> pickDate(BuildContext context, bool isStart) async {
    final DateTime initialDate = isStart
        ? startDate.value ?? DateTime.now()
        : endDate.value ?? (startDate.value ?? DateTime.now());
    final DateTime firstDate = isStart
        ? DateTime(2019)
        : (startDate.value ?? DateTime(2019));
    final DateTime lastDate = DateTime.now();

    final DateTime? picked = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      builder: (BuildContext context) {
        DateTime tempPicked = initialDate;
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              height: 320,
              decoration: BoxDecoration(
                color: ThemeService.isDark()
                    ? const Color(0xFF1A2332).withValues(alpha: 0.9)
                    : Colors.white.withValues(alpha: 0.95),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                border: Border.all(
                  color: ThemeService.isDark()
                      ? Colors.white.withValues(alpha: 0.08)
                      : ColorUtils.themeColor.withValues(alpha: 0.2),
                  width: 1,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 30,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  Container(
                    height: 4,
                    width: 56,
                    decoration: BoxDecoration(
                      color: ThemeService.isDark()
                          ? Colors.white.withValues(alpha: 0.2)
                          : ColorUtils.themeColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          isStart ? "Start date" : "End date",
                          style: StyleUtils.kTextStyleSize18Weight600(
                            color: ThemeService.isDark()
                                ? Colors.white
                                : ColorUtils.headingColor,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            CupertinoButton(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                "Cancel",
                                style: StyleUtils.kTextStyleSize14Weight500(
                                  color: ThemeService.isDark()
                                      ? Colors.white70
                                      : ColorUtils.headingColor.withValues(
                                          alpha: 0.7,
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            CupertinoButton(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              onPressed: () =>
                                  Navigator.of(context).pop(tempPicked),
                              child: Text(
                                "Done",
                                style: StyleUtils.kTextStyleSize14Weight600(
                                  color: ThemeService.isDark()
                                      ? const Color(0xFF0FA394)
                                      : ColorUtils.themeColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 220,
                    width: Get.width,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle:
                              StyleUtils.kTextStyleSize17Weight400(
                                color: ThemeService.isDark()
                                    ? Colors.white
                                    : ColorUtils.headingColor,
                              ),
                          pickerTextStyle: StyleUtils.kTextStyleSize17Weight400(
                            color: ThemeService.isDark()
                                ? Colors.white
                                : ColorUtils.headingColor,
                          ),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        backgroundColor: Colors.transparent,
                        mode: CupertinoDatePickerMode.date,
                        showDayOfWeek: true,
                        initialDateTime: initialDate,
                        minimumDate: firstDate,
                        maximumDate: lastDate,
                        onDateTimeChanged: (DateTime date) {
                          tempPicked = date;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (picked != null) {
      if (isStart) {
        startDate.value = picked;
        if (endDate.value != null && startDate.value!.isAfter(endDate.value!)) {
          endDate.value = null;
        }
      } else {
        endDate.value = picked;
      }
    }
  }

  List<TransferCardData> data = <TransferCardData>[
    TransferCardData(
      restaurantName: "Restaurant A",
      restaurantAddress: "123 Main St, City",
      restaurantType: "Fast Food",
      bookingId: 1001,
      bookingNumber: "BN-0001",
      emirate: "Dubai",
      delegationName: "VIP Delegation",
      status: "Scheduled",
      lastVistedDate: LastVisitedDate(
        status: "Completed",
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
      ),
    ),
    TransferCardData(
      restaurantName: "Restaurant B",
      restaurantAddress: "456 Elm St, City",
      restaurantType: "Fine Dining",
      bookingId: 1002,
      bookingNumber: "BN-0002",
      emirate: "Al Ain",
      delegationName: "Business Group",
      status: "In Progress",
      lastVistedDate: LastVisitedDate(
        status: "Ongoing",
        createdAt: DateTime.now().add(const Duration(days: 15)),
      ),
    ),
    TransferCardData(
      restaurantName: "Restaurant C",
      restaurantAddress: "789 Oak St, City",
      restaurantType: "Casual Dining",
      bookingId: 1003,
      bookingNumber: "BN-0003",
      emirate: "Abu Dhabi",
      delegationName: "Couple",
      status: "Pending",
      lastVistedDate: LastVisitedDate(
        status: "Pending",
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
    ),
    TransferCardData(
      restaurantName: "Restaurant D",
      restaurantAddress: "321 Maple Ave, City",
      restaurantType: "Buffet",
      bookingId: 1004,
      bookingNumber: "BN-0004",
      emirate: "Sharjah",
      delegationName: "Family",
      status: "Completed",
      lastVistedDate: LastVisitedDate(
        status: "Completed",
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ),
    TransferCardData(
      restaurantName: "Restaurant E",
      restaurantAddress: "654 Pine St, City",
      restaurantType: "Cafe",
      bookingId: 1005,
      bookingNumber: "BN-0005",
      emirate: "Ajman",
      delegationName: "Friends",
      status: "Cancelled",
      lastVistedDate: LastVisitedDate(
        status: "Cancelled",
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ),
    TransferCardData(
      restaurantName: "Restaurant F",
      restaurantAddress: "987 Cedar Rd, City",
      restaurantType: "Fine Dining",
      bookingId: 1006,
      bookingNumber: "BN-0006",
      emirate: "Fujairah",
      delegationName: "Tourists",
      status: "Scheduled",
      lastVistedDate: LastVisitedDate(
        status: "Scheduled",
        createdAt: DateTime.now().add(const Duration(days: 5)),
      ),
    ),
    TransferCardData(
      restaurantName: "Restaurant G",
      restaurantAddress: "159 Spruce Blvd, City",
      restaurantType: "Casual Dining",
      bookingId: 1007,
      bookingNumber: "BN-0007",
      emirate: "Ras Al Khaimah",
      delegationName: "Business",
      status: "In Progress",
      lastVistedDate: LastVisitedDate(
        status: "Ongoing",
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ),
    TransferCardData(
      restaurantName: "Restaurant H",
      restaurantAddress: "753 Willow Ln, City",
      restaurantType: "Buffet",
      bookingId: 1008,
      bookingNumber: "BN-0008",
      emirate: "Umm Al Quwain",
      delegationName: "Solo",
      status: "Pending",
      lastVistedDate: LastVisitedDate(
        status: "Pending",
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ),
  ];

  // Example method to increment counter
  void increment() {
    // counter++;
  }

  @override
  void onClose() {
    // Cleanup code here
    super.onClose();
  }
}
