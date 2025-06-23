import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static const String languageCode = "languageCode";
  static const String accessToken = "accessToken";

  static Future<SharedPreferences> _getPrefs() =>
      SharedPreferences.getInstance();

  // Common function to save a string
  static Future<void> saveString(String key, String value) async {
    final prefs = await _getPrefs();
    prefs.setString(key, value);
  }

  // Common function to get a string
  static Future<String?> getString(String key) async {
    final prefs = await _getPrefs();
    return prefs.getString(key);
  }

  // Common function to remove a key
  static Future<void> deleteAll() async {
    final prefs = await _getPrefs();
    await prefs.clear();
  }
}
