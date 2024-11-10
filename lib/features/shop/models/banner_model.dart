import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerModel {
  String imageUrl;
  String targetScreen;
  bool active;

  // Constructor
  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });



// Phương thức từ Map -> CategoryModel (dùng khi lấy từ Firestore)
  factory BannerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return BannerModel(
        imageUrl: data['ImageUrl'] ?? '',
        targetScreen: data['TargetScreen'] ?? '',
        active: data['Active'] ?? false,
      );
    } else {
      throw StateError('Document does not exist or has no data');
    }
  }

  // Phương thức từ CategoryModel -> Map (dùng khi lưu vào Firestore)
  Map<String, dynamic> toJson() {
    return {
      'Active': active,
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
    };
  }
}
