import "package:collect/features/login/controller/login_controller.dart";
import "package:collect/core/extensions/country_list_pick/support/code_country.dart";
import "package:collect/core/utils/asset_utils.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/widgets/gradient_button.dart";
import "package:collect/core/widgets/language_widget.dart";
import "package:collect/core/widgets/mobile_number_view.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: BoxDecoration(gradient: ThemeColors.appBarGradient),
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
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      final double logoSize = (constraints.maxHeight * 0.12)
                          .clamp(48.0, 80.0);
                      final double cardMaxHeight = (constraints.maxHeight * 0.6)
                          .clamp(280.0, 600.0);

                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Column(
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
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: cardMaxHeight,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 30,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ThemeColors.whiteColor,
                                    borderRadius: BorderRadius.circular(32),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: ThemeColors.blackColor
                                            .withValues(alpha: 0.08),
                                        blurRadius: 40,
                                        offset: const Offset(0, 12),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "welcome_back".tr,
                                        style:
                                            StyleUtils.kTextStyleSize28Weight700(
                                              color: ThemeColors.headingColor,
                                            ),
                                      ),
                                      8.heightBox,
                                      Text(
                                        "loginWithYourPhoneNumber".tr,
                                        style:
                                            StyleUtils.kTextStyleSize16Weight400(
                                              color: ThemeColors.greyTextColor,
                                            ),
                                      ),
                                      28.heightBox,
                                      MobileNumberView(
                                        controller:
                                            controller.mobileNumberController,
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
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          controller.login(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
