import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:northstar_task/core/utils/validation_functions.dart';
import 'package:northstar_task/presentation/screens/otp/otp_screen.dart';
import 'package:northstar_task/theme/custom_button_style.dart';

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
      if (!isValidEmail(value)) return 'Enter a valid email address';
    }
    return null;
  }

  /// call back function for click event of get opt button
  void getOtpFunction() {
    if (loginFormKey.currentState!.validate()) {
      Navigator.pushNamed(context, OtpScreen.routeName,
          arguments: {'phoneEmail': numberEmailController.text.trim()});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0).copyWith(top: 45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40.0),
              const Text(
                'Enter your mobile number or email address',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              _numberEmailInput(),
              const SizedBox(height: 16.0),
              _getOtpButton(),
              const SizedBox(height: 16.0),
              _buildTermsAndConditionWidget(),
            ],
          ),
        ),
      ),
    );
  }

  /// Input field for number or email
  Widget _numberEmailInput() => TextFormField(
      controller: numberEmailController,
      decoration: const InputDecoration(border: OutlineInputBorder(),),
      validator: (value) => validatorFunction(value));

  /// Get otp button
  Widget _getOtpButton() => SizedBox(
        width: double.maxFinite,
        height: 54,
        child: ElevatedButton(
            style: CustomButtonStyles.fillPrimary,
            onPressed: getOtpFunction,
            child: const Text(
              'Get OTP',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      );

  /// terms and condition widget
  Widget _buildTermsAndConditionWidget() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              const TextSpan(
                text: 'By clicking, I accept the',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: 'Terms And Conditions ',
                style: const TextStyle(color: Colors.grey, fontSize: 16),
                recognizer: TapGestureRecognizer()..onTap = () => {},
              ),
              const TextSpan(
                  text: 'and',
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
              const TextSpan(text: '\n'),
              TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                  recognizer: TapGestureRecognizer()..onTap = () => {})
            ]),
          ),
        ),
      );

  @override
  void dispose() {
    numberEmailController.dispose();
    loginFormKey.currentState?.dispose();
    super.dispose();
  }
}
