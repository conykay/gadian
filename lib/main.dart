import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gadian/constants.dart';
import 'package:gadian/screens/registration_screen.dart';
import 'package:gadian/services/shared_prefrences.dart';

import 'screens/onboarding_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.red,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool isNew = true;

  _checkNewUser() async {
    isNew = await SharedPrefs().getIsFirstTime('new');
  }

  @override
  void initState() {
    super.initState();
    _checkNewUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kThemeData(context),
      home: isNew ? const OnboardingScreen() : const RegistrationScreen(),
    );
  }
}
