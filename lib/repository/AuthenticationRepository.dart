import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:project/features/authentication/screens/login/login.dart';
import 'package:project/features/authentication/screens/onboarding/onboarding.dart';
import 'exception/SignupWithEmailAndPasswordFailure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitScreen);
  }

  _setInitScreen(User? user) {
    user == null
        ? Get.offAll(() => const OnBoardingScreen())
        : Get.offAll(() => const LoginScreen());
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

      print("FIREBASE AUTH EXCEPTION : " + ex.message);
      throw ex;
    } catch (_) {}
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  Future<void> logOut() async => await _auth.signOut();
}
