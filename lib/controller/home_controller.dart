import "package:collect/models/task_card_model.dart";
import "package:collect/models/user_data_model.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/textstyle_input.dart";
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
      builder: (BuildContext context) {
        DateTime tempPicked = initialDate;
        return Container(
          height: 300,
          color: ColorUtils.scaffoldColor,

          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
                width: Get.width,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle:
                          StyleUtils.kTextStyleSize17Weight400(),
                      actionTextStyle: StyleUtils.kTextStyleSize18Weight400(
                        color: ColorUtils.backgroundDark,
                      ),
                      pickerTextStyle: StyleUtils.kTextStyleSize17Weight400(),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    backgroundColor: ColorUtils.scaffoldColor,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CupertinoButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoButton(
                    child: const Text("Done"),
                    onPressed: () => Navigator.of(context).pop(tempPicked),
                  ),
                ],
              ),
            ],
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
