import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/common/widgets/appbar/appbar.dart';
import 'package:project/features/personalization/screens/address/widgets/single_address.dart';
import 'package:project/utils/constants/colors.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../data/repositories/address_repository/address_repository.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/address_controller.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: TColors.primary,
          onPressed: () => Get.to(() => const  AddNewAddressScreen()),
           child: const Icon(Iconsax.add, color: TColors.white,),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Địa chỉ',style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Obx(
              () => FutureBuilder(
                key: Key(controller.refreshData.value.toString()),
                future: controller.getAllAddresses(),
                builder: (context, snapshot) {

                  final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                   if(response != null) return response ;
                   final addresses = snapshot.data!;

                  return ListView.builder(
                      itemCount: addresses.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) =>  TSingleAddress(
                        address: addresses[index],
                        onTap: () => controller.selectAddress(addresses[index]),
                      )
                  );
                }
              ),
            ),
        ),
      ),
    );
  }
}
