import 'dart:async';
import 'package:get/get.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';
import '../../../../data/repositories/banners/banner_repository.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../models/banner_model.dart';
import '../../models/product_model.dart';
import '../../models/product_variation.dart';
import 'images_controller.dart';

class VariationController extends GetxController {
 static VariationController get instance => Get.find();

 RxMap<String, dynamic> selectedAttributes = <String, dynamic>{}.obs;
 RxString variationStockStatus = ''.obs;  // Trạng thái kho của biến thể hiện tại
 Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;



 // Hàm khi chọn thuộc tính
 void onAttributeSelected(ProductModel product, String attributeName, dynamic attributeValue) {
  selectedAttributes[attributeName] = attributeValue;

  // Tìm biến thể phù hợp với thuộc tính đã chọn
  final matchingVariation = product.productVariations!.firstWhere(
       (variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes),
   orElse: () => ProductVariationModel.empty(),
  );

  if (matchingVariation.image.isNotEmpty) {
   ImagesController.instance.selectedProductImage.value = matchingVariation.image;
  }

  selectedVariation.value = matchingVariation;

  // Cập nhật trạng thái kho sau khi chọn thuộc tính
  getProductVariationStockStatus();
 }

 // Kiểm tra các thuộc tính có giống nhau không
 bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes) {
  if (variationAttributes.length != selectedAttributes.length) return false;

  for (final key in variationAttributes.keys) {
   if (variationAttributes[key] != selectedAttributes[key]) return false;
  }
  return true;
 }

 // Lấy các giá trị có sẵn của thuộc tính trong biến thể
 Set<String?> getAttributesAvailabilityInVariation(List<ProductVariationModel> variations, String attributeName) {
  final availableVariationAttributeValues = variations
      .where((variation) =>
  variation.attributeValues[attributeName] != null &&
      variation.attributeValues[attributeName]!.isNotEmpty &&
      variation.stock > 0)
      .map((variation) => variation.attributeValues[attributeName])
      .toSet();

  return availableVariationAttributeValues;
 }

 // Lấy giá của biến thể
 String getVariationPrice() {
  double salePrice = selectedVariation.value.salePrice;
  double price = selectedVariation.value.price;

  return (salePrice > 0 ? salePrice : price).toStringAsFixed(0);
 }

 // Cập nhật trạng thái kho của biến thể hiện tại
 void getProductVariationStockStatus() {
  if (selectedVariation.value.id.isEmpty) {
   variationStockStatus.value = 'Không có thông tin';
  } else {
   variationStockStatus.value = selectedVariation.value.stock > 0 ? 'Còn hàng' : 'Hết hàng';
  }
 }

 // Đặt lại các thuộc tính đã chọn
 void resetSelectedAttributes() {
  selectedAttributes.clear();
  variationStockStatus.value = '';
  selectedVariation.value = ProductVariationModel.empty();
 }


}
