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


 void initializeVariation(ProductModel product) {
  if (selectedVariation.value.id.isEmpty && (product.productVariations?.isNotEmpty ?? false)) {
   // Chọn biến thể đầu tiên
   selectedVariation.value = product.productVariations!.first;

   // Cập nhật trạng thái kho dựa trên biến thể đầu tiên
   variationStockStatus.value = selectedVariation.value.stock > 0 ? 'Còn hàng' : 'Hết hàng';
  }
 }



 // Set a default variation when the product is loaded.
 void setDefaultVariation(ProductModel product) {
  if (product.productVariations?.isNotEmpty ?? false) {
   // Set the first available variation as the default variation.
   selectedVariation.value = product.productVariations!.first;
   selectedAttributes.value = selectedVariation.value.attributeValues;
  } else {
   // Nếu không có biến thể, gán giá trị mặc định cho selectedVariation
   selectedVariation.value = ProductVariationModel.empty();
  }

  // Cập nhật trạng thái kho khi chọn biến thể mặc định
  getProductVariationStockStatus();
 }

 // Khi người dùng chọn thuộc tính mới
 void onAttributeSelected(ProductModel product, String attributeName, dynamic attributeValue) {
  selectedAttributes[attributeName] = attributeValue;

  // Tìm biến thể phù hợp với thuộc tính đã chọn
  final selectedVariation = product.productVariations?.firstWhere(
       (variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes),
   orElse: () => ProductVariationModel.empty(),
  );

  if (selectedVariation?.image.isNotEmpty ?? false) {
   ImagesController.instance.selectedProductImage.value = selectedVariation!.image;
  }

  this.selectedVariation.value = selectedVariation ?? ProductVariationModel.empty();

  // Cập nhật trạng thái kho sau khi chọn thuộc tính
  getProductVariationStockStatus();
 }

 // Kiểm tra xem các thuộc tính có giống nhau không
 bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes) {
  if (variationAttributes.length != selectedAttributes.length) return false;

  for (final key in variationAttributes.keys) {
   if (variationAttributes[key] != selectedAttributes[key]) return false;
  }
  return true;
 }

 // Lấy danh sách giá trị thuộc tính có sẵn trong các biến thể
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

 // Cập nhật trạng thái kho
 void getProductVariationStockStatus() {
  // Kiểm tra nếu có biến thể
  if (selectedVariation.value.id.isEmpty) {
   // Nếu không có biến thể, đặt trạng thái kho mặc định (ví dụ: 'Không có thông tin')
   variationStockStatus.value = 'Không có thông tin';
  } else {
   // Nếu có biến thể, cập nhật trạng thái kho
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
