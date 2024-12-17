import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/brand_model.dart';
import '../models/product_atrribute.dart';
import '../models/product_model.dart';
import '../models/product_variation.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class HomeController extends GetxController {

  Future<void> seedProducts() async {
    try {
      for (int i = 1; i <= 60; i++) {

        final product = ProductModel(
          id: '$i',
          title: 'Product_$i',
          stock: 10,
          price: 190000,
          thumbnail: 'https://ckbvijuaedwjhymeqfhx.supabase.co/storage/v1/object/public/category_images/product_images/Cherry/bwYN5SkDx4fbMErKp2E4wTCTBuyc8H1Pia57Fho1.png',
          productType: '',  // Add a default or meaningful value
          salePrice: 160000,
          categoryId: '1',
          description: 'Ứng dụng cung cấp nông sản nhập khẩu, nền tảng mua sắm chất lượng, rõ nguồn gốc.',
          isFeatured: true,
          images: [
            'https://ckbvijuaedwjhymeqfhx.supabase.co/storage/v1/object/public/category_images/product_images/Cherry/bwYN5SkDx4fbMErKp2E4wTCTBuyc8H1Pia57Fho1.png',
            'https://ckbvijuaedwjhymeqfhx.supabase.co/storage/v1/object/public/category_images/product_images/Cherry/OzDGJs9GfTJz1wqJp79YQDbflsMZAlThN5k1iKTY.png',
          ],
          productAttributes: [
            ProductAttributeModel(name: 'Khối lượng', values: ['1 Kg', '2 Kg']),
          ],
          // Always add product variations
          productVariations: [
            ProductVariationModel(
              id: 'Variation_1', // Ensure unique IDs for variations
              price: 190000,
              salePrice: 160000,
              attributeValues: {
                'Khối lượng': '1 Kg',
              },
              stock: 20,
            ),
            ProductVariationModel(
              id: 'Variation_2', // Ensure unique IDs for variations
              price: 210000,
              salePrice: 200000,
              attributeValues: {
                'Khối lượng': '2 Kg',
              },
              stock: 20,
              description: 'Ứng dụng cung cấp nông sản nhập khẩu, nền tảng mua sắm chất lượng, rõ nguồn gốc.',
            ),
          ],
          brand: BrandModel(
            id: '1',
            name: 'Việt Nam',
            productCount: 20,
            isFeatured: true,
            image: '', // Update with actual brand image URL if available
          ),
        );

        // Save the product to Firestore
        await _firestore.collection('Products').doc(product.id).set(product.toJson());
      }
      print('Thêm bản ghi thành công!');
    } catch (e) {
      print('Có lỗi xảy ra: $e');
    }
  }
}
