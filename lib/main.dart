import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gadian/constants.dart';
import 'package:gadian/firebase_options.dart';
import 'package:gadian/models/providers/authentication_provider.dart';
import 'package:gadian/screens/authentication/registration_screen.dart';
import 'package:gadian/screens/home_screen.dart';
import 'package:gadian/services/shared_prefrences.dart';
import 'package:provider/provider.dart';

import 'screens/onboarding_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.red,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
  bool? isNew;

  _checkNewUser() async {
    isNew = await SharedPrefs().getIsFirstTime('new');
  }

  bool _isLoggedIn = false;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkNewUser();
  }

  @override
  Widget build(BuildContext context) {
    firebaseAuth.authStateChanges().listen((User? user) {
      setState(() {
        if (user == null) {
          _isLoggedIn = false;
        } else {
          _isLoggedIn = true;
        }
      });
    });
    return MultiProvider(
      providers: [
        ListenableProvider<Authprovider>(
          create: (_) => Authprovider(firebaseAuth),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: kThemeData(context),
          home: !_isLoggedIn
              ? (isNew == null
                  ? const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : (isNew!
                      ? const OnboardingScreen()
                      : const RegistrationScreen()))
              : const HomeScreen(),
        );
      },
    );
  }
}
