import 'package:collect/models/notification_response.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  Rx<NotificationsResponse> notificationsResponse = NotificationsResponse().obs;

  @override
  void onInit() {
    notificationsResponse.value = NotificationsResponse(
      response: ResponseData(
        notifications: [
          Notifications(
            type: "approved",
            message: "Your submission has been rejected.",
          ),
          Notifications(
            type: "rejected",
            message: "Your submission has been rejected.",
          ),
          Notifications(
            type: "approved",
            message: "Your submission has been approved.",
          ),
        ],
      ),
    );
    super.onInit();
  }
}
