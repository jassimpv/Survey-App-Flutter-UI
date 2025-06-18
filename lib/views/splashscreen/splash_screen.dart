import 'package:collect/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed('/login');
    });
  }
}

class SplashScreen extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.themeColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Center(
          //   child: Image.asset(
          //     "assets/icons/logo.png",
          //     color: ColorUtils.whiteColor,
          //     height: 300,
          //     width: 300,
          //   ),
          // ),
          Center(
            child: RepaintBoundary(
              child: CircularProgressIndicator(color: ColorUtils.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
