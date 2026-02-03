import "package:collect/core/theme/theme_service.dart";
import "package:collect/features/splash/controller/splash_controller.dart";
import "package:collect/core/utils/asset_utils.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";
import 'dart:ui';

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
        gradient: ThemeService.isDark()
            ? ThemeColors.scaffoldGradient
            : ThemeColors.appBarGradient,
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
        ),
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
