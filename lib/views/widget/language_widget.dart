import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/transaltion_utils.dart';
import 'package:collect/views/widget/zoom_tap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageWidegt extends StatelessWidget {
  final bool isHome;
  const LanguageWidegt({super.key, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: CustomSwitch(
        value: Get.locale!.languageCode == "en",
        onChanged: (value) async {
          if (value) {
            TranslationService.updateLocale(const Locale('en', 'US'));
          } else {
            TranslationService.updateLocale(const Locale('ar', 'AE'));
          }
        },
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation? circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 60),
    );
    circleAnimation =
        AlignmentTween(
          begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
          end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
        ).animate(
          CurvedAnimation(parent: _animationController!, curve: Curves.linear),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 64,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(
                color: ColorUtils.themeColor.withValues(alpha: 0.10),
              ),
              color: Colors.white.withValues(alpha: 0.10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                children: [
                  Container(
                    alignment: circleAnimation!.value == Alignment.centerRight
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Image.asset(
                      "assets/icons/${Get.locale!.languageCode == "en" ? "ic_lang_en" : "ic_lang_ar"}.png",
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
