import 'package:gadian/models/onboarding_info.dart';

//Onboarding info
final List<OnboardingInfo> kOnboardingInfo = [
  OnboardingInfo(
    'Welcome to Gadian',
    'We make sure you can easily alert your friends, family or our community when you are in trouble.',
    'images/welcome.svg',
  ),
  OnboardingInfo(
    'Your guardians',
    'Add your trusted contacts on the platform and customise what kind of alert is sent to them , You can have multiple alerts specific to friends or family.',
    'images/addfriends.svg',
  ),
  OnboardingInfo(
    'Quick alerts',
    'Instantly send an alert to people you trust when you are uncomfortable or simply to notify your contacts on your whereabouts.',
    'images/alert.svg',
  ),
];

//email  validation regex.
bool kIsValidEmail(value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  return !(RegExp(pattern).hasMatch(value));
}
