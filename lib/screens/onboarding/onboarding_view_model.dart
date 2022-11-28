import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/services/shared_prefrences.dart';

final onBoardingViewModelProvider =
    StateNotifierProvider<OnBoardingViewModel, bool>((ref) {
  final sharePrefsProvider = ref.watch(sharedPreferencesServiceProvider);
  return OnBoardingViewModel(sharePrefsProvider);
});

class OnBoardingViewModel extends StateNotifier<bool> {
  OnBoardingViewModel(this.sharedPrefsService)
      : super(sharedPrefsService.isNew());
  final SharedPrefsService sharedPrefsService;

  Future<void> setOnBoardingComplete() async {
    sharedPrefsService.setOnBoardingPref();
    state = false;
  }

  bool get isNew => state;
}
