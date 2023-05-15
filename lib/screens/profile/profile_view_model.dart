import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/models/user_model.dart';
import 'package:gadian/services/firebase/firebase_user_profile.dart';

final userProfileViewModelProvider = Provider((ref) {
  var userProfile = ref.read(userProfileProvider);
  return UserProfileViewModel(userProfile: userProfile);
});

typedef UserAsyncValue = AsyncValue<UserModel>;

class UserProfileViewModel extends StateNotifier<UserAsyncValue> {
  UserProfileViewModel({required this.userProfile})
      : super(const UserAsyncValue.loading());
  UserProfile userProfile;

//Get user info
  Future<void> getUserProfile() async {
    try {
      state = const UserAsyncValue.loading();
      var userInfo = await userProfile.getUserInfo();
      state = UserAsyncValue.data(userInfo);
    } catch (e, stackTrace) {
      state = UserAsyncValue.error(e, stackTrace);
    }
  }
}
