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
            type: "confirmed",
            message: "Your appointment has been confirmed.",
          ),
          Notifications(
            type: "pending",
            message: "Your appointment is pending confirmation.",
          ),
          Notifications(
            type: "cancelled",
            message: "Your appointment has been cancelled.",
          ),
        ],
      ),
    );
    super.onInit();
  }
}
