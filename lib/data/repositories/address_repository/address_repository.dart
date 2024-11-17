import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project/repository/auth_repo/AuthenticationRepository.dart';
import '../../../features/authentication/controllers.onboarding/profile_controller.dart';
import '../../../features/personalization/models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final String _collectionPath = 'Addresses';
  final controller = Get.put(ProfileController());

  final ProfileController controllerUser = Get.put(ProfileController());



  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final user = await controllerUser.getUserData();

      if (user == null || user.email == null) {
        throw Exception('Người dùng chưa đăng nhập hoặc thông tin không đầy đủ.');
      }

      final userId = user.id;
      print('User ID: $userId');

      final result = await _db.collection('user').doc(userId).collection(_collectionPath).get();

      if (result.docs.isEmpty) {
        print('Không tìm thấy địa chỉ nào cho user: $userId');
      }

      return result.docs.map((doc) => AddressModel.fromSnapshot(doc)).toList();
    } catch (e) {
      print('Lỗi khi lấy danh sách địa chỉ: $e');
      Get.snackbar('Error', 'Lỗi khi lấy danh sách địa chỉ: $e');
      return [];
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final user = await controllerUser.getUserData();

      if (user == null || user.email == null) {
        throw Exception('Người dùng chưa đăng nhập hoặc thông tin không đầy đủ.');
      }

      final userId = user.id;

      if (user == null || user.id.isEmpty) {
        throw 'Người dùng chưa đăng nhập hoặc không tìm thấy ID.';
      }


      await _db
          .collection('user')
          .doc(userId)
          .collection(_collectionPath)
          .doc(addressId)
          .update({'selectedAddress': selected});
    } catch (e) {
      print('Lỗi khi cập nhật trường selected: $e');
      Get.snackbar('Error', 'Lỗi khi cập nhật địa chỉ: $e');
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final user = await controllerUser.getUserData();

      if (user == null || user.email == null) {
        throw Exception('Người dùng chưa đăng nhập hoặc thông tin không đầy đủ.');
      }

      final userId = user.id;

      if (user == null || user.id.isEmpty) {
        throw 'Người dùng chưa đăng nhập hoặc không tìm thấy ID.';
      }

      final docRef = await _db
          .collection('user')
          .doc(userId)
          .collection(_collectionPath)
          .add(address.toJson());

      print('Đã thêm địa chỉ mới với ID: ${docRef.id}');
      return docRef.id; // Trả về ID của địa chỉ mới
    } catch (e) {
      print('Lỗi khi thêm địa chỉ mới: $e');
      Get.snackbar('Error', 'Lỗi khi thêm địa chỉ mới: $e');
      throw Exception('Không thể thêm địa chỉ mới.');
    }
  }
}
