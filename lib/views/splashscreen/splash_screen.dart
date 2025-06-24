import 'package:collect/controller/splash_controller.dart';
import 'package:collect/utils/asset_utils.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
          Hero(
            tag: "register",
            child: SvgPicture.asset(
              AssetUtils.getSvg("logo"),
              colorFilter: ColorFilter.mode(
                ColorUtils.whiteColor,
                BlendMode.srcIn,
              ),
              height: 100,
              width: 100,
            ),
          ),
          100.heightBox,
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
