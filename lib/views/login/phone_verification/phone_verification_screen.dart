import "dart:async";

import "package:collect/controller/login_controller.dart";
import "package:collect/utils/asset_utils.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/sized_box_extension.dart";
import "package:collect/utils/textstyle_input.dart";
import "package:collect/views/login/phone_verification/otp_view.dart";
import "package:collect/views/widget/gradient_button.dart";
import "package:collect/views/widget/language_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final LoginController controller = Get.find();

  //timer
  RxInt start = 15.obs;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (start.value == 0) {
        timer.cancel();
      } else {
        start.value--;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.transparent,
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
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: <Widget>[
                const Align(
                  alignment: Alignment.topRight,
                  child: LanguageWidegt(isHome: true),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      final double logoSize = (constraints.maxHeight * 0.12)
                          .clamp(48.0, 80.0);

                      return SingleChildScrollView(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              child: Hero(
                                tag: "register",
                                child: SvgPicture.asset(
                                  AssetUtils.getSvg("logo"),
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                  height: logoSize,
                                  width: logoSize,
                                ),
                              ),
                            ),
                            24.heightBox,
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 30,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(32),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 40,
                                    offset: const Offset(0, 12),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "verifyPhoneNumber".tr,
                                    style: StyleUtils.kTextStyleSize28Weight700(
                                      lettingSpace: -0.4,
                                      color: ColorUtils.headingColor,
                                    ),
                                  ),
                                  12.heightBox,
                                  Text(
                                    "enterCodeToVerifyPhoneNumber".tr,
                                    style: StyleUtils.kTextStyleSize16Weight400(
                                      color: ColorUtils.greyTextColor,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                  24.heightBox,
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorUtils.scaffoldColor
                                          .withValues(alpha: 0.6),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 36,
                                          width: 36,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              colors: <Color>[
                                                ColorUtils.themeColor,
                                                const Color(0xFF1E8F87),
                                              ],
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.lock_open_rounded,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        12.widthBox,
                                        Expanded(
                                          child: Text(
                                            "editPhoneNumber".tr,
                                            style:
                                                StyleUtils.kTextStyleSize16Weight500(
                                                  color:
                                                      ColorUtils.headingColor,
                                                ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: Get.back,
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Icon(
                                              Icons.edit_outlined,
                                              size: 18,
                                              color: ColorUtils.themeColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  32.heightBox,
                                  Align(
                                    child: OTPView(onSubmit: (String otp) {}),
                                  ),
                                  32.heightBox,
                                  GradientButton(
                                    text: "verifiedOTP".tr,
                                    onClick: controller.verifyOTP,
                                  ),
                                  24.heightBox,
                                  Obx(() {
                                    final bool waiting = start.value != 0;
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorUtils.scaffoldColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "didNotReceiveCode".tr,
                                              style:
                                                  StyleUtils.kTextStyleSize14Weight400(
                                                    color: ColorUtils
                                                        .greyTextColor,
                                                  ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          // Pill-style action
                                          waiting
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                    border: Border.all(
                                                      color: ColorUtils
                                                          .themeColor
                                                          .withValues(
                                                            alpha: 0.12,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 18,
                                                        height: 18,
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                Color
                                                              >(
                                                                ColorUtils
                                                                    .themeColor,
                                                              ),
                                                        ),
                                                      ),
                                                      8.widthBox,
                                                      Text(
                                                        "${"resendInXSec".trParams(<String, String>{'otp': start.value.toString()})}",
                                                        textAlign:
                                                            TextAlign.right,
                                                        style:
                                                            StyleUtils.kTextStyleSize14Weight600(
                                                              color: ColorUtils
                                                                  .headingColor,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    // restart countdown
                                                    start.value = 15;
                                                    timer?.cancel();
                                                    timer = Timer.periodic(
                                                      const Duration(
                                                        seconds: 1,
                                                      ),
                                                      (Timer t) {
                                                        if (start.value == 0) {
                                                          t.cancel();
                                                        } else {
                                                          start.value--;
                                                        }
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 14,
                                                          vertical: 10,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                            colors: <Color>[
                                                              ColorUtils
                                                                  .themeColor,
                                                              Color(0xFF1E8F87),
                                                            ],
                                                          ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        const Icon(
                                                          Icons.refresh,
                                                          size: 18,
                                                          color: Colors.white,
                                                        ),
                                                        8.widthBox,
                                                        Text(
                                                          "resendOTP".tr,
                                                          style:
                                                              StyleUtils.kTextStyleSize14Weight600(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
