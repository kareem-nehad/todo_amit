import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _preferences;

  static Future<SharedPreferences?> init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  static void setMode(String mode) {
    _preferences?.setString('mode', mode);
  }

  static String? getMode() {
    return _preferences?.getString('mode');
  }


  static void setCounter (int number) {
    _preferences?.setInt('counter', number);
  }

  static int? getCounter() {
    return _preferences?.getInt('counter');
  }

  static void clearPreferences () {
    _preferences?.clear();
  }

}