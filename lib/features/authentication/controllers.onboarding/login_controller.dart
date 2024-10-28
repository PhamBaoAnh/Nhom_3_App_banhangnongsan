


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/authentication/models/user_model.dart';
import 'package:project/features/authentication/screens/login/login.dart';


import '../../../repository/user_repo/user_repo.dart';
import '../../../utils/navigation_menu.dart';

class LoginController extends GetxController{
  final email = TextEditingController();
  final password = TextEditingController();
  final userRepo0 = Get.put(userRepo());

  Future<void> login(String email, String password) async {
    UserModel user0 = await userRepo.instance.getUserDetail(email);
    password == user0.password ? Get.offAll(() => const NavigationMenu()) : Get
        .offAll(() => const LoginScreen());
  }




}