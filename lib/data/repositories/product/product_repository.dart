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

  List<ProductModel> createSampleProducts() {
    return List.generate(10, (index) {
      return ProductModel(
        id: 'product_$index',
        title: 'Product $index',
        stock: 100 - index,
        price: 10.0 + index,
        salePrice: 8.0 + index,
        thumbnail: 'https://via.placeholder.com/150',
        productType: 'Type $index',
        isFeatured: index % 2 == 0,
        description: 'Description for product $index',
        categoryId: 'category_$index',
        images: [
          'https://via.placeholder.com/150',
          'https://via.placeholder.com/200'
        ],
        brand: BrandModel(
          id: 'brand_$index',
          name: 'Brand $index',
          image: 'https://via.placeholder.com/100',
        ),
        productAttributes: [
          ProductAttributeModel(name: 'Color', values: ['Red', 'Blue']),
          ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L'])
        ],
        productVariations: [
          ProductVariationModel(
            id: 'variation_${index}_1',
            sku: 'SKU_${index}_1',
            image: 'https://via.placeholder.com/50',
            price: 12.0 + index,
            salePrice: 10.0 + index,
            stock: 50,
            attributeValues: {'Color': 'Red', 'Size': 'M'},
          )
        ],
      );
    });
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
