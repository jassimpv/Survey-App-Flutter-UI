// lib/controllers/login_controller.dart
import 'package:collect/extension/country_list_pick/support/code_country.dart';
import 'package:collect/routes.dart';
import 'package:collect/utils/prefernce_utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileNumberController = TextEditingController();
  Rx<CountryCode?> selectedCountryCode = CountryCode(
    flagUri: "flags/in.png",
    code: "AE",
    dialCode: "+971",
    name: "United Arab Emirates",
  ).obs;
  var isLoading = false.obs;

  void login(BuildContext context) {
    Get.toNamed(AppRouter.phoneVerificationRoute);
  }

  void verifyOTP() {
    PreferenceUtils.saveString(PreferenceUtils.accessToken, "value");
    Get.offNamed(AppRouter.homeRoute);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
