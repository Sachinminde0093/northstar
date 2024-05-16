import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:northstar_task/presentation/screens/home/home_screen.dart';
import 'package:northstar_task/presentation/screens/login/login_screen.dart';
import 'package:northstar_task/presentation/screens/onboard/onboarding_screen.dart';
import 'package:northstar_task/presentation/screens/otp/otp_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        // statusBarColor:Colors.,
        statusBarIconBrightness: Brightness.dark, // Set your desired status bar color
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()?.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  /// Function to restart app after logout
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key,
      title: 'North Star',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        inputDecorationTheme: const InputDecorationTheme(
          errorStyle: TextStyle(fontSize: 16), // Define the error text style here
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Initial route
      routes: {
        '/login': (context) => const LoginScreen(),
        '/otp': (context) => const OtpScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

/// I use simple navigator for routing.
/// We can write all strings in one file, which can help with internationalization.
/// We can use middleware to check if the user is already logged in or not.
/// If the user is already logged in, then we can redirect the user to the home screen.
