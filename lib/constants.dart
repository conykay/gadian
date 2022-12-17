import 'package:flutter/material.dart';
import 'package:gadian/models/onboarding_info.dart';
import 'package:google_fonts/google_fonts.dart';

// Application theme
ThemeData kThemeData(BuildContext context) => ThemeData(
    textTheme: GoogleFonts.muktaTextTheme(),
    primarySwatch: Colors.red,
    colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Colors.red,
          onPrimary: Colors.red.shade50,
        ),
    appBarTheme: const AppBarTheme(
      elevation: 0.1,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1),
      labelStyle: const TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade200,
          width: 2.0,
        ),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        onSurface: Colors.red,
        textStyle: const TextStyle(
          fontSize: 18,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.red.shade50,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ));

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
TextStyle kHeadlineText = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  color: Colors.red.shade500,
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
