import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../repository/auth_repo/AuthenticationRepository.dart';

class mail_vertification_controller extends GetxController {
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    sendVertificationEmail();
    setTimerForAutoRedirect();
  }

  Future<void> sendVertificationEmail() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
    } catch (e) {

    }
  }

  setTimerForAutoRedirect() {
    _timer=Timer.periodic(const Duration(seconds: 3), (timer){
      FirebaseAuth.instance.currentUser?.reload();
final user =FirebaseAuth.instance.currentUser;
if(user!.emailVerified){
  timer.cancel();
  AuthenticationRepository.instance.setInitScreen(user);
}


    });
  }

  manuallyCheckEmailVerificationStatus() {}
}
