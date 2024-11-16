import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/utils/constants/colors.dart';

import '../../../utils/helpers/helper_functions.dart';

class TLoaders {
  // Hàm ẩn snackbar hiện tại nếu có
  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  // Hàm hiển thị snackbar tùy chỉnh với thông báo
  static customToast({required String message}) {
    // Kiểm tra nếu context đã sẵn sàng
    if (Get.context != null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          elevation: 0,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.transparent,
          content: Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: THelperFunctions.isDarkMode(Get.context!)
                  ? TColors.darkGrey.withOpacity(0.9)
                  : TColors.grey.withOpacity(0.9),
            ),
            child: Center(
              child: Text(
                message,
                style: Theme.of(Get.context!).textTheme.labelLarge,
              ),
            ),
          ),
        ),
      );
    }
  }
}
