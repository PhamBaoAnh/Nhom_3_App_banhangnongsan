import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/models/banner_model.dart';
import '../../../features/shop/models/category_model.dart';


class BannerRepository extends GetxController {
  static BannerRepository  get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _collectionPath = 'Banners';

  // Static getter to access the instance of the CategoryController

  // Method to fetch all categories from Firestore
  Future<List<BannerModel>> getAllBanners() async {
    try {
      // Fetching data from Firestore
      final snapshot = await _firestore.collection(_collectionPath).get();

      if (snapshot.docs.isEmpty) {
        // Handle case where there are no documents
        Get.snackbar('No Data', 'No categories found');
        return [];
      }

      final list = snapshot.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList();

      return list;

    } catch (e) {
      // Show error message if fetching categories fails
      Get.snackbar('Error', 'Error fetching categories: $e');
      return []; // Return an empty list on error
    }
  }
}
