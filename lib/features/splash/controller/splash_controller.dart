import "package:collect/routes.dart";
import "package:collect/core/utils/prefernce_utils.dart";
import "package:get/get.dart";
import "package:flutter/widgets.dart";

class SplashController extends GetxController {
  @override
  Future<void> onReady() async {
    super.onReady();

    //3s delay to show splash screen
    await Future<void>.delayed(const Duration(seconds: 3));

    // Defer navigation to next frame, then defer again to unblock animation
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.microtask(() async {
        String? value = await PreferenceUtils.getString(
          PreferenceUtils.accessToken,
        );
        if (value != null) {
          await Get.offAllNamed(AppRouter.homeRoute);
        } else {
          await Get.offAllNamed(AppRouter.loginRoute);
        }
      });
    });
  }
}
