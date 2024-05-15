import 'package:flutter/material.dart';
import 'package:northstar_task/presentation/screens/home/home_screen.dart';
import 'package:northstar_task/presentation/screens/login/login_screen.dart';
import 'package:northstar_task/presentation/screens/onboard/onboarding_screen.dart';
import 'package:northstar_task/presentation/screens/otp/otp_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'North Star',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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

/// use simple routes for navigation
/// string interpolation
///