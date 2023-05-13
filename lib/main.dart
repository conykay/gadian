import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/components/infoMaterialBanner.dart';
import 'package:gadian/firebase_options.dart';
import 'package:gadian/project_providers.dart';
import 'package:gadian/screens/authentication/registration_screen.dart';
import 'package:gadian/screens/main_screen.dart';
import 'package:gadian/screens/onboarding/onboarding_screen.dart';
import 'package:gadian/screens/onboarding/onboarding_view_model.dart';
import 'package:gadian/services/shared_prefrences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'models/internet_info.dart';

Future<void> main() async {
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.red,
  //   ),
  // );
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
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    final authStateChange = ref.watch(authStateChangesProvider);
    final isNewUser = ref.watch(onBoardingViewModelProvider);
    ref.listen(internetChecker, (previous, next) {
      _showInternetStatusBanner(next.toString());
    });

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.muktaTextTheme(),
          colorSchemeSeed: Colors.red,
          brightness: Brightness.light,
          inputDecorationTheme: const InputDecorationTheme(
            isDense: true,
            filled: true,
            floatingLabelStyle: TextStyle(
              backgroundColor: Colors.white54,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
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
          iconTheme: const IconThemeData(color: Colors.redAccent),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.muktaTextTheme().copyWith(
            displayLarge: GoogleFonts.mukta(color: Colors.white70),
            displayMedium: GoogleFonts.mukta(color: Colors.white70),
            displaySmall: GoogleFonts.mukta(color: Colors.white70),
            headlineLarge: GoogleFonts.mukta(color: Colors.white70),
            headlineMedium: GoogleFonts.mukta(color: Colors.white70),
            headlineSmall: GoogleFonts.mukta(color: Colors.white70),
            titleLarge: GoogleFonts.mukta(color: Colors.white70),
            titleMedium: GoogleFonts.mukta(color: Colors.white70),
            titleSmall: GoogleFonts.mukta(color: Colors.white70),
            bodyLarge: GoogleFonts.mukta(color: Colors.white70),
            bodyMedium: GoogleFonts.mukta(color: Colors.white70),
            labelLarge: GoogleFonts.mukta(color: Colors.white70),
            bodySmall: GoogleFonts.mukta(color: Colors.white70),
            labelSmall: GoogleFonts.mukta(color: Colors.white70),
          ),
          colorSchemeSeed: Colors.red,
          brightness: Brightness.dark,
          inputDecorationTheme: const InputDecorationTheme(
            isDense: true,
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
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
              minimumSize: const Size.fromHeight(60),
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
          iconTheme: const IconThemeData(color: Colors.white70),
        ),
        themeMode: ThemeMode.system,
        scaffoldMessengerKey: scaffoldKey,
        home: authStateChange.when(
            data: (user) => _authentication(context, user, isNewUser),
            error: (_, __) => const Scaffold(
                body: Center(child: Text('Something went wrong'))),
            loading: () => const Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ))));
  }

  void _showInternetStatusBanner(Object? next) {
    const InternetInfo noInternet =
        InternetInfo('No internet please check connection', Colors.red);
    const InternetInfo internet = InternetInfo('Back online.', Colors.green);
    switch (next) {
      case 'AsyncData<InternetConnectionStatus>(value: InternetConnectionStatus.connected)':
        _showBanner(internet);
        break;
      case 'AsyncData<InternetConnectionStatus>(value: InternetConnectionStatus.disconnected)':
        _showBanner(noInternet);
        break;
      default:
        debugPrint('Something more cynical is happening.');
    }
  }

  void _showBanner(InternetInfo status) {
    scaffoldKey.currentState!.showMaterialBanner(
      infoMaterialBanner(
        content: status.message,
        icon: Icons.signal_wifi_statusbar_connected_no_internet_4,
        color: status.color,
        onPressed: () => scaffoldKey.currentState!.hideCurrentMaterialBanner(),
      ),
    );
  }

  Widget _authentication(BuildContext context, User? user, bool isNewUser) {
    if (user != null) {
      return MainScreen();
    }
    if (isNewUser) {
      return const OnboardingScreen();
    }
    return const RegistrationScreen();
  }
}
