import 'package:flutter/material.dart';
import 'package:northstar_task/core/utils/validation_functions.dart';
import 'package:northstar_task/presentation/screens/otp/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> loginFormKey;
  late TextEditingController numberEmailController;
  @override
  void initState() {
    super.initState();
    loginFormKey = GlobalKey<FormState>();
    numberEmailController = TextEditingController();
  }

  /// Number and Email validation function
  String? validatorFunction(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter number or email";
    }
    /// Check if input starts with a number
    if (RegExp(r'^[0-9]').hasMatch(value)) {
       if (!isValidPhone(value)) return 'Enter a valid 10-digit number';
    } else {
     if(!isValidEmail(value)) return 'Enter a valid email address';
    }
    return null;
  }

  /// call back function for click event of get opt button
  void getOtpFunction() {
    if(loginFormKey.currentState!.validate()){
      Navigator.pushNamed(context, OtpScreen.routeName, arguments: {'phoneEmail': numberEmailController.text.trim()});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginFormKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Column(
              children: [
                _numberEmailInput(),
                _getOtpButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Input field for number or email
  Widget _numberEmailInput() => TextFormField(
      controller: numberEmailController,
      validator: (value) => validatorFunction(value)
  );

  /// Get otp button
  Widget _getOtpButton() {
    return ElevatedButton(
        onPressed: getOtpFunction,
        child: const Text('Get Otp')
    );
  }

  @override
  void dispose() {
    numberEmailController.dispose();
    loginFormKey.currentState?.dispose();
    super.dispose();
  }

}
