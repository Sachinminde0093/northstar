import 'package:flutter/material.dart';
import 'package:northstar_task/presentation/screens/login/login_screen.dart';
import 'package:northstar_task/theme/custom_button_style.dart';
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
    Navigator.pushReplacementNamed(
      context,
      LoginScreen.routeName
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: const Text('North Star Technologies', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0,),
            Text('Welcome $name to North Star Technologies', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,),textAlign: TextAlign.center,),
            const SizedBox(height: 16.0,),
            Text(phoneEmail, style: const TextStyle(fontSize: 16, color: Colors.grey), textAlign: TextAlign.center,),
            const SizedBox(height: 16.0,),
            _buildLogoutButton()
          ],
        ),
      ),
    );
  }

  /// Verify otp button
  Widget _buildLogoutButton() => SizedBox(
    width: double.maxFinite,
    height: 54,
    child: ElevatedButton(
        style: CustomButtonStyles.fillPrimary,
        onPressed: () async => await logoutFunction(),
        child: const Text('Logout', style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold),
        )),
  );
}

/// all string written in one file for internationalization
/// middleware for route to home screen if already login
