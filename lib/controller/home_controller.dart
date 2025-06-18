import 'package:collect/models/task_card_model.dart';
import 'package:collect/models/user_data_model.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Example observable variable
  RxInt selectedMenuIndex = 0.obs;
  Rx<DriverData?> userData = DriverData().obs;
  TextEditingController searchController = TextEditingController();
  RxInt selectedTab = 0.obs;
  RxList tabList = [
    "tab_all",
    "tab_pending",
    "tab_need_review",
    "tab_approved",
    "tab_rejected",
  ].obs;
  RxString selectedFilter = "".obs;

  final List<Map<String, String>> filterItems = [
    {
      "value": "other",
      "title": "general_transfer",
      "icon": "ic_filter_general_transfer",
    },
    {
      "value": "airport_transfer",
      "title": "airport_transfer",
      "icon": "ic_filter_airport_arrival",
    },
    {
      "value": "hourly_hires",
      "title": "hourly_hires",
      "icon": "ic_filter_hourly_hire",
    },
    {
      "value": "shuttle_service",
      "title": "shuttle_service",
      "icon": "ic_filter_shuttle_service",
    },
  ];

  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  Future<void> pickDate(BuildContext context, bool isStart) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? startDate.value ?? DateTime.now()
          : endDate.value ?? DateTime.now(),
      firstDate: startDate.value ?? DateTime(2019),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorUtils.themeColor,
              onPrimary: Colors.white,
              surface: ColorUtils.whiteColor,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (isStart) {
        startDate.value = picked;
        if (endDate.value == null) {
          endDate.value = DateTime.now();
        }
        if (endDate.value != null && startDate.value!.isAfter(endDate.value!)) {
          endDate.value = null;
        }
      } else {
        endDate.value = picked;
      }
    }
  }

  List<TransferCardData> data = [
    TransferCardData(
      restaurantName: "Restaurant A",
      restaurantAddress: "123 Main St, City",
      restaurantType: "Fast Food",
      bookingId: 1001,
      bookingNumber: "BN-0001",

      emirate: "Dubai",
      delegationName: "VIP Delegation",
      status: "Scheduled",
      stops: ["Stop 1", "Stop 2", "Stop 3"],
      lastVistedDate: LastVisitedDate(
        status: "Completed",
        createdAt: DateTime.now().subtract(Duration(days: 6)),
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
      stops: ["Airport", "Hotel"],
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
      stops: [],
      lastVistedDate: LastVisitedDate(
        status: "Pending",
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
    ),
  ];

  // Example method to increment counter
  void increment() {
    // counter++;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialization code here
  }

  @override
  void onClose() {
    // Cleanup code here
    super.onClose();
  }
}
