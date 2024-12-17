import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/common/widgets/appbar/appbar_back.dart';
import 'package:project/features/shop/controllers/all_product_controller.dart';
import 'package:project/features/shop/models/product_model.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_search/custom_Text_Form_fild.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class TSearchProduct extends StatefulWidget {
  const TSearchProduct({super.key, required this.searchQuery});

  final String searchQuery;

  @override
  _TSearchProductState createState() => _TSearchProductState();
}

class _TSearchProductState extends State<TSearchProduct> {
  final AllProductController controller = Get.put(AllProductController());
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchQuery;
    controller.filterProducts(widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBarBack(
        title: Text(
          'Tìm kiếm',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: CostomTextFormFild(
                        controller: _searchController,
                        hint: "Tìm kiếm",
                        prefixIcon: Icons.search_rounded,
                        filled: true,
                        fillColor: TColors.darkGrey.withOpacity(0.1),
                        readOnly: false,
                        onChanged: (query) {
                          controller.filterProducts(query);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Using FutureBuilder to add a delay of 1 second
              FutureBuilder(
                future: Future.delayed(const Duration(seconds: 1)), // Delay of 1 second
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading widget while waiting
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // Once data is available or after the delay
                    return Obx(
                          () => controller.products.isEmpty
                          ? const Center(
                        child: Text(
                          'Không có sản phẩm',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                          : TGridLayout(
                        itemCount: controller.products.length,
                        itemBuilder: (_, index) => TProductCardVertical(
                          product: controller.products[index],
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: Text('Có lỗi xảy ra'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
