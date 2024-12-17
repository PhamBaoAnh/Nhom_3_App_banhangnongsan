import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/common/widgets/appbar/appbar_back.dart';
import 'package:project/features/shop/controllers/product/brand_controller.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';
import 'package:project/utils/constants/colors.dart';

import '../../../../common/widgets/brand/brand_products.dart';
import '../../../../common/widgets/brand/brandcard.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController(), permanent: true);
    final controllerBrand = Get.put(BrandController(), permanent: true);

    return Scaffold(
      appBar: const TAppBarBack(
        showBackArrow: true,
        title: Text('Quốc Gia'),
      ),
      body: FutureBuilder(
        future: controllerBrand.getAllBrands(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Đã xảy ra lỗi khi tải dữ liệu.',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Không có thương hiệu nào.'),
            );
          }

          // Lấy dữ liệu thương hiệu
          final brands = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TSectionHeading(
                    title: 'Quốc Gia',
                    textColor: TColors.black,
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TGridLayout(
                    itemCount: brands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (context, index) => TBrandCard(
                      brand: brands[index],
                      showBorder: true,
                      onTap: () => Get.to(() => BrandProducts(
                        brand: brands[index],
                      )),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
