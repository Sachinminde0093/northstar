import 'package:flutter/material.dart';
import 'package:northstar_task/core/utils/validation_functions.dart';
import 'package:northstar_task/presentation/screens/onboard/onboarding_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key,});
  static const routeName = '/otp';


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final GlobalKey<FormState> otpFormKey;
  late TextEditingController otpController;
  late String phoneEmail;

  @override
  void initState() {
    super.initState();
    otpFormKey = GlobalKey<FormState>();
    otpController = TextEditingController();
  }

  /// OTP validation function
  String? validatorFunction(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter OTP";
    } else if (!isValidOTP(value)) {
      return 'Enter a valid 6-digit OTP';
    }
    return null;
  }

  void verifyOtpFunction() {
    if (otpFormKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(
          context, OnboardingScreen.routeName, arguments: {'phoneEmail': phoneEmail});
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    phoneEmail = args?['phoneEmail'] ?? '';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Form(
            key: otpFormKey,
            child: Column(
              children: [
                Text('Enter OTP sent on $phoneEmail', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),),
                _otpInput(),
                _getOtpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Input field for Otp
  Widget _otpInput() => TextFormField(
      controller: otpController,
      keyboardType: TextInputType.number,
      validator: (value) => validatorFunction(value));

  /// Verify otp button
  Widget _getOtpButton() => ElevatedButton(
      onPressed: () => verifyOtpFunction(), child: const Text('Verify Otp'));
}
