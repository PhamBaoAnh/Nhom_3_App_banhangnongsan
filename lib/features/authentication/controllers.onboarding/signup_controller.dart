import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:project/features/authentication/models/user_model.dart';
import 'package:project/features/authentication/screens/signup/verify_email.dart';
import 'package:project/repository/auth_repo/AuthenticationRepository.dart';
import 'package:project/repository/user_repo/user_repo.dart';



class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNo = TextEditingController();
  final dateOfBirth = TextEditingController();
  final agree =false.obs;

  final userRepo0 = Get.put(userRepo());
  Future<void> createUser(UserModel user) async {

    await AuthenticationRepository.instance
        .createUserWithEmailAndPassword(user.email, user.password);
    await userRepo0.createUser(user);
    Get.offAll(()=> VerifyEmailScreen(email: user.email));


  }
}


