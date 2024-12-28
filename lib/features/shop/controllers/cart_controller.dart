import 'package:get/get.dart';
import 'package:project/features/shop/models/product_model.dart';
import 'package:project/features/shop/models/cart_item_model.dart';

class CartControler extends GetxController {
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;

  /// Thêm sản phẩm vào giỏ hàng với số lượng nhất định
  void addToCart(ProductModel product, int quantity) {
    if (quantity < 1) return;

    final index = cartItems.indexWhere((item) => item.productId == product.id);

    if (index >= 0) {
      // Cộng dồn số lượng nếu sản phẩm đã có trong giỏ
      cartItems[index].quantity += quantity;
    } else {
      // Thêm mới sản phẩm vào giỏ
      final price = product.salePrice > 0 ? product.salePrice : product.price;
      cartItems.add(CartItemModel(
        productId: product.id,
        title: product.title,
        quantity: quantity,
        price: price,
        image: product.thumbnail,
      ));
    }

    updateCartTotals();
    cartItems.refresh();
  }

  /// Tăng số lượng của một sản phẩm trong giỏ hàng
  void addOne(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.productId == product.id);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      // Nếu sản phẩm chưa có trong giỏ, thêm với quantity = 1
      final price = product.salePrice > 0 ? product.salePrice : product.price;
      cartItems.add(CartItemModel(
        productId: product.id,
        title: product.title,
        quantity: 1,
        price: price,
        image: product.thumbnail,
      ));
    }

    updateCartTotals();
    cartItems.refresh();
  }

  /// Giảm số lượng của một sản phẩm trong giỏ hàng
  /// Nếu số lượng giảm xuống 0, sản phẩm sẽ bị xóa khỏi giỏ
  void removeOne(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.productId == product.id);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        // Số lượng bằng 1, xóa sản phẩm khỏi giỏ
        cartItems.removeAt(index);
      }
      updateCartTotals();
      cartItems.refresh();
    }
  }

  /// Cập nhật tổng số lượng và tổng giá trong giỏ hàng
  void updateCartTotals() {
    double calcTotalPrice = 0.0;
    int calcNoOfItems = 0;
    for (var item in cartItems) {
      calcTotalPrice += item.price * item.quantity;
      calcNoOfItems += item.quantity;
    }
    totalCartPrice.value = calcTotalPrice;
    noOfCartItems.value = calcNoOfItems;
  }

  /// Xóa toàn bộ giỏ hàng
  void clearCart() {
    cartItems.clear();
    totalCartPrice.value = 0.0;
    noOfCartItems.value = 0;
  }
}
