import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../personalization/models/address_model.dart';
import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = '',
    this.address,
    this.deliveryDate,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formatDeliveryDate =>
      deliveryDate != null ? THelperFunctions.getFormattedDate(orderDate) : '';


  String get orderStatusText {
    if (status == OrderStatus.delivered) {
      return 'Đã vận chuyển';
    } else if (status == OrderStatus.shipped) {
      return 'Đang vận chuyển';
    } else if (status == OrderStatus.cancelled) {
      return 'Đã hủy';
    } else if (status == OrderStatus.processing) {
      return 'Đang chờ xác nhận';
    } else {
      return 'Đang chờ xác nhận'; // Default fallback if status is none of the above
    }
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(), // Chuyển đổi Enum thành String
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'address': address?.toJson(), // Đảm bảo AddressModel có phương thức toJson
      'deliveryDate': deliveryDate?.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(), // Ánh xạ CartItemModel
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return OrderModel(
        id: data['id'] as String,
        userId: data['userId'] ?? '',
        status: OrderStatus.values.firstWhere(
              (e) => e.toString() == data['status'],
          orElse: () => OrderStatus.pending, // Giá trị mặc định
        ),
        totalAmount: (data['totalAmount'] ?? 0.0) as double,
        orderDate: DateTime.parse(data['orderDate'] ?? DateTime.now().toIso8601String()),
        paymentMethod: data['paymentMethod'] as String,
        address: data['address'] != null ? AddressModel.fromMap(data['address']) : null,
        deliveryDate: data['deliveryDate'] != null ? DateTime.parse(data['deliveryDate']) : null,
        items: (data['items'] as List<dynamic>?)
            ?.map((item) => CartItemModel.fromJson(item))
            .toList() ??
            [],
      );
    } else {
      throw StateError('Document does not exist or has no data');
    }
  }






}
