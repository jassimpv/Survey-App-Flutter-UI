import "package:collect/features/splash/controller/splash_controller.dart";
import "package:get/get.dart";

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
