import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:project/features/personalization/screens/address/widgets/single_address.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/sizes.dart';

import '../../../common/widgets/texts/section_heading.dart';
import '../../../data/repositories/address_repository/address_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/address_model.dart';
import '../screens/address/add_new_address.dart';


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

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(TSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(
              title: 'Địa chỉ',
              showActionButton: false,
              textColor: TColors.black,
            ),
            const SizedBox(height: TSizes.defaultSpace ),
            Expanded(
              child: FutureBuilder(
                future: getAllAddresses(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No addresses available"));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => TSingleAddress(
                      address: snapshot.data![index],
                      onTap: () async {
                        await selectAddress(snapshot.data![index]);
                        Get.back();
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: TSizes.defaultSpace * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const AddNewAddressScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    side: const BorderSide(color: TColors.primary),
                  ),
                  child: const Text('Thêm địa chỉ mới')


              ),
            )
          ],
        ),
      ),
    );
  }



  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    address1.clear();
  }
}
