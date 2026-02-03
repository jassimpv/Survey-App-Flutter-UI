import "package:collect/routes.dart";
import "package:collect/core/theme/app_theme_data.dart";
import "package:collect/core/utils/transaltion_utils.dart";
import "package:collect/core/theme/theme_service.dart";
import "package:collect/core/widgets/no_internet_widget/check_internet_connection_widget.dart";
import "package:collect/core/extensions/pull_to_refresh/pull_to_refresh_flutter.dart";
import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:get/get.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeService.init();
  await TranslationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: "dataAgentApp".tr,
    theme: AppThemeData.lightTheme(context),
    darkTheme: AppThemeData.darkTheme(context),
    themeMode: ThemeService.themeMode,
    debugShowCheckedModeBanner: false,
    locale: TranslationService.getLocale() ?? TranslationService.locale,
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
      RefreshLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
  );
}
