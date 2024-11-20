import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../features/authentication/controllers.onboarding/profile_controller.dart';
import '../../../features/shop/models/category_model.dart';
import '../../../features/shop/models/order_model.dart';
import '../../../features/shop/models/product_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String _collectionPath = 'Orders';
  final ProfileController controllerUser = Get.put(ProfileController());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final user = await controllerUser.getUserData();

      if (user == null || user.email == null) {
        throw Exception('Người dùng chưa đăng nhập hoặc thông tin không đầy đủ.');
      }

      final userId = user.id;

      final result = await _db.collection('user').doc(userId).collection(_collectionPath).get();
      return result.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    } catch (e) {
      // Show error message if fetching categories fails
      Get.snackbar('Error', 'Error fetching categories: $e');
      return []; // Return an empty list on error
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db.collection('user').doc(userId).collection(_collectionPath).add(order.toJson());
    } catch (e) {
      // Show error message if saving order fails
      Get.snackbar('Error', 'Error saving order: $e');
    }
  }

}
