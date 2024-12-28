import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/controllers/cart_controller.dart';
import 'package:project/features/shop/models/product_model.dart';
import 'package:project/features/shop/models/cart_item_model.dart';

void main() {
  // Đưa CartControllerSimple vào GetX DI
  setUpAll(() {
    Get.put<CartControler>(CartControler());
  });

  // Mỗi test xong sẽ clear giỏ hàng để các test độc lập
  tearDown(() {
    final controller = Get.find<CartControler>();
    controller.clearCart();
  });

  group('Quản lý giỏ hàng', () {
    late CartControler cartController;

    setUp(() {
      cartController = Get.find<CartControler>();
    });

    test('Thêm sản phẩm vào giỏ hàng', () {
      final product = ProductModel(
        id: '1',
        title: 'Sầu riêng',
        stock: 10,
        price: 100.0,
        salePrice: 80.0,
        thumbnail: 'https://image.png',
        productType: 'Hoa quả',
      );

      // Thêm vào giỏ với quantity = 2
      cartController.addToCart(product, 2);

      // Kiểm tra giỏ hàng
      expect(cartController.cartItems.length, 1);
      expect(cartController.cartItems.first.productId, '1');
      expect(cartController.cartItems.first.quantity, 2);
      expect(cartController.cartItems.first.price, 80.0);
      expect(cartController.cartItems.first.image, 'https://image.png');

      // Kiểm tra tổng số lượng và tổng giá
      expect(cartController.noOfCartItems.value, 2);
      expect(cartController.totalCartPrice.value, 160.0); // 2 * 80
    });


    test('Tăng số lượng sản phẩm trong giỏ hàng', () {
      final product = ProductModel(
        id: '1',
        title: 'Sầu riêng',
        stock: 20,
        price: 200.0,
        salePrice: 150.0,
        thumbnail: 'https://image.png',
        productType: 'single',
      );

      // Thêm vào giỏ với quantity = 1
      cartController.addToCart(product, 1);

      // Tăng số lượng lên 1
      cartController.addOne(product);

      // Kiểm tra giỏ hàng
      expect(cartController.cartItems.length, 1);
      expect(cartController.cartItems.first.productId, '1');
      expect(cartController.cartItems.first.quantity, 2);
      expect(cartController.cartItems.first.price, 150.0); // salePrice > 0

      // Kiểm tra tổng số lượng và tổng giá
      expect(cartController.noOfCartItems.value, 2);
      expect(cartController.totalCartPrice.value, 300.0); // 2 * 150
    });

    test('Giảm số lượng sản phẩm trong giỏ hàng', () {
      final product = ProductModel(
        id: '1',
        title: 'Cherry',
        stock: 5,
        price: 60.0,
        salePrice: 0.0,
        thumbnail: 'https://cherry.png',
        productType: 'Hoa quả',
      );

      // Thêm vào giỏ với quantity = 3
      cartController.addToCart(product, 3);

      // Giảm số lượng xuống 1
      cartController.removeOne(product);

      // Kiểm tra giỏ hàng
      expect(cartController.cartItems.length, 1);
      expect(cartController.cartItems.first.productId, '1');
      expect(cartController.cartItems.first.quantity, 2);
      expect(cartController.cartItems.first.price, 60.0);

      // Kiểm tra tổng số lượng và tổng giá
      expect(cartController.noOfCartItems.value, 2);
      expect(cartController.totalCartPrice.value, 120.0); // 2 * 60
    });

    test('Xóa sản phẩm khỏi giỏ hàng khi số lượng giảm xuống 0', () {
      final product = ProductModel(
        id: '1',
        title: 'Xoài',
        stock: 2,
        price: 150.0,
        salePrice: 120.0,
        thumbnail: 'https://xoài.png',
        productType: 'Hoa quả',
      );

      // Thêm vào giỏ với quantity = 1
      cartController.addToCart(product, 1);

      // Giảm số lượng xuống 0
      cartController.removeOne(product);

      // Kiểm tra giỏ hàng đã bị xóa
      expect(cartController.cartItems.length, 0);
      expect(cartController.noOfCartItems.value, 0);
      expect(cartController.totalCartPrice.value, 0.0);
    });
  });
}
