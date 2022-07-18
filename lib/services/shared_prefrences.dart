import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<bool> getIsFirstTime(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isFirstTime = prefs.getBool(key);
    var isNew = isFirstTime == null ? true : false;
    print(isNew);
    return isNew;
  }

  Future<void> setSharedPrefs(String key, bool value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
    print('Pref set..');
  }
}
