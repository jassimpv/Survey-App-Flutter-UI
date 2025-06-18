class TransferCardData {
  int? bookingId;
  String restaurantName;
  String restaurantAddress;
  String restaurantType;
  String distance;
  String bookingNumber;

  String emirate;
  String delegationName;
  String status;

  List<dynamic> stops;
  LastVisitedDate lastVistedDate;

  TransferCardData({
    required this.bookingId,
    required this.bookingNumber,
    required this.emirate,
    required this.delegationName,
    required this.status,
    required this.stops,
    required this.lastVistedDate,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.restaurantType,
    this.distance = "0.0 km",
  });

  factory TransferCardData.fromJson(Map<String, dynamic> json, dynamic bId) =>
      TransferCardData(
        distance: json["distance"] ?? "0.0 km",
        restaurantName: json["restaurant_name"],
        restaurantAddress: json["restaurant_address"],
        restaurantType: json["restaurant_type"],
        bookingId: json["booking_id"] ?? bId,
        bookingNumber: json["booking_number"],

        emirate: json["emirate"],
        delegationName: json["delegation_name"],
        status: json["status"],
        stops: json["stops"] != null
            ? List<dynamic>.from(json["stops"].map((x) => x))
            : [],
        lastVistedDate: LastVisitedDate.fromJson(json["last_trip_status"]),
      );
}

class LastVisitedDate {
  String status;
  DateTime createdAt;

  LastVisitedDate({required this.status, required this.createdAt});

  factory LastVisitedDate.fromJson(Map<String, dynamic> json) =>
      LastVisitedDate(
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "createdAt": createdAt.toIso8601String(),
  };
}
