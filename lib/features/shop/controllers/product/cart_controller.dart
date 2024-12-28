import 'package:get/get.dart';
import 'package:project/features/shop/controllers/product/variation_controller.dart';

import '../../../../utils/constants/enums.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/cart_item_model.dart';
import '../../models/product_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  Rx noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController(){
    loadCartItems();
  }

  void addToCart(ProductModel product) {
    // Quantity Validation
    if (productQuantityCart < 1) {
      TLoaders.customToast(message: 'Chọn số lượng');
      return;
    }

    // Variation Validation
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      TLoaders.customToast(message: 'Chọn loại sản phẩm');
      return;
    }

    // Stock Validation
    if (product.productType == ProductType.variable.toString()) {
      final selectedVariation = variationController.selectedVariation.value;
      if (selectedVariation.stock < 1) {
        TLoaders.warningSnackBar(
            message: 'Loại này hết hàng rồi!', title: 'Thông báo');
        return;
      }
    } else if (product.stock < 1) {
      TLoaders.warningSnackBar(
          message: 'Sản phẩm này đã hết hàng!', title: 'Thông báo');
      return;
    }

    // Convert to Cart Item and Add to Cart
    final cartItem = convertToCartItem(product, productQuantityCart.value);

    int index = cartItems
        .indexWhere((item) => item.productId == cartItem.productId &&
        item.variationId == cartItem.variationId);

    if (index >= 0) {
      // Update quantity if item already exists
      cartItems[index].quantity = cartItem.quantity;
    } else {
      // Add new item
      cartItems.add(cartItem);
    }

    // Update Cart Summary
    updateCart();
    TLoaders.customToast(message: 'Sản phẩm đã được thêm vào giỏ hàng!');
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    // Reset attributes for single product type
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? (variation.salePrice > 0.0 ? variation.salePrice : variation.price)
        : (product.salePrice > 0.0 ? product.salePrice : product.price);

    return CartItemModel(
      productId: product.id,
      title: product.title,
      quantity: quantity,
      price: price,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand?.name ?? '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );

  }

  void addOneToCart(CartItemModel item){
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId);
    if(index >= 0){
      cartItems[index].quantity +=1;
    }else{
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item){
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId);

    if(index >= 0){
      if(cartItems[index].quantity >1){
        cartItems[index].quantity -= 1;
      }else{
        cartItems[index].quantity == 1? removeFormCartDialog(index) : cartItems.removeAt(index);
      }
      updateCart();
    }

  }

  removeFormCartDialog(int index) {
    Get.defaultDialog(
      title: "Xóa sản phẩm",
      middleText: 'Bạn chắc chắn muốn xóa sản phẩm này?',
      onConfirm: () {
        // Xóa phần tử trong giỏ hàng và cập nhật
        if (index >= 0 && index < cartItems.length) {
          cartItems.removeAt(index);
          updateCart();
        }
        // Hiển thị thông báo và thoát dialog ngay
        TLoaders.customToast(message: 'Sản phẩm đã được xóa khỏi giỏ hàng!');
        Get.back(); // Đảm bảo dialog được đóng ngay lập tức
      },
      onCancel: Get.back, // Gọi trực tiếp hàm Get.back
    );
  }


  void updateCart(){
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();

  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }
    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

    void saveCartItems(){
      final cartItemsStrings = cartItems.map((item) => item.toJson()).toList();
      TLocalStorage.instance().writeData('cartItems', cartItemsStrings);
    }

    void loadCartItems(){
      final cartItemStrings = TLocalStorage.instance().readData<List<dynamic>>('cartItems');
      if(cartItemStrings != null){
        cartItems.assignAll(cartItemStrings.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
        updateCartTotals();
      }
    }

    getProductQuantityInCart(String productId){
      final foundItem =
          cartItems.where((item) => item.productId == productId).fold(0, (previousValue, element) => previousValue + element.quantity);
      return foundItem;
    }

    getPVariationQuantityInCart(String productId, String variationId){
      final foundItem = cartItems.firstWhere(
          (item) => item.productId == productId && item.variationId == variationId,
        orElse: () => CartItemModel.empty(),
      );
      return foundItem.quantity;
    }

    void clearCart(){
    productQuantityCart.value = 0;
    cartItems.clear();
    updateCart();
    }

  void updateAlreadyAddedProductCount(ProductModel product){

    if(product.productType == ProductType.single.toString()){
      productQuantityCart.value = getProductQuantityInCart(product.id);
    }else{
      final variationId = variationController.selectedVariation.value.id;
      if(variationId.isNotEmpty){
        productQuantityCart.value = getPVariationQuantityInCart(product.id, variationId);
      }else{
        productQuantityCart.value = 0;
      }
    }
  }


}
