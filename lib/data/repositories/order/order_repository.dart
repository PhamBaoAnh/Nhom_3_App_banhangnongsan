import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../features/authentication/controllers.onboarding/profile_controller.dart';
import '../../../features/shop/models/category_model.dart';
import '../../../features/shop/models/order_model.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../utils/constants/enums.dart';

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
  Future<void> cancelOrder(String orderId) async {
    try {
      final user = await controllerUser.getUserData();
      if (user == null) throw Exception('Người dùng chưa đăng nhập hoặc thông tin không đầy đủ.');
      final userId = user.id;

// Lấy danh sách các đơn hàng
      QuerySnapshot orderSnapshot = await _db
          .collection('user')
          .doc(userId)
          .collection('Orders')
          .get();

      if (orderSnapshot.docs.isNotEmpty) {
        bool isOrderCancelled = false;

        for (var doc in orderSnapshot.docs) {
          String id = doc.id;
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

          if (data != null && data['id'] == orderId) {
            // Nếu `status` phù hợp, cập nhật trạng thái
            DocumentReference orderDocRef = _db
                .collection('user')
                .doc(userId)
                .collection('Orders')
                .doc(id);
            // Uncomment dòng này nếu muốn cập nhật
             await orderDocRef.update({'status': 'OrderStatus.cancelled'});
             Get.snackbar('Thành công', 'Đơn hàng đã được hủy thành công!');

            print('Order with ID $id has been cancelled.');
          }
        }

      } else {
        Get.snackbar('Lỗi', 'Không tìm thấy đơn hàng cho người dùng này!');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Hủy đơn hàng thất bại: $e');
    }
  }

  Future<String> getStatusOrderById(String orderId) async {
    try {
      final user = await controllerUser.getUserData();
      if (user == null) throw Exception('Người dùng chưa đăng nhập hoặc thông tin không đầy đủ.');
      final userId = user.id;

      // Lấy danh sách các đơn hàng
      QuerySnapshot orderSnapshot = await _db
          .collection('user')
          .doc(userId)
          .collection('Orders')
          .get();

      if (orderSnapshot.docs.isNotEmpty) {
        bool isOrderFound = false;

        for (var doc in orderSnapshot.docs) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

          if (data != null && data['id'] == orderId) {
            // Nếu đơn hàng tìm thấy, lấy DocumentReference
            DocumentReference orderDocRef = _db
                .collection('user')
                .doc(userId)
                .collection('Orders')
                .doc(doc.id);

            // Lấy thông tin của đơn hàng để truy cập status
            DocumentSnapshot orderDocSnapshot = await orderDocRef.get();

            if (orderDocSnapshot.exists) {
              String status = orderDocSnapshot['status'];
              return status;  // Trả về trạng thái của đơn hàng
            } else {
              throw Exception('Document not found');
            }
          }
        }

        if (!isOrderFound) {
          throw Exception('Không tìm thấy đơn hàng với ID này!');
        }
      } else {
        throw Exception('Không tìm thấy đơn hàng cho người dùng này!');
      }
    } catch (e) {
      return 'Lỗi khi lấy thông tin đơn hàng: $e'; // Trả về một chuỗi lỗi
    }
  }












}
