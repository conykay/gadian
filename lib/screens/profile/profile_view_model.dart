import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/services/firebase/firebase_user_profile.dart';

final userProfileViewModelProvider = Provider((ref) {
  var userProfile = ref.read(userProfileProvider);
  return UserProfileViewModel(userProfile);
});

class UserProfileViewModel extends StateNotifier<dynamic> {
  UserProfileViewModel(this.userProfile) : super(dynamic);
  UserProfile userProfile;

  Future<dynamic> getUserProfile() => userProfile.getUserInfo();
}
