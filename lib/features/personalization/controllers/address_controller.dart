import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/repositories/address_repository/address_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/address_model.dart';


class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final address1 = TextEditingController();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  Future<List<AddressModel>> getAllAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses(); // Đảm bảo đúng tên phương thức
      selectedAddress.value = addresses.firstWhere(
            (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      Get.snackbar('Error', 'Error occurred: $e');
      return [];
    }
  }

  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    try {
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      await addressRepository.updateSelectedField(newSelectedAddress.id, true);
    } catch (e) {
      Get.snackbar('Error', 'Error occurred: $e');
    }
  }

  Future<void> addNewAddress() async {
    try {
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        address: address1.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepository.addAddress(address);
      address.id = id;

      await selectAddress(address);

      TLoaders.successSnackBar(
        title: 'Thành công',
        message: 'Địa chỉ đã được lưu thành công!',
      );

      refreshData.toggle();
      resetFormFields();

      Get.back(); // Thay vì Navigator.of(Get.context!).pop()
    } catch (e) {
      Get.snackbar('Error', 'Error occurred: $e');
    }
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    address1.clear();
  }
}
