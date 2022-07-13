import 'package:flutter/material.dart';
import 'package:gadian/methods/onboarding_info.dart';

// Apllication theme
ThemeData kThemedata(BuildContext context) => ThemeData(
      primarySwatch: Colors.red,
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Colors.red,
            onPrimary: Colors.red.shade50,
          ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(onSurface: Colors.red),
      ),
    );
//Onboarding info
final List<OnboardingInfo> kOnboardingInfo = [
  OnboardingInfo(
    'Welcome to Gadian',
    'We make sure you can easily alert your friends, family or our community when you are in trouble.',
    'images/welcome.svg',
  ),
  OnboardingInfo(
    'Your gardians',
    'Add your trusted contacts on the platform and customise what kind of alert is sent to who.',
    'images/addfriends.svg',
  ),
  OnboardingInfo(
    'Quick alerts',
    'Instantly send an alert when you are uncomfortable or simply to notify your people on your whereabouts ',
    'images/alert.svg',
  ),
];
