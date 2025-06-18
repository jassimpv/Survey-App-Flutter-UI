class NotificationsResponse {
  NotificationStatus? status;
  ResponseData? response;

  NotificationsResponse({this.status, this.response});

  NotificationsResponse.fromJson(Map<String, dynamic> json) {
    status =
    json['status'] != null ? NotificationStatus.fromJson(json['status']) : null;
    response = json['response'] != null
        ? ResponseData.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class NotificationStatus {
  int? code;
  String? message;

  NotificationStatus({this.code, this.message});

  NotificationStatus.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class ResponseData {
  String? message;
  List<Notifications>? notifications;

  ResponseData({this.message, this.notifications});

  ResponseData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (notifications != null) {
      data['notifications'] =
          notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? type;
  String? message;
  BookingInfo? bookingInfo;

  Notifications({this.type, this.message, this.bookingInfo});

  Notifications.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    bookingInfo = json['booking_info'] != null
        ? BookingInfo.fromJson(json['booking_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (bookingInfo != null) {
      data['booking_info'] = bookingInfo!.toJson();
    }
    return data;
  }
}

class BookingInfo {
  String? bookingNumber;
  TrasferType? trasferType;
  TrasferType? vehicleType;

  BookingInfo({this.bookingNumber, this.trasferType, this.vehicleType});

  BookingInfo.fromJson(Map<String, dynamic> json) {
    bookingNumber = json['booking_number'];
    trasferType = json['trasfer_type'] != null
        ? TrasferType.fromJson(json['trasfer_type'])
        : null;
    vehicleType = json['vehicle_type'] != null
        ? TrasferType.fromJson(json['vehicle_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_number'] = bookingNumber;
    if (trasferType != null) {
      data['trasfer_type'] = trasferType!.toJson();
    }
    if (vehicleType != null) {
      data['vehicle_type'] = vehicleType!.toJson();
    }
    return data;
  }
}

class TrasferType {
  String? name;
  String? icon;

  TrasferType({this.name, this.icon});

  TrasferType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['icon'] = icon;
    return data;
  }
}