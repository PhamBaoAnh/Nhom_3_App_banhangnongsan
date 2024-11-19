import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/models/brand_model.dart';

class BrandRepository extends GetxController {
    static BrandRepository get instance => Get.find();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String _collectionPath = 'Brands';
        Future<List<BrandModel>> getFeaturedBrands() async {
            try {
                // Fetching data from Firestore
                final snapshot = await _firestore.collection(_collectionPath).get();
                if (snapshot.docs.isEmpty) {
                    // Handle case where there are no documents

                    return [];
                }
                final list = snapshot.docs.map((doc) => BrandModel.fromJson(doc.data()!)).toList();

                return list;
            } catch (e) {
                // Show error message if fetching categories fails

                return []; // Return an empty list on error
            }
        }
    Future<BrandModel?> getBrandsByName(String name) async {
        try {
            final snapshot = await _firestore
                .collection('Brands')
                .where('Name', isEqualTo: name)
                .get();

            if (snapshot.docs.isNotEmpty) {
                final document = snapshot.docs.first;
                return BrandModel.fromJson(document.data());
            } else {
                return null;
            }
        } catch (e) {
            throw Exception('Error fetching brand by name: $e');
        }
    }




}