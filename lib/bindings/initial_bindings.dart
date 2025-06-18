import 'package:collect/views/splashscreen/splash_screen.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
