import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/common/widgets/images/t_rounded_image.dart';
import 'package:project/features/shop/screens/productc_detail/widgets/bottom_add_to_cart_widget.dart';
import 'package:project/features/shop/screens/productc_detail/widgets/product_attributes.dart';
import 'package:project/features/shop/screens/productc_detail/widgets/product_detail_image_slider.dart';
import 'package:project/features/shop/screens/productc_detail/widgets/product_meta_data.dart';
import 'package:project/features/shop/screens/productc_detail/widgets/rating_share_widget.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/curved_edges/curved_edges_widget.dart';
import '../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/product/variation_controller.dart';
import '../../models/product_model.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);

    // Sử dụng WidgetsBinding.addPostFrameCallback để gọi resetSelectedAttributes sau khi build hoàn tất
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.put(VariationController());
      controller.resetSelectedAttributes();
    });

    return Scaffold(
      bottomNavigationBar: const TButtonAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TProductimageSlider(product: product),
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  const TRatingAndShare(),
                  TProductMetaData(product: product),
                  const SizedBox(height: TSizes.spaceBtwItems ),

                  TProductAttributes(
                    product: product,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primary,
                        side: const BorderSide(color: TColors.primary),
                      ),
                      child: const Text('Check Out'),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(
                    title: 'Mô tả ',
                    textColor: TColors.black,
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const ReadMoreText(
                    'Dự án phát triển ứng dụng bán nông sản nhập khẩu nhằm cung cấp cho người dùng một nền tảng dễ dàng tiếp cận và mua sắm các sản phẩm nông sản chất lượng cao, nguồn gốc rõ ràng.',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Xem thêm',
                    trimExpandedText: ' Rút gọn',
                    textAlign: TextAlign.justify,
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                        title: 'Bình Luận (150) ',
                        textColor: TColors.black,
                        showActionButton: false,
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_right))
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




