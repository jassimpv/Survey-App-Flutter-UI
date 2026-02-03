// lib/controllers/login_controller.dart
import "package:collect/core/extensions/country_list_pick/support/code_country.dart";
import "package:collect/routes.dart";
import "package:collect/core/utils/prefernce_utils.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  Rx<CountryCode?> selectedCountryCode = CountryCode(
    flagUri: "flags/in.png",
    code: "AE",
    dialCode: "+971",
    name: "United Arab Emirates",
  ).obs;
  RxBool isLoading = false.obs;

  Future<void> login(BuildContext context) async {
    await Get.toNamed(AppRouter.phoneVerificationRoute);
  }

  Future<void> verifyOTP() async {
    await PreferenceUtils.saveString(PreferenceUtils.accessToken, "value");
    await Get.offNamed(AppRouter.homeRoute);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
