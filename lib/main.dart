import "package:collect/routes.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/transaltion_utils.dart";
import "package:collect/utils/theme_service.dart";
import "package:collect/views/widget/no_internet_widget/check_internet_connection_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:get/get.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: "Data Agent App",
    theme: ThemeData(
      fontFamily: "Outfit",
      primaryColor: ColorUtils.themeColor,
      scaffoldBackgroundColor: ColorUtils.appBgMain,
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
        fontFamily: "Outfit",
      ),
    ),
    darkTheme: ThemeData(
      fontFamily: "Outfit",
      brightness: Brightness.dark,
      primaryColor: ColorUtils.themeColor,
      scaffoldBackgroundColor: const Color(0xFF0F1720),
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
        fontFamily: "Outfit",
      ),
    ),
    themeMode: ThemeService.themeMode,
    debugShowCheckedModeBanner: false,
    locale: TranslationService.locale,
    fallbackLocale: TranslationService.fallbackLocale,
    translations: TranslationService(),
    supportedLocales: TranslationService.supportedLocale,
    defaultTransition: Transition.noTransition,
    builder: (BuildContext context, Widget? child) => MediaQuery(
      data: MediaQuery.of(context),
      child: CheckInternetConnection(child: child!),
    ),
    getPages: AppRouter.routes,
    localizationsDelegates: const <LocalizationsDelegate>[
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
  );
}
