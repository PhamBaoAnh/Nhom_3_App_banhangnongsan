import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/controllers/all_product_controller.dart';
import 'package:project/data/repositories/product/product_repository.dart';
import 'package:project/features/shop/models/product_model.dart';

void main() {
  group('Tìm kiếm và lọc sản phẩm', () {
    late FakeFirebaseFirestore fakeFirestore;
    late AllProductController controller;
    late ProductRepository repository;

    setUp(() {

      // Bật chế độ test của GetX để tránh lỗi Snackbar
      Get.testMode = true;

      // Reset GetX trước mỗi test
      Get.reset();

      // Khởi tạo Fake Firestore
      fakeFirestore = FakeFirebaseFirestore();

      // Khởi tạo ProductRepository và sử dụng Fake Firestore
      repository = ProductRepository();
      repository.firestore = fakeFirestore;

      // Đưa repository vào GetX Dependency Injection
      Get.put<ProductRepository>(repository);

      // Khởi tạo AllProductController
      controller = AllProductController();
    });

    tearDown(() {
      // Reset GetX sau mỗi test
      Get.reset();
    });

    test('Tìm sản phẩm thành công', () async {
      // Thêm dữ liệu giả vào Firestore
      await fakeFirestore.collection('Products').add({
        'Title': 'Sầu riêng',
        'Brand': {'Name': 'Việt Nam'},
        'Price': 100.0, // Sử dụng double
        'Stock': 10,
        'SKU': 'SKU001',
        'Thumbnail': 'thumbnail_a.png',
        'ProductType': 'Hoa quả',
      });

      await fakeFirestore.collection('Products').add({
        'Title': 'Cherry',
        'Brand': {'Name': 'Mỹ'},
        'Price': 200.0,
        'Stock': 20,
        'SKU': 'SKU002',
        'Thumbnail': 'thumbnail_b.png',
        'ProductType': 'Hoa quả',
      });

      // Gọi hàm filterProducts với từ khóa 'Product A'
      await controller.filterProducts('Sầu riêng');

      // Kiểm tra kết quả
      expect(controller.products.length, 1);
      expect(controller.products[0].title, 'Sầu riêng');
    });

    test('Lọc sản phẩm theo danh mục', () async {
      // Thêm dữ liệu giả vào Firestore
      await fakeFirestore.collection('Products').add({
        'Title': 'Sầu riêng',
        'Brand': {'Name': 'Việt Nam'},
        'Price': 100.0,
        'Stock': 10,
        'SKU': 'SKU001',
        'Thumbnail': 'thumbnail_a.png',
        'CategoryId': 'fruit', // Danh mục phải khớp
        'ProductType': 'Hoa quả',
      });

      await fakeFirestore.collection('Products').add({
        'Title': 'Cherry',
        'Brand': {'Name': 'Mỹ'},
        'Price': 200.0,
        'Stock': 20,
        'SKU': 'SKU002',
        'Thumbnail': 'thumbnail_b.png',
        'CategoryId': 'fruit', // Danh mục phải khớp
        'ProductType': 'Hoa quả',
      });

      // In dữ liệu hiện tại trong Firestore
      final snapshot = await fakeFirestore.collection('Products').get();
      print('Dữ liệu trong Firestore: ${snapshot.docs.map((e) => e.data())}');

      // Lọc sản phẩm theo danh mục
      final filteredProducts = await controller.repo.getProductsByCategory('fruit');
      controller.products.assignAll(filteredProducts);

      // Kiểm tra kết quả
      print('Số lượng sản phẩm lọc được: ${controller.products.length}');
      expect(controller.products.length, 2); // Chỉ trả về 2 sản phẩm thuộc danh mục 'fruit'
      expect(controller.products[0].categoryId, 'fruit');
      expect(controller.products[1].categoryId, 'fruit');
    });


    test('Lọc sản phẩm theo giá cao nhất (Higher Price)', () async {
      // Thêm dữ liệu giả
      await fakeFirestore.collection('Products').add({
        'Title': 'Sầu riêng',
        'Brand': {'Name': 'Việt Nam'},
        'Price': 300.0,
        'Stock': 10,
        'SKU': 'SKU001',
        'Thumbnail': 'thumbnail_a.png',
        'ProductType': 'Hoa quả',
      });

      await fakeFirestore.collection('Products').add({
        'Title': 'Cherry',
        'Brand': {'Name': 'Mỹ'},
        'Price': 100.0,
        'Stock': 20,
        'SKU': 'SKU002',
        'Thumbnail': 'thumbnail_b.png',
        'ProductType': 'Hoa quả',
      });

      await fakeFirestore.collection('Products').add({
        'Title': 'Táo',
        'Brand': {'Name': 'Mỹ'},
        'Price': 200.0,
        'Stock': 30,
        'SKU': 'SKU003',
        'Thumbnail': 'thumbnail_c.png',
        'ProductType': 'Hoa quả',
      });

      // Truy vấn tất cả sản phẩm
      final allProducts = await fakeFirestore.collection('Products').get();
      final products = allProducts.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

      // Gán sản phẩm và sắp xếp
      controller.assignProducts(products);
      controller.sortProducts('Higher Price');

      // Kiểm tra kết quả
      expect(controller.products[0].title, 'Sầu riêng'); // Giá cao nhất
      expect(controller.products[1].title, 'Táo');
      expect(controller.products[2].title, 'Cherry'); // Giá thấp nhất
    });

  });
}