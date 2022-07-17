import 'package:flutter/material.dart';
import 'package:gadian/methods/onboarding_info.dart';
import 'package:google_fonts/google_fonts.dart';

// Apllication theme
ThemeData kThemeData(BuildContext context) => ThemeData(
    textTheme: GoogleFonts.muktaTextTheme(),
    primarySwatch: Colors.red,
    colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Colors.red,
          onPrimary: Colors.red.shade50,
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
    'Your gardians',
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

// Registration Page Title Widget
Container kBuildPageTitle(
    BuildContext context, String title, String info, IconData icon) {
  return Container(
    decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.05)),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              icon,
              size: 50,
              color: Colors.redAccent,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              info,
              style: Theme.of(context).textTheme.subtitle1,
            )
          ],
        ),
      ],
    ),
  );
}
