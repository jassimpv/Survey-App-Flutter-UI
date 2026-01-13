import "package:collect/routes.dart";
import "package:collect/utils/prefernce_utils.dart";
import "package:collect/utils/transaltion_utils.dart";
import "package:get/get.dart";

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();

    await TranslationService.init();
    await Future<void>.delayed(const Duration(seconds: 2), () async {
      await PreferenceUtils.getString(PreferenceUtils.accessToken).then((
        String? value,
      ) async {
        if (value != null) {
          await Get.offNamed(AppRouter.loginRoute);
        } else {
          await Get.offNamed(AppRouter.loginRoute);
        }
      });
    });
  }
}
