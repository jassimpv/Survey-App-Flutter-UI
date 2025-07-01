class TransferCardData {

  TransferCardData({
    required this.bookingId,
    required this.bookingNumber,
    required this.emirate,
    required this.delegationName,
    required this.status,

    required this.lastVistedDate,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.restaurantType,
    this.distance = "0.0 KM",
    this.wasteKg = "0.0 KG",
  });

  factory TransferCardData.fromJson(Map<String, dynamic> json, bId) =>
      TransferCardData(
        distance: json["distance"] ?? "0.0 KM",
        wasteKg: json["waste_kg"] ?? "0.0 KG",
        restaurantName: json["restaurant_name"],
        restaurantAddress: json["restaurant_address"],
        restaurantType: json["restaurant_type"],
        bookingId: json["booking_id"] ?? bId,
        bookingNumber: json["booking_number"],

        emirate: json["emirate"],
        delegationName: json["delegation_name"],
        status: json["status"],

        lastVistedDate: LastVisitedDate.fromJson(json["last_trip_status"]),
      );
  int? bookingId;
  String restaurantName;
  String restaurantAddress;
  String restaurantType;
  String distance;
  String bookingNumber;
  String wasteKg;
  String emirate;
  String delegationName;
  String status;

  LastVisitedDate lastVistedDate;
}

class LastVisitedDate {

  LastVisitedDate({required this.status, required this.createdAt});

  factory LastVisitedDate.fromJson(Map<String, dynamic> json) =>
      LastVisitedDate(
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
      );
  String status;
  DateTime createdAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
    "status": status,
    "createdAt": createdAt.toIso8601String(),
  };
}
