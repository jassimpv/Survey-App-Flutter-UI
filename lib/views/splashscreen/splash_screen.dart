import "package:collect/controller/splash_controller.dart";
import "package:collect/utils/asset_utils.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/sized_box_extension.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: <Color>[
            ColorUtils.themeColor,
            const Color(0xFF1E8F87),
            ColorUtils.scaffoldColor,
          ],
          stops: const <double>[0, 0.45, 1],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: "register",
            child: SvgPicture.asset(
              AssetUtils.getSvg("logo"),
              colorFilter: const ColorFilter.mode(
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
              child: LoadingAnimationWidget.staggeredDotsWave(
                size: 52,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
