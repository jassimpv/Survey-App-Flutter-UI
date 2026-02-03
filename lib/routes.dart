import "package:collect/features/home/bindings/home_bindings.dart";
import "package:collect/features/login/bindings/login_bindings.dart";
import "package:collect/core/models/task_card_model.dart";
import "package:collect/features/collection_data/views/add_collection_data.dart";
import "package:collect/features/collection_data/views/collection_data.dart";
import "package:collect/features/home/views/home_screen.dart";
import "package:collect/features/login/views/login.dart";
import "package:collect/features/login/views/phone_verification/phone_verification_screen.dart";
import "package:collect/features/notifications/views/notification_screen.dart";
import "package:collect/features/profile/views/contact_us.dart";
import "package:collect/features/profile/views/terms_and_conidtion.dart";
import "package:collect/features/splash/views/splash_screen.dart";
import "package:get/get.dart";

class AppRouter {
  static List<GetPage> routes = <GetPage>[
    GetPage(name: AppRouter.initialRoute, page: SplashScreen.new),
    GetPage(
      name: AppRouter.loginRoute,
      page: LoginScreen.new,
      bindings: <Bindings>[LoginBindings()],
    ),
    GetPage(
      name: AppRouter.phoneVerificationRoute, // Add this route
      page: PhoneVerificationScreen.new,
    ),
    GetPage(
      name: AppRouter.homeRoute,
      page: HomeScreen.new, // Replace with your actual HomeScreen widget
      bindings: <Bindings>[HomeBindings()],
    ),
    GetPage(name: AppRouter.notificationScreen, page: NotificationScreen.new),
    GetPage(
      name: AppRouter.termsAndConditionScreen,
      page: TermsAndConditionScreen.new,
    ),
    GetPage(name: AppRouter.contactUsScreen, page: ContactUsScreen.new),

    GetPage(
      name: AppRouter.collectionDataScreen,
      page: () {
        final TransferCardData data = Get.arguments as TransferCardData;
        return CollectionData(data: data);
      },
    ),
    GetPage(
      name: AppRouter.addCollectionScreen,
      page: () {
        final TransferCardData data = Get.arguments as TransferCardData;
        return AddCollectionData(data: data);
      },
    ),
  ];

  static String initialRoute = "/";
  static String loginRoute = "/login";
  static String homeRoute = "/home";
  static String phoneVerificationRoute = "/phone-verification"; // Add this line
  static String notificationScreen = "/notification-screen";
  static String termsAndConditionScreen = "/terms-and-condition";
  static String contactUsScreen = "/contact-us";
  static String collectionDataScreen = "/collection-data";
  static String addCollectionScreen = "/add-collection";
}
