import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../models/order_model.dart';

class CanCelOrderController extends GetxController {
  static CanCelOrderController get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Use Get.lazyPut() for better memory management
  final orderRepository = Get.lazyPut(() => OrderRepository());

  RxString orderStatusText = 'Hello'.obs;
  final isLoading = false.obs;

  Future<void> cancelOrderById(OrderModel orderId) async {
    try {
      isLoading.value = true;

      // You may want to log the action
      print('Cancelling order: ${orderId.id}');

      // Cancel order
      await OrderRepository.instance.cancelOrder(orderId.id);

      // Fetch the updated status
      String status = await OrderRepository.instance.getStatusOrderById(orderId.id);

      // Update the order status
      orderStatusText.value = statusText(status);
    } catch (e) {
      // Improved error handling

    } finally {
      isLoading.value = false;
    }
  }
  Future<String> getStatusById(OrderModel orderId) async {
    try {
      isLoading.value = true;  // Set loading to true before starting the request

      // Fetch the updated status
      String status = await OrderRepository.instance.getStatusOrderById(orderId.id);

      return status;  // Return the status if the request is successful
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching status: $e');  // Print the error for debugging

      return '';  // Return an empty string or some default status if fetching fails
    } finally {
      isLoading.value = false;  // Reset loading state after the operation completes
    }
  }


  // Convert order status string to human-readable text
  String statusText(String status) {
    switch (status) {
      case 'OrderStatus.delivered':
        return 'Đã vận chuyển';
      case 'OrderStatus.shipped':
        return 'Đang vận chuyển';
      case 'OrderStatus.cancelled':
        return 'Đã hủy';
      case 'OrderStatus.processing':
        return 'Đang chờ xác nhận';
      default:
        return 'Trạng thái không xác định'; // Default fallback if status is none of the above
    }
  }
}
