import 'dart:async';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:project/features/authentication/screens/login/login.dart';
import 'package:project/features/authentication/screens/onboarding/onboarding.dart';
import 'package:project/features/authentication/screens/signup/verify_email.dart';

import '../../utils/navigation_menu.dart';
import '../exception/SignupWithEmailAndPasswordFailure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> _firebaseUser;

  User? get firebaseUser => _firebaseUser.value;

  String get getUserId => firebaseUser?.uid ?? '';

  String get getUserEmail => firebaseUser?.email ?? '';
  bool isLogin = true;

  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    setInitScreen(_firebaseUser.value);
  }

  setInitScreen(User? user) {
    user == null
        ? Get.offAll(() => const OnBoardingScreen())
        : firebaseUser!.emailVerified
            ? Get.offAll(() => const NavigationMenu())
            : Get.offAll(() => VerifyEmailScreen(email: getUserEmail));
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        Get.offAll(() => const LoginScreen());
        return;
      }

      // Lấy thông tin xác thực từ yêu cầu
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      // Tạo một chứng chỉ mới
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Đăng nhập vào Firebase
      await FirebaseAuth.instance.signInWithCredential(credential);
      setInitScreen(firebaseUser); // Điều hướng sau khi đăng nhập thành công
    } catch (e) {
      Get.snackbar('Error', "Failed to sign in with Google: ${e.toString()}");
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult =
        await FacebookAuth.instance.login(permissions: ['email']);

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure.code(e.code);
      throw ex;
    } catch (_) {}
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail( email: email);

    } on FirebaseException catch (e) {
      Get.snackbar('Error', e.message ?? 'An unknown error occurred');
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (_) {}

    }
  Future<void> deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.delete();
        print("Tài khoản đã được xóa thành công.");
      } else {
        print("Không có người dùng nào được xác thực.");
      }
    } on FirebaseAuthException catch (e) {
      print("Lỗi khi xóa tài khoản: $e");
    }
  }
  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      setInitScreen(firebaseUser);
      Get.snackbar('Login Successful', 'You are now logged in');
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
          errorMessage = 'User or password is incorrect.';
      }
      Get.snackbar('Login Failed', errorMessage, backgroundColor: Colors.red);
    } catch (e) {
      print('An unexpected error occurred: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again later.',
          backgroundColor: Colors.red);
    }
  }

  Future<void> logOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error logout', e.message as String);
    }
  }
}
