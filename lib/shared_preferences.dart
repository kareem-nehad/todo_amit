import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _preferences;

  static Future<SharedPreferences?> init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  static void setList(List<String> tasks) {
    _preferences?.setStringList('tasks', tasks);
  }

  static List<String>? getList() {
    return _preferences?.getStringList('tasks');
  }

  static void setFinishedTasks(List<String> finishedTasks) {
    _preferences?.setStringList('finishedTasks', finishedTasks);
  }

  static List<String>? getFinishedTasks() {
    return _preferences?.getStringList('finishedTasks');
  }

}