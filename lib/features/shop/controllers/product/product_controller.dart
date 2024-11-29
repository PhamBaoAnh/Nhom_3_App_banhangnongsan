import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/banners/banner_repository.dart';
import '../../../../data/repositories/brands/BrandRepository.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/enums.dart';

import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  final count= 0.obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }
  Future<int> getProductsByCategoryAndBrand(
      String categoryId, String brandName) async {
    try {
      final count =await  productRepository.getTotalProductCountByCategoryAndBrand(categoryId, brandName);
      return count;
    } catch (e) {
      Get.snackbar('Error', 'Error fetching products: $e');
      return 0;
    }
  }
  Future<List<ProductModel>> getProductByCategoryAndBrand(
      String categoryId, String brandName) async {
    try {
      final list =await  productRepository.getProductByCategoryAndBrand(categoryId, brandName);
      return list;
    } catch (e) {
      Get.snackbar('Error', 'Error fetching products: $e');
      return [];
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      final snapshot = await _firestore
          .collection('Products')
          .where(
          'CategoryId', isEqualTo: categoryId) // Query products by CategoryId
          .get();

      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

    } catch (e) {
      return [];
    }
  }
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();

      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];  // Trả về danh sách rỗng nếu có lỗi
    }
  }


  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final products = await productRepository.getFeaturedProducts();
      featuredProducts.assignAll(products);
      if (products != null && products.isNotEmpty) {
        for (var product in products) {
          print('danh sách thuộc tính: ${product.productAttributes ?? 'Không có thuộc tính'}');
        }
      } else {
        print('Danh sách sản phẩm trống hoặc null');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0;

    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toStringAsFixed(0);
    } else {
      for (var variation in product.productVariations!) {
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      if (smallestPrice == largestPrice) {
        return largestPrice.toStringAsFixed(0);
      } else {
        return '${smallestPrice.toStringAsFixed(0)}.000 - ${largestPrice.toStringAsFixed(0)}';
      }
    }
  }
  String getProductLowesPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0;

    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toStringAsFixed(0);
    } else {
      for (var variation in product.productVariations!) {
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      if (smallestPrice == largestPrice) {
        return largestPrice.toStringAsFixed(0);
      } else {
        return smallestPrice.toStringAsFixed(0) ;
      }
    }
  }


  String? calculatorSalePercentage(double originalPrice, double? salePrice){
    if(salePrice == null || salePrice <= 0.0) return null;

    if(originalPrice <= 0) return null;

    double percentage = ((originalPrice -salePrice) / originalPrice)*100;
    return percentage.toStringAsFixed(0);
  }

  String getProductStockSatus(int stock){
    return stock > 0 ? 'Còn hàng' : 'Hết hàng';
  }





}