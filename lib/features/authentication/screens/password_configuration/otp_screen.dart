import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:project/features/authentication/controllers.onboarding/OTPController.dart';



 // Import your AuthenticationRepository

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var otpController= Get.put(OTPController());
    var otp;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0), // Example padding, replace with tDefaultSize if defined
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter OTP', // Replace with your actual title variable, e.g., totpTitle
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
              ),
            ),
            Text(
              'Please enter the code sent to your phone.', // Replace with your actual subtitle variable, e.g., totpSubTitle
              style: Theme.of(context).textTheme.headlineMedium, // Changed to headline5 for proper use
            ),
            const SizedBox(height: 40.0),
            const Text(
              "If you didn't receive a code, please check your phone or try again.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            OtpTextField(
              mainAxisAlignment: MainAxisAlignment.center,
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1), // Fixed color typo
              filled: true,
              onSubmit: (code) {
                otp =code;
                OTPController.instance.verifyOTP(otp);
              }),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  OTPController.instance.verifyOTP(otp);
                },
                child: const Text('Next'), // Replace with your actual next button text variable, e.g., tNext
              ),
            ),
          ],
        ),
      ),
    );
  }
}
