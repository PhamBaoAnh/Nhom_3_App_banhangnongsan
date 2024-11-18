class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String? variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId,
    this.image,
    this.price = 0.0,
    this.title = '',
    this.selectedVariation,
    this.brandName,
  });

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] as String,
      title: json['title'] as String? ?? '', // Giá trị mặc định nếu null
      price: (json['price'] as num?)?.toDouble() ?? 0.0, // Chuyển đổi từ num sang double
      image: json['image'] as String?,
      quantity: json['quantity'] as int? ?? 0,
      variationId: json['variationId'] as String?,
      brandName: json['brandName'] as String?,
      selectedVariation: (json['selectedVariation'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, value as String)),
    );
  }
}
