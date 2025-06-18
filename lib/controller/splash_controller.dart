import 'package:collect/routes.dart';
import 'package:collect/utils/prefernce_utils.dart';
import 'package:collect/utils/transaltion_utils.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    TranslationService.init();
    PreferenceUtils.getString(PreferenceUtils.accessToken).then((value) {
      Future.delayed(const Duration(seconds: 2), () {
        if (value != null) {
          Get.offNamed(AppRouter.homeRoute);
        } else {
          Get.offNamed(AppRouter.loginRoute);
        }
      });
    });
  }
}
