import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../repository/auth_repo/AuthenticationRepository.dart';
import '../../../repository/user_repo/user_repo.dart';
import '../../authentication/controllers.onboarding/profile_controller.dart';
import '../../authentication/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();


  RxBool isUploading = false.obs;  // Trạng thái upload ảnh
  final _auth = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(userRepo());

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }
  Rx<UserModel> user = UserModel.empty().obs;
  // Lấy dữ liệu người dùng từ Firestore
  Future<void> getUserData() async {
    final email = _auth.firebaseUser?.email;

    if (email != null) {
      UserModel userData = await _userRepo.getUserDetail(email);
      this.user(userData);
    } else {
      print('Email is null');
    }
  }

  final picker = ImagePicker();
  final ProfileController controllerUser = Get.find<ProfileController>();

  // Hàm lưu ảnh vào bộ nhớ trong
  Future<String?> saveImageLocally() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      String customPath = '${directory.path}/assets/icons/categories';
      final customDir = Directory(customPath);

      if (!await customDir.exists()) {
        await customDir.create(recursive: true);
      }

      String fileName = 'category_${DateTime.now().millisecondsSinceEpoch}.jpg';
      String filePath = '${customDir.path}/$fileName';

      await File(pickedFile.path).copy(filePath);
      return filePath;
    }
    return null;
  }

  // Hàm tải ảnh lên Supabase và cập nhật Firestore
  Future<void> uploadPicture() async {
    try {
      isUploading(true);  // Bắt đầu trạng thái upload

      String? imagePath = await saveImageLocally();

      if (imagePath != null) {
        final File imageFile = File(imagePath);
        final fileName = 'user_images/${DateTime.now().millisecondsSinceEpoch}.jpg';

        // Tải ảnh lên Supabase
        final response = await Supabase.instance.client.storage
            .from('category_images')
            .upload(fileName, imageFile);

        // Lấy URL của ảnh vừa tải lên
        String imageUrl = Supabase.instance.client.storage
            .from('category_images')
            .getPublicUrl(fileName);

        // Lấy dữ liệu người dùng
        final userData = await controllerUser.getUserData();
        if (userData == null) {
          print('Không có dữ liệu người dùng!');
          return;
        }

        // Cập nhật ảnh trong Firestore
        CollectionReference usersRef = FirebaseFirestore.instance.collection('user');
        await usersRef.doc(userData.id).update({
          'ProfilePicture': imageUrl,
        });

        // Cập nhật state user và UI
        user.update((val) => val?.profilePicture = imageUrl);
        user.refresh();  // Refresh lại Rx state

        print(user.value.profilePicture);
      } else {
        print('Không có ảnh được chọn.');
      }
    } catch (e) {
      print('Lỗi khi upload ảnh: $e');
    } finally {
      isUploading(false);  // Kết thúc trạng thái upload
    }
  }
}
