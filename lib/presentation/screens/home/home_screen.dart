import 'package:flutter/material.dart';
import 'package:northstar_task/presentation/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  String phoneEmail = '';

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      phoneEmail = prefs.getString('phoneEmail') ?? '';
    });
  }

  Future<void> logoutFunction() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('North Start Technologies'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome $name to North Star Technologies'),
            Text(phoneEmail),
            ElevatedButton(
              onPressed: () async => await logoutFunction(),
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}

/// all string written in one file for internationalization
/// middleware for route to home screen if already login
