import 'package:get/get.dart';

import '../../../repository/auth_repo/AuthenticationRepository.dart';

class mail_vertification_controller extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    sendVertificationEmail();
  }

  Future<void> sendVertificationEmail() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
    } catch (e) {

    }
  }

  setTimerForAutoRedirect() {}

  manuallyCheckEmailVerificationStatus() {}
}
