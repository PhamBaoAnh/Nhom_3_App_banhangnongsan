import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/models/brand_model.dart';
import '../../../features/shop/models/category_model.dart';
import '../../../features/shop/models/product_atrribute.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../features/shop/models/product_variation.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _collectionPath = 'Products';
  Future<int> getTotalProductCountByCategoryAndBrand(
      String categoryId, String brandName) async {
    try {
      final snapshot = await _firestore
          .collection(_collectionPath)
          .where('CategoryId', isEqualTo: categoryId)
          .where('Brand.Name', isEqualTo: brandName)
          .get();
      final totalProductCount = snapshot.docs.fold<int>(
        0,
            (sum, doc) {
          final brandData = doc.data()['Brand']; // Lấy dữ liệu từ trường 'Brand'
          final productCount = (brandData != null && brandData['ProductCount'] != null)
              ? brandData['ProductCount'] as int // Ép kiểu về int nếu không null
              : 0; // Mặc định là 0 nếu dữ liệu không tồn tại
          return sum + productCount; // Cộng dồn giá trị
        },
      );

      return totalProductCount;
    } catch (e) {
      // Xử lý lỗi và hiển thị thông báo
      Get.snackbar('Error', 'Error fetching product count: $e');
      return 0; // Trả về 0 nếu có lỗi
    }
  }


  Future<List<ProductModel>> getProductByName(String name) async {
    try {
      List<ProductModel> products = [];

      // Nếu tên sản phẩm không rỗng, tìm kiếm theo tên sản phẩm
      if (name.isNotEmpty) {
        final snapshot = await _firestore
            .collection(_collectionPath)
            .orderBy('Title')
            .startAt([name])
            .endAt([name + '\uf8ff'])
            .get();

        products.addAll(snapshot.docs
            .map((doc) => ProductModel.fromSnapshot(doc))
            .toList());
      }

      // Nếu không tìm thấy sản phẩm theo tên (danh sách rỗng), tìm kiếm theo nhãn hiệu
      if (products.isEmpty && name.isNotEmpty) {
        final snapshot1 = await _firestore
            .collection(_collectionPath)
            .where('Brand.Name', isGreaterThanOrEqualTo: name)
            .where('Brand.Name', isLessThanOrEqualTo: name + '\uf8ff')
            .get();

        products.addAll(snapshot1.docs
            .map((doc) => ProductModel.fromSnapshot(doc))
            .toList());
      }

      return products;
    } catch (e) {
      print('Error fetching products: $e');
      Get.snackbar('Error', 'Error fetching products: $e');
      return [];
    }
  }

  Future<List<ProductModel>> getRandomProduct() async {
    try {
      final snapshot = await _firestore.collection(_collectionPath).get();

      // Convert Firestore data into a list of ProductModel objects
      List<ProductModel> products = snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

      // Check if there are fewer than 3 products and return all if true
      if (products.length < 3) {
        return products;
      }


      Set<String> seenNames = {};
      List<ProductModel> uniqueProducts = [];

      for (var product in products) {
        if (!seenNames.contains(product.title)) {
          seenNames.add(product.title);
          uniqueProducts.add(product);
        }
      }


      return uniqueProducts.take(3).toList();
    } catch (e) {
      Get.snackbar('Error', 'Error fetching products: $e');
      return [];
    }
  }
  Future<List<BrandModel>> getRandomBrand() async {
    try {
      final snapshot = await _firestore.collection('Brands').get();

      // Convert Firestore documents into a list of BrandModel objects
      List<BrandModel> brands = snapshot.docs.map((doc) {
        return BrandModel.fromJson(doc.data());
      }).toList();

      return brands.take(2).toList(); // Return 3 random brands
    } catch (e) {
      Get.snackbar('Error', 'Error fetching brands: $e');
      return [];
    }
  }





  Future<List<ProductModel>> getProductByCategoryAndBrand(
      String categoryId, String brandName) async {
    try {

      final snapshot = await _firestore
          .collection(_collectionPath)
          .where('CategoryId', isEqualTo: categoryId)
          .where('Brand.Name', isEqualTo: brandName)
          .get();
      return snapshot.docs.map((doc)
        => ProductModel.fromSnapshot(doc)
      ).toList();
    } catch (e) {
      Get.snackbar('Error', 'Error fetching products: $e');
      return [];
    }
  }
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      // Fetching data from Firestore
      final snapshot = await _firestore.collection(_collectionPath).get();
      if (snapshot.docs.isEmpty) {
        // Handle case where there are no documents
        Get.snackbar('No Data', 'No categories found');
        return [];
      }
      final list =
      snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return list;
    } catch (e) {
      // Show error message if fetching categories fails
      Get.snackbar('Error', 'Error fetching categories: $e');
      return []; // Return an empty list on error
    }
  }
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      // Lấy dữ liệu từ Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('CategoryId', isEqualTo: categoryId) // Lọc theo CategoryId
          .get();
      final products = snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } catch (e) {

      Get.snackbar('Error', 'Error fetching products: $e');
      return [];
    }}

  Future<List<ProductModel>> getAllProducts() async { // laay taat ca san pham
    try {
      // Lấy dữ liệu từ Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('IsFeatured', isEqualTo: true) // Lọc theo IsFeatured
          .limit(8)
          .get();

      // Map từng document trong snapshot sang ProductModel
      final list = snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return list;

    } catch (e) {
      // Hiển thị thông báo lỗi
      Get.snackbar('Error', 'Error fetching products: $e');
      return [];
    }
  }



  Future<List<ProductModel>> fetchAllProductsQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final listProduct = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return listProduct;
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.message}');
      Get.snackbar('Error', 'Firebase error: ${e.message}');
      return [];
    } catch (e) {
      print('Unknown error: $e');
      Get.snackbar('Error', 'An unknown error occurred');
      return [];
    }

  }

  Future<List<ProductModel>> getFavoriteProducts(
      List<String> productIds) async {
    try {
      // Fetching data from Firestore
      final snapshot = await _firestore
          .collection(_collectionPath)
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      if (snapshot.docs.isEmpty) {
        // Handle case where there are no documents
        Get.snackbar('No Data', 'No categories found');
        return [];
      }

      final list =
      snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return list;
    } catch (e) {
      // Show error message if fetching categories fails
      Get.snackbar('Error', 'Error fetching categories: $e');
      return []; // Return an empty list on error
    }
  }
  Future<List<ProductModel>> getProductsByBrand(String brandName) async {
    try {
      // Kiểm tra nếu brandName rỗng
      if (brandName.isEmpty) {
        throw ArgumentError("Brand name cannot be empty");
      }

      // Truy vấn Firestore để lấy sản phẩm với thương hiệu tương ứng
      final snapshot = await _firestore
          .collection(_collectionPath)
          .where('Brand.Name', isEqualTo: brandName)
          .get();

      // Kiểm tra nếu không có sản phẩm nào được tìm thấy
      if (snapshot.docs.isEmpty) {
        return [];
      }

      // Chuyển đổi các tài liệu Firestore thành danh sách ProductModel
      final products = snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } catch (e, stacktrace) {

      return []; // Trả về danh sách rỗng trong trường hợp lỗi
    }
  }





}