import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/models/brand_model.dart';
import '../../../features/shop/models/category_model.dart';
import '../../../features/shop/models/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _collectionPath = 'Products';

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
  Future<List<ProductModel>> fetchAllProductsQuery(Query query) async {
    try {
      final querySnapshot = await query.get();

      final listProduct = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return listProduct;
    } catch (e) {

      Get.snackbar('Error', 'Error fetching categories: $e');
      return []; // Return an empty list on error
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
  Future<List<ProductModel>> getProductsByBrand(Query query,String brandName) async {
    try {
      // Fetching products from Firestore where the 'Brand.Name' field matches the given brand name
      final snapshot = await _firestore
          .collection(_collectionPath)
          .where('Brand.Name', isEqualTo: brandName)
          .get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      // Mapping the documents to ProductModel objects
      final list = snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return list;
    } catch (e) {
      return []; // Return an empty list on error
    }
  }




}
