import 'dart:developer';
import 'package:get/get.dart';

class ApiHelper {
  static const String sendTagsVerify =
      'https://www.emiratesfoundation.ae/vms-api/API/Inventory/ScanRFID';

  // Replace with your API URL
  static Future<Response> postToAPI(
    String apiUrl,
    Map<String, dynamic> requestBody,
  ) async {
    final url = Uri.parse(apiUrl);
    log("URL: $url");
    log("Request Body: $requestBody");
    Response response = await GetConnect().post(
      url.toString(),
      requestBody,
      headers: {'Content-Type': 'application/json'},
    );
    log("Response Body: ${response.bodyString}");
    return response;
  }
}
