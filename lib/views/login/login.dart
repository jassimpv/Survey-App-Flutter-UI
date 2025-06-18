import 'package:collect/controller/login_controller.dart';
import 'package:collect/utils/asset_utils.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/views/widget/language_widget.dart';
import 'package:collect/views/widget/mobile_number_view.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:collect/views/widget/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:upgrader/upgrader.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      dialogStyle: UpgradeDialogStyle.cupertino,
      showIgnore: false,
      showLater: false,
      child: Scaffold(
        backgroundColor: ColorUtils.whiteColor,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
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
                  alignment: Alignment.bottomCenter,
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
                100.heightBox,
                Text(
                  "welcome_back".tr,
                  style: StyleUtils.kTextStyleSize24Weight700(),
                ),
                10.heightBox,
                Text(
                  "loginWithYourPhoneNumber".tr,
                  style: StyleUtils.kTextStyleSize18Weight600(
                    color: Colors.black,
                  ),
                ),
                30.heightBox,
                MobileNumberView(
                  controller: controller.mobileNumberController,
                  dialname:
                      controller.selectedCountryCode.value?.dialCode ?? "",
                  image: controller.selectedCountryCode.value?.flagUri ?? "",
                  onChanged: (countryCode) {
                    controller.selectedCountryCode.value = countryCode;
                  },
                ),
                24.heightBox,

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
        ),
      ),
    );
  }
}
