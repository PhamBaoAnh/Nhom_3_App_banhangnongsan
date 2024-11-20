import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/enums.dart';
import 'package:project/utils/constants/sizes.dart';

import '../../../../common/widgets/products/checkout/payment_title.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../models/payment_method_model.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit(){
    selectedPaymentMethod.value = PaymentMethodModel(image: TImages.vnpay, name: 'VNPay');
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TSectionHeading(title: 'Phương thức thanh toán',showActionButton: false, textColor: TColors.black,),
                const SizedBox(height: TSizes.spaceBtwSections,),
                TPaymentTitle(paymentMethod: PaymentMethodModel(image:TImages.vnpay, name: 'VNPay'),),
                const SizedBox(height: TSizes.spaceBtwItems/2,),
                TPaymentTitle(paymentMethod: PaymentMethodModel(image:TImages.cod, name: 'Thanh toán khi nhận hàng'),),


              ],
            ),
          ),
        )

    );
  }


}