import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static Future init() async => 
      _preferences = await SharedPreferences.getInstance();

  static Future setPreference(String key, String value) async =>
      await _preferences?.setString(key, value);

  static String getPreference(String key, [String defaultValue = '']) =>
      _preferences?.getString(key) ?? defaultValue;
}
