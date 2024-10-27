import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:project/features/authentication/screens/login/login.dart';
import 'package:project/features/authentication/screens/onboarding/onboarding.dart';
import 'package:project/features/authentication/screens/signup/verify_email.dart';
import 'package:project/features/shop/screens/home/home.dart';
import 'package:project/features/shop/screens/home/widgets/home_appbar.dart';
import '../exception/SignupWithEmailAndPasswordFailure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var vetificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitScreen);
  }

  _setInitScreen(User? user) {
    user == null
        ? Get.offAll(() => const OnBoardingScreen())
        : user.emailVerified
            ? Get.offAll(() => const HomeScreen())
            : Get.offAll(() => const VerifyEmailScreen(email: 'sondoan',));
  }

  Future<void> phoneAuthenticaton(String phoneNo) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential  credentials) async {
          await _auth.signInWithCredential(credentials);
        },

        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }

          // Handle other errors
        },
        codeSent: (verificationId,  resendToken) {
          this.vetificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          vetificationId.value = verificationId;
        });
  }

  Future<bool> verifyOTP(String OTP) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: vetificationId.value, smsCode: OTP));
    return credentials.user != null ? true : false;
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value == null
          ? Get.offAll(() => const OnBoardingScreen())
          : Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure.code(e.code);
      throw ex;
    } catch (_) {}
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
       throw e;
    } catch (_) {}
  }

  Future<bool> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Get.snackbar('Login Successful', 'You are now logged in.');
      return true;
    } on FirebaseAuthException catch (e) {

      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'The email format is invalid.';
          break;
        default:
          errorMessage = 'An unexpected error occurred. Please try again.';

      }
      Get.snackbar('Login Failed', errorMessage, backgroundColor: Colors.red);
      return false;
    } catch (e) {
      // Log any unexpected errors
      print('An unexpected error occurred: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again later.', backgroundColor: Colors.red);
      return false;
    }
  }
  Future<void> logOut() async => await _auth.signOut();
}
