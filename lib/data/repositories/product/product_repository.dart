import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../features/shop/models/category_model.dart';
import '../../../features/shop/models/product_model.dart';


class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _collectionPath = 'Products';

  // Static getter to access the instance of the CategoryController

  // Method to fetch all categories from Firestore
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      // Fetching data from Firestore
      final snapshot = await _firestore.collection(_collectionPath).get();

      if (snapshot.docs.isEmpty) {
        // Handle case where there are no documents
        Get.snackbar('No Data', 'No categories found');
        return [];
      }

      final list = snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
       print(list);
      for (var product in list) {
        print('sanpahm: ${product.productAttributes}'); // Replace 'name' with the actual field in CategoryModel
      }


      return list;

    } catch (e) {
      // Show error message if fetching categories fails
      Get.snackbar('Error', 'Error fetching categories: $e');
      return []; // Return an empty list on error
    }
  }
}
