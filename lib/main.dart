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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

