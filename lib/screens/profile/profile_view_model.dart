import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/models/user_model.dart';
import 'package:gadian/services/firebase/firebase_user_profile.dart';

final userProfileViewModelProvider = StreamProvider((ref) async* {
  var userProfile = ref.read(userProfileProvider);
  yield UserProfileViewModel(userProfile: userProfile).getUserProfile();
});

class UserProfileViewModel extends StateNotifier<UserModel> {
  UserProfileViewModel({required this.userProfile})
      : super(UserModel('', '', '', '', [], ''));
  UserProfile userProfile;

//Get user info
  getUserProfile() async {
    state = userProfile.getUserInfo() as UserModel;
  }
}
