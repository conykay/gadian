import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/firebase_options.dart';
import 'package:gadian/project_providers.dart';
import 'package:gadian/screens/authentication/registration_screen.dart';
import 'package:gadian/screens/onboarding/onboarding_screen.dart';
import 'package:gadian/screens/onboarding/onboarding_view_model.dart';
import 'package:gadian/screens/profile/profile_screen.dart';
import 'package:gadian/services/shared_prefrences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.red,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(overrides: [
      sharedPreferencesServiceProvider
          .overrideWithValue(SharedPrefsService(sharedPreferences)),
    ], child: const MyApp()),
  );
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
    final isNewUser = ref.watch(onBoardingViewModelProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: kThemeData(context),
        home: authStateChange.when(
            data: (user) => _authentication(context, user, isNewUser),
            error: (_, __) => const Scaffold(
                  body: Center(
                    child: Text('Something went wrong'),
                  ),
                ),
            loading: () => const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )));
  }

  Widget _authentication(BuildContext context, User? user, bool isNewUser) {
    if (user != null) {
      return const ProfileScreen();
    }
    if (isNewUser) {
      return const OnboardingScreen();
    }
    return const RegistrationScreen();
  }
}
