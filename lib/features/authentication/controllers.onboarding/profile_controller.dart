import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project/features/authentication/models/user_model.dart';
import 'package:project/repository/auth_repo/AuthenticationRepository.dart';
import 'package:project/repository/user_repo/user_repo.dart';

import '../screens/login/login.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(userRepo());

  Future<UserModel?> getUserData() async {
    final email = _authRepo.firebaseUser?.email;
    if (email != null) {
      UserModel userData = await _userRepo.getUserDetail(email);
      return userData;
    } else {
      Get.snackbar('Error', "Login to continue");
      return null;
    }
  }

  updateUserData(UserModel user) async {
   await  _userRepo.getUpdateUser(user);

  }
  logOut() async {
     await _authRepo.logOut();
     Get.offAll(() => const LoginScreen());
  }

}
