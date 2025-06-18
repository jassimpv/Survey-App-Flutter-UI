import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static const String _languageCode = "languageCode";
  static const String _savedLocation = "savedLocation";

  static Future<SharedPreferences> _getPrefs() =>
      SharedPreferences.getInstance();

  // Save language code
  static Future<void> saveLanguage(String locale) async {
    final prefs = await _getPrefs();
    prefs.setString(_languageCode, locale);
  }

  // Get language code
  static Future<String?> getLanguage() async {
    final prefs = await _getPrefs();
    return prefs.getString(_languageCode);
  }

  // Save location
  static Future<void> saveLocation(String location) async {
    final prefs = await _getPrefs();
    prefs.setString(_savedLocation, location);
  }

  // Get location
  static Future<String?> getLocation() async {
    final prefs = await _getPrefs();
    return prefs.getString(_savedLocation);
  }
}
