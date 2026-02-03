import "package:collect/features/splash/controller/splash_controller.dart";
import "package:collect/core/utils/asset_utils.dart";

import "package:collect/core/theme/theme_colors.dart";
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
      decoration: BoxDecoration(gradient: ThemeColors.appBarGradient),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            AssetUtils.getSvg("logo"),
            colorFilter: const ColorFilter.mode(
              ThemeColors.whiteColor,
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
                color: ThemeColors.whiteColor,
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
