import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String address;
  final DateTime? dateTime;
  bool selectedAddress;

  // Constructor
  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
    id: '',
    name: '',
    phoneNumber: '',
    address: '',
    dateTime: DateTime.now(),
  );

  // Tạo từ Map
  factory AddressModel.fromMap(Map<String, dynamic>? data, {String? id}) {
    if (data == null) {
      return AddressModel.empty();
    }

    return AddressModel(
      id: id ?? '',
      name: data['name'] as String? ?? '',
      phoneNumber: data['phoneNumber'] as String? ?? '',
      address: data['address'] as String? ?? '',
      dateTime: (data['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      selectedAddress: data['selectedAddress'] as bool? ?? false,
    );
  }

  // Chuyển đối tượng thành Map (dùng khi lưu vào Firestore)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'dateTime': dateTime ?? DateTime.now(),
      'selectedAddress': selectedAddress,
    };
  }

  // Tạo từ Firestore snapshot
  factory AddressModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) {
      return AddressModel.empty();
    }

    return AddressModel(
      id: document.id,
      name: data['name'] as String? ?? '',
      phoneNumber: data['phoneNumber'] as String? ?? '',
      address: data['address'] as String? ?? '',
      dateTime: (data['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      selectedAddress: data['selectedAddress'] as bool? ?? false,
    );
  }
}
