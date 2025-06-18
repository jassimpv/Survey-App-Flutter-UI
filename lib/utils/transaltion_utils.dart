import 'dart:ui';
import 'package:collect/lang/ar_ae.dart';
import 'package:collect/lang/en_us.dart';
import 'package:collect/utils/prefernce_utils.dart';
import 'package:get/get.dart';

class TranslationService extends Translations {
  static const locale = Locale('en', 'US');
  static const fallbackLocale = Locale('en', 'US');
  static final supportedLocale = [
    const Locale('en', 'US'),
    const Locale('ar', 'AE'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUs, 'ar_AE': arAe};

  static Future<void> updateLocale(Locale locale) async {
    Get.updateLocale(locale);
    await PreferenceUtils.saveString(
      PreferenceUtils.languageCode,
      locale.languageCode,
    );
  }

  static Future<void> init() async {
    final languageCode = await PreferenceUtils.getString(
      PreferenceUtils.languageCode,
    );

    if (languageCode != null) {
      if (languageCode == "ar") {
        Get.updateLocale(Locale(languageCode, 'AE'));
      } else {
        Get.updateLocale(Locale(languageCode, 'US'));
      }
    }
  }

  static Locale? getLocale() {
    return Get.locale!;
  }
}
