import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';
import 'package:project/features/shop/models/product_model.dart';

import '../../../features/shop/screens/productc_detail/product_detail.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../products/product_cards/product_card_vertical.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductController());
    return FutureBuilder<List<ProductModel>>(
        future: controller.fetchAllFeaturedProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          List<ProductModel> products = snapshot.data!;
          return GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: padding,
              child: Container(
                width: TDeviceUtils.getScreenWidth(context),
                padding: const EdgeInsets.all(TSizes.md),
                decoration: BoxDecoration(
                  color: showBackground
                      ? dark
                          ? TColors.dark
                          : TColors.light
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                  border: showBorder ? Border.all(color: TColors.grey) : null,
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: CustomSearch(products));
                        },
                        icon: const Icon(Icons.search_rounded)),
                    const SizedBox(width: 50),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                  ],
                ),
              ),
            ),
          );
        });
  }
}

class CustomSearch extends SearchDelegate {
  final List<ProductModel> products;
  CustomSearch(this.products);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    List<String> productNames= products.map((product) => product.title).toList();
    for (var item in productNames) {
      if (item.toLowerCase().contains(query)) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetail(product: products[index]),
                  ),
                );
              },
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft, // Căn trái nội dung
              ),
              child: Text(
                products[index].title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // Làm chữ đậm
                  color: TColors.textSecondary, // Màu chữ
                  letterSpacing: 1.2, // Khoảng cách giữa các ký tự
                ),
              ),
            ),
          );
        },)
;
        }
  @override
  Widget buildResults(BuildContext context) {
    List<ProductModel> matchQuery = [];
    for (var item in products) {
      if (item.title.toLowerCase().contains(query)) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return  ProductDetail(product: result);
        },
        itemCount: matchQuery.length);
  }
}
