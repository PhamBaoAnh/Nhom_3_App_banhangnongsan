import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/authentication/models/user_model.dart';
import 'package:project/features/authentication/screens/login/login.dart';
import 'package:project/repository/auth_repo/AuthenticationRepository.dart';

import '../../../repository/user_repo/user_repo.dart';
import '../../../utils/navigation_menu.dart';

class LoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final userRepo0 = Get.put(userRepo());
  var isLoading = false.obs;
  var isGoogleLoading = false.obs;
  var isFacebookLoading = false.obs;


  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final auth = AuthenticationRepository.instance;
      await auth.loginUserWithEmailAndPassword(email, password);
    } catch (e) {
      Get.snackbar('Error', e.toString()); // Display error message
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      isGoogleLoading.value = true;
      final auth = AuthenticationRepository.instance;
      await auth.signInWithGoogle();
      UserModel userGoogle = UserModel(
          id :'',
          firstName: '',
          lastName: '',
          username: '',
          gender: '',
          email: auth.getUserEmail,
          password: '123456789',
          phoneNo: '',
        dateOfBirth: '',

      );

      var isLoginGoogle  =await userRepo0.getUserDetail(auth.getUserEmail);
      if(isLoginGoogle == null){
        userRepo0.createUser(userGoogle);
      }

      await  auth.setInitScreen(auth.firebaseUser);

    } catch (e) {
      Get.snackbar('Error', e.toString()); // Display error message
    } finally {
      isGoogleLoading.value = false;
    }
  }

  Future<void> loginWithFacebook() async {
    try {
      isFacebookLoading.value = true;
      final auth = AuthenticationRepository.instance;

      // Facebook Sign-In
      await auth.signInWithFacebook();

      // Fetch user details
      final email = auth.getUserEmail;
      if (email == null || email.isEmpty) {
        throw Exception('Facebook login failed. Email not retrieved.');
      }

      // Create UserModel for new users
      UserModel userFacebook = UserModel(
        id: '',
        firstName: '',
        lastName: '',
        username: '',
        gender: '',
        email: email,
        password: '123456789',
        phoneNo: '',
        dateOfBirth: '',
      );

      // Check if user exists, else create a new user
      var isLoginFacebook =  await userRepo0.getUserDetail(auth.getUserEmail);
      if (isLoginFacebook == null) {
        await userRepo0.createUser(userFacebook);
      }

      // Set initialization screen
      await auth.setInitScreen(auth.firebaseUser);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isFacebookLoading.value = false;
    }
  }
}
