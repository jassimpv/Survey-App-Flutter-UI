import 'dart:async';
import 'package:collect/controller/login_controller.dart';
import 'package:collect/utils/asset_utils.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/views/login/phone_verification/otp_view.dart';
import 'package:collect/views/widget/gradient_button.dart';
import 'package:collect/views/widget/language_widget.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final LoginController controller = Get.find();

  //timer
  RxInt start = 90.obs;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start.value == 0) {
        timer.cancel();
      } else {
        start.value--;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediaQuery.viewPaddingOf(context).top.heightBox,
                    16.heightBox,
                    Align(
                      alignment: Alignment.topRight,
                      child: LanguageWidegt(isHome: true),
                    ),
                    56.heightBox,
                    Align(
                      alignment: Alignment.center,
                      child: Hero(
                        tag: "register",
                        child: SvgPicture.asset(
                          AssetUtils.getSvg("logo"),
                          colorFilter: ColorFilter.mode(
                            ColorUtils.themeColor,
                            BlendMode.srcIn,
                          ),
                          height: 50,
                          width: 100,
                        ),
                      ),
                    ),
                    71.heightBox,
                    Text(
                      "verifyPhoneNumber".tr,
                      style: StyleUtils.kTextStyleSize28Weight700(
                        lettingSpace: -.4,
                      ),
                    ),
                    24.heightBox,
                    Text(
                      "enterCodeToVerifyPhoneNumber".tr,
                      textAlign: TextAlign.start,
                      style: StyleUtils.kTextStyleSize16Weight400(
                        color: ColorUtils.greyTextColor,
                        letterSpacing: 0,
                      ),
                    ),
                    24.heightBox,
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        "editPhoneNumber".tr,
                        style: StyleUtils.kTextStyleSize18Weight500(
                          color: Colors.black,
                          isUnderline: true,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    24.heightBox,
                    Align(
                      alignment: Alignment.center,
                      child: OTPView(onSubmit: (otp) {}),
                    ),
                    24.heightBox,
                    GradientButton(
                      text: "verifiedOTP".tr,
                      onClick: () {
                        controller.verifyOTP();
                      },
                    ),
                    24.heightBox,
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "didNotReceiveCode".tr,
                            style: StyleUtils.kTextStyleSize14Weight400(
                              color: const Color(0xff6A707C),
                            ),
                          ),
                          if (start.value != 0)
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                " ${"resendInXSec".trParams({'otp': start.value.toString()})}",
                                style: StyleUtils.kTextStyleSize18Weight500(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          else
                            InkWell(
                              onTap: () {
                                start.value = 90;
                                timer = Timer.periodic(
                                  const Duration(seconds: 1),
                                  (timer) {
                                    if (start.value == 0) {
                                      timer.cancel();
                                    } else {
                                      start.value--;
                                    }
                                  },
                                );
                              },
                              child: Text(
                                " ${"resendOTP".tr}",
                                style: StyleUtils.kTextStyleSize18Weight500(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
