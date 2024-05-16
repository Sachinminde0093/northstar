import 'package:flutter/material.dart';
import 'package:northstar_task/core/utils/validation_functions.dart';
import 'package:northstar_task/presentation/screens/onboard/onboarding_screen.dart';
import 'package:northstar_task/theme/custom_button_style.dart';

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
      Navigator.pushNamedAndRemoveUntil(
        context,
        OnboardingScreen.routeName,
        arguments: {'phoneEmail': phoneEmail},
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    phoneEmail = args?['phoneEmail'] ?? '';

    return Scaffold(
      /// this line is added only because after logout it do not display a status bar
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Form(
          key: otpFormKey,
          child: Column(
            children: [
              Text(
                'Verify with OTP sent to $phoneEmail',
                style: const TextStyle( fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
              const SizedBox(height: 16.0),
              _buildOtpInput(),
              const SizedBox(height: 16.0),
              _buildGetOtpButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Input field for Otp
  Widget _buildOtpInput() => TextFormField(
      controller: otpController,
      autofocus: true,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration( border: OutlineInputBorder(), hintText: '123456'),
      validator: (value) => validatorFunction(value));

  /// Verify otp button
  Widget _buildGetOtpButton() => SizedBox(
        width: double.maxFinite,
        height: 54,
        child: ElevatedButton(
            style: CustomButtonStyles.fillPrimary,
            onPressed: () => verifyOtpFunction(),
            child: const Text(
              'Verify Otp',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      );

  @override
  void dispose() {
    otpController.dispose();
    otpFormKey.currentState?.dispose();
    super.dispose();
  }
}
