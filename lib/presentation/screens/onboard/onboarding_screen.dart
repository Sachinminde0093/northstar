import 'package:flutter/material.dart';
import 'package:northstar_task/presentation/screens/home/home_screen.dart';
import 'package:northstar_task/theme/custom_button_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const routeName = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final GlobalKey<FormState> onboardingFormKey;
  late TextEditingController nameController;
  late String phoneEmail;

  @override
  void initState() {
    super.initState();
    onboardingFormKey = GlobalKey<FormState>();
    nameController = TextEditingController();
  }

  /// Name validation function
  String? validatorFunction(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter Your Name";
    }
    return null;
  }

  void submitFunction() async {
    if (onboardingFormKey.currentState!.validate()) {
      /// store email or phone and name in local storage
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('phoneEmail', phoneEmail);
      await prefs.setString('name', nameController.text.trim());
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    phoneEmail = args?['phoneEmail'] ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: const Text('Onboard', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Form(
            key: onboardingFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                const Text(
                  'Enter Your name',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 16.0),
                _buildNameInputField(),
                const SizedBox(height: 16.0),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Input field for OTP
  Widget _buildNameInputField() => TextFormField(
      controller: nameController,
      autofocus: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: 'sachin...'),
      validator: (value) => validatorFunction(value));

  /// Verify otp button
  Widget _buildSubmitButton() => SizedBox(
        width: double.maxFinite,
        height: 54,
        child: ElevatedButton(
            style: CustomButtonStyles.fillPrimary,
            onPressed: () => submitFunction(),
            child: const Text(
              'Submit',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      );
}
