import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/repositories/categories/category_repository.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  final _categoryRepository = Get.put(CategoryRepository());
  final isLoading = false.obs;

  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  final picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      Get.snackbar('Error', 'Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> saveImageLocally() async {
    // Chọn ảnh từ bộ sưu tập
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Đường dẫn đến thư mục lưu trữ nội bộ của ứng dụng
      final directory = await getApplicationDocumentsDirectory();

      // Tạo cấu trúc thư mục tương tự 'assets/icons/categories'
      String customPath = '${directory.path}/assets/icons/categories';
      final customDir = Directory(customPath);

      // Tạo thư mục nếu chưa tồn tại
      if (!await customDir.exists()) {
        await customDir.create(recursive: true);
      }

      // Đặt tên tệp ảnh
      String fileName = 'category_${DateTime.now().millisecondsSinceEpoch}.jpg';
      String filePath = '${customDir.path}/$fileName';

      // Sao chép ảnh vào đường dẫn mong muốn
      await File(pickedFile.path).copy(filePath);
      return filePath;  // Trả về đường dẫn ảnh đã lưu
    }
    return null;  // Trả về null nếu không có ảnh được chọn
  }

  Future<void> uploadPicture() async {
    try {
      // Lấy đường dẫn ảnh từ bộ nhớ
      String? imagePath = await saveImageLocally();

      if (imagePath != null) {
        // Tải ảnh lên Supabase Storage
        final File imageFile = File(imagePath);

        // Tạo tên file duy nhất cho ảnh
        final fileName = 'category_images/${DateTime.now().millisecondsSinceEpoch}.jpg';

        // Upload ảnh lên Supabase Storage
        final response = await Supabase.instance.client.storage
            .from('category_images')
            .upload(fileName, imageFile);

        // Lấy URL công khai của ảnh vừa tải lên
        String imageUrl = Supabase.instance.client.storage
            .from('category_images')
            .getPublicUrl(fileName);

        // Tạo một đối tượng CategoryModel với thông tin ảnh đã chọn
        CategoryModel newCategory = CategoryModel(
          id: '5',  // ID có thể tự động tạo nếu cần
          name: 'Category 5',
          image: imageUrl,  // Sử dụng URL ảnh từ Supabase
          parentId: '1',
          isFeatured: true,
        );

        // Lưu dữ liệu vào Firestore hoặc Supabase (nếu cần)
        // Giả sử bạn đang sử dụng Firestore, bạn có thể lưu thông tin này vào Firestore:
        CollectionReference categoriesRef = FirebaseFirestore.instance.collection('Categories');
        await categoriesRef.doc(newCategory.id).set(newCategory.toJson());

        print('Ảnh đã được lưu vào Firestore!');
      } else {
        print('Không có ảnh được chọn.');
      }
    } catch (e) {
      print('Lỗi khi upload ảnh: $e');
    }
  }
}
