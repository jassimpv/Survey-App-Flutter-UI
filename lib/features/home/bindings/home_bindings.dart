import "package:collect/features/home/controller/home_controller.dart";
import "package:collect/features/profile/controller/profile_controller.dart";
import "package:get/get.dart";

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(HomeController.new)
      ..lazyPut(ProfileController.new);
  }
}
