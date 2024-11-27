import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:project/features/shop/controllers/product/vnpay_controller.dart';

import '../../../../common/widgets/animation/animation_loader.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/navigation_menu.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../authentication/controllers.onboarding/profile_controller.dart';
import '../../../personalization/controllers/address_controller.dart';
import '../../models/order_model.dart';
import 'cart_controller.dart';
import 'checkout_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());
  final ProfileController controllerUser = Get.find<ProfileController>();

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      // Show error message if fetching orders fails
      Get.snackbar('Error', 'Error fetching orders: $e');
      return []; // Return an empty list on error
    }
  }

  Future<void> processOrder(double totalAmount) async {
    try {
      final user = await controllerUser.getUserData();

      if (user == null || user.email == null) {
        throw Exception('Người dùng chưa đăng nhập hoặc thông tin không đầy đủ.');
      }

      final order = OrderModel(
        id: UniqueKey().toString(), // Use timestamp for a unique ID
        userId: user.id,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now().add(const Duration(days: 3)), // Example delivery date
        items: cartController.cartItems.toList(),
      );

      if (checkoutController.selectedPaymentMethod.value.name == 'Thanh toán khi nhận hàng') {
        await orderRepository.saveOrder(order, user.id);

        // Clear the cart after saving the order
        cartController.clearCart();

        // Navigate to the success screen
        Get.off(() => SuccessScreen(
          image: TImages.orderCompletedAnimation,
          title: 'Thanh toán thành công',
          subtitle: 'Đơn hàng của bạn sẽ được vận chuyển sớm',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ));

      } else if (checkoutController.selectedPaymentMethod.value.name== 'VNPay') {

         await _handleVNPayPayment(order, totalAmount, user.id);

      } else {
        throw Exception('Phương thức thanh toán không hợp lệ.');
      }

    } catch (e) {
      Get.snackbar('Error', 'Failed to process order: $e');
    }
  }

  Future<void> _handleVNPayPayment(OrderModel order, double totalAmount, String userId) async {
    // Call the VNPay payment process
    final paymentResult = await onPayment(totalAmount);

    print('hello $paymentResult ');
    // Check the payment result
    if (paymentResult == '00') {
      // Payment successful, proceed to save the order
      // Show a success message and navigate to the success screen
      TLoaders.customToast(message: 'Thanh toán qua VNPay thành công!');
      Get.off(() => SuccessScreen(
        image: TImages.orderCompletedAnimation,
        title: 'Thanh toán thành công',
        subtitle: 'Đơn hàng của bạn sẽ được vận chuyển sớm',
        onPressed: () => Get.offAll(() => const NavigationMenu()),
      ));

      await orderRepository.saveOrder(order, userId);
      cartController.clearCart();

    } else if (paymentResult == '24') {
      TLoaders.customToast(message: 'Hủy Thanh toán thành công');
    } else {
      // Payment failed
      throw Exception('Thanh toán VNPay không thành công.');
    }
  }











}











