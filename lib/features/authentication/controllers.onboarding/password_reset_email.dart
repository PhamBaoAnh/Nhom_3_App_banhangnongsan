import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project/features/authentication/controllers.onboarding/login_controller.dart';
import 'package:project/features/authentication/models/user_model.dart';
import 'package:project/repository/user_repo/user_repo.dart';

import '../../../repository/auth_repo/AuthenticationRepository.dart';
import '../screens/login/login.dart';

class PasswordResetEmail extends GetxController {
  static  PasswordResetEmail get instance => Get.find();
  final controllerLogin =Get.put(LoginController());
  late Timer _timer;
  final auth =AuthenticationRepository.instance;
  final email = TextEditingController();
  Future<void> resendPasswordResetEmail() async {
    String emailToResend = email.text;
    try {
      await auth.sendPasswordResetEmail(emailToResend);
      Get.snackbar('Success', 'Password reset email resent. Please check your email.');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  Future<void> sendPasswordResetEmail() async {
    String emailReset = email.text.trim();
    try {

      await auth.sendPasswordResetEmail(emailReset);

      setTimerForAutoRedirect();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }


  setTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        UserModel user = await userRepo.instance.getUserDetail(email.text); // Chờ kết quả
        if (user != null) {
           String email =user.email;
           String password =user.password;
          timer.cancel();
          await controllerLogin.login(email, password);
          Get.offAll(() => LoginScreen());
        }
      } catch (e) {
        // Nếu có lỗi trong việc lấy thông tin người dùng, dừng timer
        timer.cancel();
        Get.snackbar('Error', 'Could not find user: ${e.toString()}');
      }
    });
  }

  manuallyCheckEmailVerificationStatus() {}









}

