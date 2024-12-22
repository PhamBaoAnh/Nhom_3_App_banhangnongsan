import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/common/widgets/appbar/appbar_back.dart';
import '../../../features/shop/controllers/all_product_controller.dart';
import '../../../features/shop/models/brand_model.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../features/shop/screens/home/home.dart';
import '../../../features/shop/screens/productc_detail/product_detail.dart';
import '../../../features/shop/screens/search_product/search_product.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/navigation_menu.dart';
import '../appbar/appbar.dart';
import '../icons/t_circular_icon.dart';
import 'custom_Text_Form_fild.dart';
import 'custom_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();

}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  final AllProductController controller = Get.put(AllProductController());
  static List<String> previousSearches = [];

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
        child: SizedBox(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: CostomTextFormFild(
                          hint: "Tìm kiếm",
                          prefixIcon: Icons.search_rounded,
                          filled: true,
                          fillColor: TColors.darkGrey.withOpacity(0.05),
                          controller: searchController,
                          suffixIcon: searchController.text.isEmpty
                              ? null
                              : Icons.cancel_sharp,
                          onTapSuffixIcon: () {
                            searchController.clear();
                          },
                          onChanged: (pure) {
                            setState(() {});
                          },
                          onEditingComplete: () {
                            previousSearches.add(searchController.text);
                            Get.to(
                                  () => TSearchProduct(searchQuery: searchController.text),
                              transition: Transition.fadeIn, 
                              duration: const Duration(milliseconds: 300),
                            );
                          },

                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Previous Searches
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: previousSearches.length,
                      itemBuilder: (context, index) =>
                          _previousSearchItem(index),
                    ),
                    const SizedBox(height: 8),
                    // Search Suggestions
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tìm kiếm phổ biến",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 24),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                FutureBuilder<List<ProductModel>>(
                                  future: controller.randomProducts(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text(
                                          "Error: ${snapshot.error}");
                                    } else if (snapshot.hasData &&
                                        snapshot.data!.isNotEmpty) {
                                      final randomProducts = snapshot.data!;
                                      return Row(
                                        children: randomProducts.map((product) {
                                          return _searchSuggestionsItem(
                                              product.title);
                                        }).toList(),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              FutureBuilder<List<BrandModel>>(
                                future: controller.randomBrands(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text(
                                        "Error: ${snapshot.error}");
                                  } else if (snapshot.hasData &&
                                      snapshot.data!.isNotEmpty) {
                                    final randomBrands = snapshot.data!;
                                    return Row(
                                      children: randomBrands.map((brand) {
                                        return _searchSuggestionsItem(
                                            brand.name);
                                      }).toList(),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _previousSearchItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          Get.to(
                () => TSearchProduct(searchQuery: previousSearches[index]),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 300),
          );
        },

        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (DismissDirection dir) {
            setState(() {
              previousSearches.removeAt(index);
            });
          },
          child: Row(
            children: [
              const Icon(
                Icons.history, // History icon
                color: TColors.primary,
                size: 30,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  previousSearches[index],
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: TColors.black,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close, // Icon dấu x để xóa
                  color: TColors.black,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    previousSearches.removeAt(index);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchSuggestionsItem(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 8), // Reduce margin to avoid overflow
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: TColors.primary),
      ),
      child: InkWell(
        onTap: () {
          Get.to(
                () => TSearchProduct(searchQuery: text),
            transition: Transition.fadeIn, // Hiệu ứng fade
            duration: const Duration(milliseconds: 300), // Thời gian chuyển
          );
        },

        child: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: TColors.black,
          ),
        ),
      ),
    );
  }

}
