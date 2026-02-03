import "package:collect/features/splash/controller/splash_controller.dart";
import "package:collect/core/utils/asset_utils.dart";
import "package:collect/core/utils/colors_utils.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: const <Color>[
            Color(0xFF0FA394),
            Color(0xFF0A7A6E),
            Color(0xFF0F1720),
          ],
          stops: const <double>[0, 0.45, 1],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            AssetUtils.getSvg("logo"),
            colorFilter: const ColorFilter.mode(
              ColorUtils.whiteColor,
              BlendMode.srcIn,
            ),
            height: 100,
            width: 100,
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

  @override
  void dispose() {
    // Cancel any pending animations/work when leaving splash
    controller.dispose();
    super.dispose();
  }
}
