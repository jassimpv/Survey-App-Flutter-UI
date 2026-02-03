import "dart:async";

import "package:collect/core/theme/theme_service.dart";
import "package:collect/features/login/controller/login_controller.dart";
import "package:collect/core/utils/asset_utils.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/features/login/views/phone_verification/otp_view.dart";
import "package:collect/core/widgets/gradient_button.dart";
import "package:collect/core/widgets/language_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";
import 'dart:ui';

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
        gradient: ThemeService.isDark()
            ? ThemeColors.scaffoldGradient
            : ThemeColors.appBarGradient,
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: LanguageWidget(isHome: false),
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
                                    ThemeColors.whiteColor,
                                    BlendMode.srcIn,
                                  ),
                                  height: logoSize,
                                  width: logoSize,
                                ),
                              ),
                            ),
                            24.heightBox,
                            ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 30,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ThemeColors.dialogBackground
                                        .withValues(alpha: 0.85),
                                    borderRadius: BorderRadius.circular(32),
                                    border: Border.all(
                                      color: ThemeColors.dialogBorder,
                                      width: 1,
                                    ),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: ThemeColors.primary.withValues(
                                          alpha: 0.18,
                                        ),
                                        blurRadius: 32,
                                        offset: const Offset(0, 12),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "verifyPhoneNumber".tr,
                                        style:
                                            StyleUtils.kTextStyleSize28Weight700(
                                              lettingSpace: -0.4,
                                              color: ThemeColors.onSurface,
                                            ),
                                      ),
                                      12.heightBox,
                                      Text(
                                        "enterCodeToVerifyPhoneNumber".tr,
                                        style:
                                            StyleUtils.kTextStyleSize16Weight400(
                                              color: ThemeColors.onSurface
                                                  .withValues(alpha: 0.7),
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
                                          color: ThemeColors.scaffoldColor
                                              .withValues(alpha: 0.6),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              height: 36,
                                              width: 36,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient:
                                                    ThemeColors.primaryGradient,
                                              ),
                                              child: const Icon(
                                                Icons.lock_open_rounded,
                                                size: 20,
                                                color: ThemeColors.whiteColor,
                                              ),
                                            ),
                                            12.widthBox,
                                            Expanded(
                                              child: Text(
                                                "editPhoneNumber".tr,
                                                style:
                                                    StyleUtils.kTextStyleSize16Weight500(
                                                      color:
                                                          ThemeColors.onSurface,
                                                    ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: Get.back,
                                              child: Container(
                                                padding: const EdgeInsets.all(
                                                  10,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: ThemeColors
                                                      .dialogBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Icon(
                                                  Icons.edit_outlined,
                                                  size: 18,
                                                  color: ThemeColors.themeColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      32.heightBox,
                                      Align(
                                        child: OTPView(
                                          onSubmit: (String otp) {},
                                        ),
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
                                            color: ThemeColors.dialogBackground,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  "didNotReceiveCode".tr,
                                                  style:
                                                      StyleUtils.kTextStyleSize14Weight400(
                                                        color: ThemeColors
                                                            .onSurface
                                                            .withValues(
                                                              alpha: 0.7,
                                                            ),
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
                                                        color: ThemeColors
                                                            .dialogBackground,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              16,
                                                            ),
                                                        border: Border.all(
                                                          color: ThemeColors
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
                                                                    ThemeColors
                                                                        .themeColor,
                                                                  ),
                                                            ),
                                                          ),
                                                          8.widthBox,
                                                          Text(
                                                            "${"resendInXSec".trParams(<String, String>{'otp': start.value.toString()})}",
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: StyleUtils.kTextStyleSize14Weight600(
                                                              color: ThemeColors
                                                                  .onSurface,
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
                                                            if (start.value ==
                                                                0) {
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
                                                          gradient: ThemeColors
                                                              .primaryGradient,
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
                                                              color: ThemeColors
                                                                  .whiteColor,
                                                            ),
                                                            8.widthBox,
                                                            Text(
                                                              "resendOTP".tr,
                                                              style: StyleUtils.kTextStyleSize14Weight600(
                                                                color: ThemeColors
                                                                    .whiteColor,
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
