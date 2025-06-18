import 'package:collect/routes.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/transaltion_utils.dart';
import 'package:collect/views/widget/no_internet_widget/check_internet_connection_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      debugShowCheckedModeBanner: false,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      supportedLocales: TranslationService.supportedLocale,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context),
        child: CheckInternetConnection(child: child!),
      ),
      getPages: AppRouter.routes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
