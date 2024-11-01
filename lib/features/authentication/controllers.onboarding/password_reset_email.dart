import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../repository/auth_repo/AuthenticationRepository.dart';

class PasswordResetEmail extends GetxController {
  static  PasswordResetEmail get instance => Get.find();
  late Timer _timer;
  final email = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    setTimerForAutoRedirect();
  }

  Future<void> sendPasswordResetEmail() async {

    String emailReset =email.text;
    print(emailReset);
    try {
      await AuthenticationRepository.instance.sendPasswordResetEmail(emailReset);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  setTimerForAutoRedirect() {
    _timer=Timer.periodic(const Duration(seconds: 2), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        timer.cancel();
        AuthenticationRepository.instance.setInitScreen(user);
      }
    }
    );
  }

  manuallyCheckEmailVerificationStatus() {}









}

