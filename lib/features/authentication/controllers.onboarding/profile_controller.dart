import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/authentication/models/user_model.dart';
import 'package:project/repository/auth_repo/AuthenticationRepository.dart';
import 'package:project/repository/user_repo/user_repo.dart';

import '../screens/login/login.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final phoneNo =TextEditingController();
  final gender =TextEditingController();
  final dateOrBirth =TextEditingController();

  final _auth= Get.put(AuthenticationRepository());
  final _userRepo = Get.put(userRepo());

  Future<UserModel?> getUserData() async {
    final email = _auth.firebaseUser?.email;
    if (email != null) {
      UserModel userData = await _userRepo.getUserDetail(email);
      return userData;
    } else {
      Get.snackbar('Error', "Login to continue");
      return null;
    }
  }

  updateUserData(UserModel user) async {
    await _userRepo.updateUser(user);
  }

  logOut() async {
    await _auth.logOut();
    Get.offAll(() => const LoginScreen());
  }
  deleteUser(UserModel user ) async {
    await _auth.deleteAccount();
    await _userRepo.deleteUser(user);
    Get.offAll(const LoginScreen());
  }



}
