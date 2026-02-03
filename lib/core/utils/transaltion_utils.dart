import "dart:ui";
import "package:collect/core/localization/ar_ae.dart";
import "package:collect/core/localization/en_us.dart";
import "package:collect/core/utils/prefernce_utils.dart";
import "package:get/get.dart";

class TranslationService extends Translations {
  static const Locale locale = Locale("en", "US");
  static const Locale fallbackLocale = Locale("en", "US");
  static final List<Locale> supportedLocale = <Locale>[
    const Locale("en", "US"),
    const Locale("ar", "AE"),
  ];

  static Locale? _currentLocale;

  @override
  Map<String, Map<String, String>> get keys => <String, Map<String, String>>{
    "en_US": enUs,
    "ar_AE": arAe,
  };

  static Future<void> updateLocale(Locale newLocale) async {
    _currentLocale = newLocale;
    await PreferenceUtils.saveString(
      PreferenceUtils.languageCode,
      newLocale.languageCode,
    );
    Get.updateLocale(newLocale);
  }

  static Future<void> init() async {
    final String? languageCode = await PreferenceUtils.getString(
      PreferenceUtils.languageCode,
    );

    if (languageCode != null) {
      if (languageCode == "ar") {
        _currentLocale = const Locale("ar", "AE");
        Get.updateLocale(_currentLocale!);
      } else {
        _currentLocale = const Locale("en", "US");
        Get.updateLocale(_currentLocale!);
      }
    } else {
      // Save default language on first launch
      _currentLocale = locale;
      await PreferenceUtils.saveString(
        PreferenceUtils.languageCode,
        locale.languageCode,
      );
      Get.updateLocale(locale);
    }
  }

  static Locale? getLocale() => _currentLocale;
}
