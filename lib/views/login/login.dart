import "package:collect/controller/login_controller.dart";
import "package:collect/extension/country_list_pick/support/code_country.dart";
import "package:collect/utils/asset_utils.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/sized_box_extension.dart";
import "package:collect/utils/textstyle_input.dart";
import "package:collect/views/widget/gradient_button.dart";
import "package:collect/views/widget/language_widget.dart";
import "package:collect/views/widget/mobile_number_view.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";
import "package:upgrader/upgrader.dart";

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => UpgradeAlert(
    dialogStyle: UpgradeDialogStyle.cupertino,
    showIgnore: false,
    showLater: false,
    child: Scaffold(
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
          onTap: FocusManager.instance.primaryFocus?.unfocus,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Align(
                    alignment: Alignment.topRight,
                    child: LanguageWidegt(isHome: true),
                  ),
                  Expanded(
                    child: Column(
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
                              height: 80,
                              width: 80,
                            ),
                          ),
                        ),
                        32.heightBox,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "welcome_back".tr,
                                style: StyleUtils.kTextStyleSize28Weight700(
                                  color: ColorUtils.headingColor,
                                ),
                              ),
                              8.heightBox,
                              Text(
                                "loginWithYourPhoneNumber".tr,
                                style: StyleUtils.kTextStyleSize16Weight400(
                                  color: ColorUtils.greyTextColor,
                                ),
                              ),
                              28.heightBox,
                              MobileNumberView(
                                controller: controller.mobileNumberController,
                                dialname:
                                    controller
                                        .selectedCountryCode
                                        .value
                                        ?.dialCode ??
                                    "",
                                image:
                                    controller
                                        .selectedCountryCode
                                        .value
                                        ?.flagUri ??
                                    "",
                                onChanged: (CountryCode? countryCode) {
                                  controller.selectedCountryCode.value =
                                      countryCode;
                                },
                              ),
                              32.heightBox,
                              GradientButton(
                                text: "login".tr,
                                onClick: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  controller.login(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
