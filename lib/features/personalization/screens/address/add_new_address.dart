
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/common/widgets/appbar/appbar.dart';

import '../../../../utils/constants/sizes.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true,title: Text('Thêm địa chỉ mới'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Họ & Tên'),),
              const SizedBox(height: TSizes.spaceBtwInputFields,),
              TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Số Điện Thoại'),),
              const SizedBox(height: TSizes.spaceBtwInputFields,),
              TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Địa Chỉ'),),
              const SizedBox(height: TSizes.defaultSpace,),
              SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){}, child: const Text('Lưu địa chỉ')),)
            ],
          ),
        ),
      ),
    );
  }
}
