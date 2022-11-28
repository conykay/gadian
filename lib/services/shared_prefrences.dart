import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesServiceProvider =
    Provider<SharedPrefsService>((ref) => throw UnimplementedError());

class SharedPrefsService {
  SharedPrefsService(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  Future<void> setSharedPrefs(String key, bool value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
    print('Pref set..');
  }

  static const String _ONBOARDING_KEY = 'onBoardingComplete';

  Future<void> setOnBoardingPref() async {
    await setSharedPrefs(_ONBOARDING_KEY, false);
  }

  bool isNew() => sharedPreferences.getBool(_ONBOARDING_KEY) ?? true;
}
