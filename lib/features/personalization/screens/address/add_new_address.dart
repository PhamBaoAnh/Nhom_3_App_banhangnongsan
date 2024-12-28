import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:project/common/widgets/appbar/appbar.dart';
import 'package:project/utils/validators/validation.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/address_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController()); // GetX controller instance
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Thêm địa chỉ mới'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TextFormField(
                  controller: controller.name,
                  validator: (value) => TValidator.validateEmptyText('Họ & Tên', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Họ & Tên',
                  ),
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: TSizes.spaceBtwInputFields),

                TextFormField(
                  controller: controller.phoneNumber,
                  validator: TValidator.validatePhoneNumber,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Số Điện Thoại',
                  ),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: TSizes.spaceBtwInputFields),

                TextFormField(
                  controller: controller.address1,
                  validator: (value) => TValidator.validateEmptyText('Địa Chỉ', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building_31),
                    labelText: 'Địa Chỉ',
                  ),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      side: const BorderSide(color: TColors.primary),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.addNewAddress();
                        Get.back(); // Quay lại màn hình trước đó
                      }
                    },
                    child: const Text(
                      'Lưu địa chỉ',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
