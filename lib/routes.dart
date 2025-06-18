import 'package:collect/bindings/home_bindings.dart';
import 'package:collect/bindings/login_bindings.dart';
import 'package:collect/views/home_screen.dart';
import 'package:collect/views/login/login.dart';
import 'package:collect/views/login/phone_verification/phone_verification_screen.dart';
import 'package:collect/views/notifications/notification_screen.dart';
import 'package:collect/views/profile/contact_us.dart';
import 'package:collect/views/profile/terms_and_conidtion.dart';
import 'package:collect/views/splashscreen/splash_screen.dart';
import 'package:get/get.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: AppRouter.initialRoute,
      page: () => SplashScreen(),
      bindings: [],
    ),
    GetPage(
      name: AppRouter.loginRoute,
      page: () => LoginScreen(),
      bindings: [LoginBindings()],
    ),
    GetPage(
      name: AppRouter.phoneVerificationRoute, // Add this route
      page: () => PhoneVerificationScreen(),
      bindings: [], // Add bindings if needed
    ),
    GetPage(
      name: AppRouter.homeRoute,
      page: () => HomeScreen(), // Replace with your actual HomeScreen widget
      bindings: [HomeBindings()],
    ),
    GetPage(
      name: AppRouter.notificationScreen,
      page: () => NotificationScreen(),
      bindings: [],
    ),
    GetPage(
      name: AppRouter.termsAndConditionScreen,
      page: () => TermsAndConditionScreen(),
      bindings: [],
    ),
    GetPage(
      name: AppRouter.contactUsScreen,
      page: () => ContactUsScreen(),
      bindings: [],
    ),
  ];

  static String initialRoute = "/";
  static String loginRoute = "/login";
  static String homeRoute = "/home";
  static String phoneVerificationRoute = "/phone-verification"; // Add this line
  static String notificationScreen = "/notification-screen";
  static String termsAndConditionScreen = "/terms-and-condition";
  static String contactUsScreen = "/contact-us";
}
