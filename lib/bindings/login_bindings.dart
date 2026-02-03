import "package:collect/controller/login_controller.dart";
import "package:get/get.dart";

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    // Lazy-load controller to prevent blocking animation during navigation
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
  }
}
