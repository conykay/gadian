import 'package:flutter/material.dart';
import 'package:gadian/models/onboarding_info.dart';
import 'package:google_fonts/google_fonts.dart';

// Application theme
ThemeData kThemeData(BuildContext context) => ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.muktaTextTheme(),
      colorSchemeSeed: const Color(0xfff73319),
      // primarySwatch: Colors.red,
      // colorScheme: Theme.of(context).colorScheme.copyWith(
      //       primary: Colors.red,
      //       secondary: Colors.red,
      //       onPrimary: Colors.red.shade50,
      //     ),
      inputDecorationTheme: const InputDecorationTheme(
        // isDense: true,
        filled: true,
        focusedBorder: OutlineInputBorder(),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          textStyle: const TextStyle(fontSize: 18.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 10,
          ),
        ),
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

// text styles
TextStyle kHeadlineText(BuildContext context) => TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
    );

//email  validation regex.
bool kIsValidEmail(value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  return !(RegExp(pattern).hasMatch(value));
}

//internet info class
class InternetInfo {
  final String message;
  final Color color;

  const InternetInfo(this.message, this.color);
}
