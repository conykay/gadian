import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/firebase_options.dart';
import 'package:gadian/project_providers.dart';
import 'package:gadian/screens/profile/profile_screen.dart';
import 'package:gadian/services/shared_prefrences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

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
  final sharedPreferences = SharedPreferences.getInstance();
  runApp(const ProviderScope(overrides: [sharedPreferencesServiceProvider.overrideWithValue(SharedPrefsService(sharedPreferences)),],child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final authStateChange = ref.watch(authStateChangesProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kThemeData(context),
      home: authStateChange.when(
          data: (user) => _authentication(context, user),
          error: (_, __) => const Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          ),
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ))
    );
  }

  Widget _authentication(BuildContext context, User? user) {
    if(user !== null){
      return const ProfileScreen();
    }
    (isNew!
        ? const OnboardingScreen()
        : const RegistrationScreen()))
        : const ProfileScreen(),
  }
}





