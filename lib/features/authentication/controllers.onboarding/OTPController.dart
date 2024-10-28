

import 'dart:ui';

import 'package:get/get.dart';
import 'package:project/features/shop/screens/home/home.dart';

import '../../../repository/auth_repo/AuthenticationRepository.dart';


class OTPController extends GetxController{
  static OTPController get instance => Get.find();
  Future<void> verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified? Get.offAll(const HomeScreen()): Get.back();
  }

}