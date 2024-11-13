class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
  });

  // Static method to return an empty instance of BrandModel
  static BrandModel empty() => BrandModel(
    id: '',
    name: '',
    image: '',

  );

  // Method to convert the object to a JSON-compatible map
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'ProductsCount': productsCount,
    };
  }

  // Factory constructor to create an instance from JSON data
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    return BrandModel(
      id: document['Id'] ?? '',
      name: document['Name'] ?? '',
      image: document['Image'] ?? '',
      isFeatured: document['IsFeatured'] ?? false,
      productsCount: document['ProductsCount'] ?? 0,
    );
  }
}
