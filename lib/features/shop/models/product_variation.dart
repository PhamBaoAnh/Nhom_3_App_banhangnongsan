class ProductVariationModel {
  final String id;
  String sku;
  String image;
  double price;
  String? description;  // Có thể để null
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description,  // Để description có thể null
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  static ProductVariationModel empty() => ProductVariationModel(id: '', attributeValues: {});

  Map<String, dynamic> toJson() {  // Cần chỉ rõ kiểu trả về là Map<String, dynamic>
    return {
      'Id': id,
      'SKU': sku,
      'Image': image,
      'Price': price,
      'Description': description,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttributeValues': attributeValues,
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    return ProductVariationModel(
      id: document['Id'] ?? '',
      sku: document['SKU'] ?? '',
      image: document['Image'] ?? '',
      description: document['Description'],  // Không cần dùng ?? cho nullable field
      price: (document['Price'] ?? 0.0).toDouble(),
      salePrice: (document['SalePrice'] ?? 0.0).toDouble(),
      stock: document['Stock'] ?? 0,
      attributeValues: Map<String, String>.from(document['AttributeValues'] ?? {}),
    );
  }
}
