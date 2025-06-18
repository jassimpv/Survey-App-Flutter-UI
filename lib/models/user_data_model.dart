class LoginResponse {
  Status? status;
  ResponseData? response;

  LoginResponse({this.status, this.response});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    response = json['response'] != null
        ? ResponseData.fromJson(json['response'])
        : null;
  }
}

class Status {
  int? code;
  String? message;

  Status({this.code, this.message});

  Status.fromJson(Map<String, dynamic> json) {
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
  String? otp;
  String? masterOtp;
  DriverData? driverData;
  bool isActive;

  ResponseData({
    this.message,
    this.otp,
    this.driverData,
    this.masterOtp,
    required this.isActive,
  });

  ResponseData.fromJson(Map<String, dynamic> json)
    : isActive = json['is_active'] == "active" ? true : false {
    message = json['message'];
    otp = json['otp'];
    masterOtp = json['master_otp'];
    driverData = json['driver_data'] != null
        ? DriverData.fromJson(json['driver_data'])
        : null;
  }
}

class DriverData {
  int? driverId;
  String? fullname;
  String? countryCode;
  String? mobile;
  String? gender;
  String? nationality;
  String? licenceNumber;
  String? idNumber;
  String? email;
  String? profileImage;
  int? supplierId;

  DriverData({
    this.driverId,
    this.fullname,
    this.countryCode,
    this.mobile,
    this.gender,
    this.nationality,
    this.licenceNumber,
    this.idNumber,
    this.email,
    this.profileImage,
    this.supplierId,
  });

  DriverData.fromJson(Map<String, dynamic> json) {
    driverId = json['driver_id'];
    fullname = json['fullname'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    gender = json['gender'];
    nationality = json['nationality'];
    licenceNumber = json['licence_number'];
    idNumber = json['id_number'];
    email = json['email'];
    profileImage = json['profile_image'];
    supplierId = json['supplier_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driver_id'] = driverId;
    data['fullname'] = fullname;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['gender'] = gender;
    data['nationality'] = nationality;
    data['licence_number'] = licenceNumber;
    data['id_number'] = idNumber;
    data['email'] = email;
    data['profile_image'] = profileImage;
    data['supplier_id'] = supplierId;
    return data;
  }
}
