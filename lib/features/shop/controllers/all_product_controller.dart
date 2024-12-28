import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project/data/repositories/product/product_repository.dart';
import 'package:project/features/shop/models/product_model.dart';

import '../models/brand_model.dart';

class AllProductController extends GetxController{
  static AllProductController get instance => Get.find();
   ProductRepository repo =Get.put(ProductRepository());

  final RxString selectSort ='Name'.obs;
  final RxList <ProductModel> products= <ProductModel>[].obs;
  final RxString selectBrand ='Việt Nam'.obs;

  @override
  void onInit() {
    super.onInit();
    getAllProducts();
  }


  Future<List<ProductModel>>fetchProductsByBrand(String brandName)async{
    try{
      final listProducts = await repo.getProductsByBrand(brandName);
      assignProducts(listProducts);
      sortProducts(selectSort.value);
      return listProducts;
    }
    catch(e){
      Get.snackbar("Error", 'Error');
      return [];
    }

  }
  Future<List<ProductModel>>fetchProductsQuery(Query? query)async{
    try{
      if (query == null) return[];
      final listProducts = await repo.fetchAllProductsQuery(query);
      assignProducts(listProducts);
      sortProducts(selectSort.value);
      return listProducts;
    }
    catch(e){
      Get.snackbar("Error", 'dddddddddddddddddddsdd');
      return [];
    }

  }
  Future<List<ProductModel>>fetchFeaturedProducts(Query? query)async{
    try{
      if (query == null) return[];
      final listProducts = await repo.fetchAllProductsQuery(query);
      assignProducts(listProducts);
      sortProducts(selectSort.value);
      return listProducts;
    }
    catch(e){
      Get.snackbar("Error", 'Error');
      return [];
    }

  }
  void sortProducts(String option){
    selectSort.value =option;
    switch(option){
      case 'Name':
        products.sort((a,b)=>a.title.compareTo(b.title));
        break;
      case 'Lower Price':
        products.sort((a,b)=>a.price.compareTo(b.price));
        break;
      case 'Higher Price':
        products.sort((a,b)=>b.price.compareTo(a.price));
        break;
      case 'Sale':
        products.sort((a,b){
          if(b.salePrice>0) return b.salePrice.compareTo(a.salePrice);
          else if(a.salePrice>0) return -1;
          else return 1;
        });
        break;
      default:     products.sort((a,b)=>a.price.compareTo(b.price));
    }
  }


  void filterBrand(String option) {
    selectBrand.value = option;
    final filteredProducts = products
        .where((product) => product.brand?.name == option)
        .toList();
    products.assignAll(filteredProducts);
  }

  void assignProducts(List<ProductModel> newProducts) {
    selectSort.value= 'Name';
    products.assignAll(newProducts);
  }
  void assignProductBrands(List<ProductModel> newProducts) {
    selectBrand.value= 'Việt Nam';
    products.assignAll(newProducts);
  }


  Future<void> filterProducts(String searchQuery) async {
    try {
      // Lấy danh sách sản phẩm từ repo
      final listProducts = await repo.getProductByName(searchQuery);

      // Cập nhật danh sách products
      products.assignAll(listProducts);

      print('Số lượng sản phẩm sau khi lọc: ${listProducts.length}');
    } catch (e) {
      // Thông báo lỗi
      print('Error: $e');
      Get.snackbar("Error", "Không thể lọc sản phẩm");
    }
  }
  Future<void> filterProductsSaleMax() async {
    try {
      // Lấy danh sách sản phẩm từ repo
      final listProducts = await repo.getRandomProductMaxSale();

      // Cập nhật danh sách products
      products.assignAll(listProducts);

      print('Số lượng sản phẩm sau khi lọc: ${listProducts.length}');
    } catch (e) {
      // Thông báo lỗi
      print('Error: $e');
      Get.snackbar("Error", "Không thể lọc sản phẩm");
    }
  }

  Future<List<ProductModel>> randomProducts() async {
    try {
      // Lấy danh sách sản phẩm từ repo
      final listProducts = await repo.getRandomProduct();

      return listProducts; // Trả về danh sách sản phẩm
    } catch (e) {
      // Thông báo lỗi
      print('Error: $e');
      Get.snackbar("Error", "Không thể lọc sản phẩm");
      return []; // Trả về một danh sách trống nếu có lỗi
    }
  }

  Future<List<BrandModel>> randomBrands() async {
    try {
      // Lấy danh sách sản phẩm từ repo
      final listBrands = await repo.getRandomBrand();

      return listBrands ; // Trả về danh sách sản phẩm
    } catch (e) {
      // Thông báo lỗi
      print('Error: $e');
      Get.snackbar("Error", "Không thể lọc sản phẩm");
      return []; // Trả về một danh sách trống nếu có lỗi
    }
  }


  Future<List<ProductModel>> getAllProducts() async {
    try {
      // Lấy danh sách sản phẩm từ repo
      final listProducts = await repo.getAllProducts();

      return listProducts; // Trả về danh sách sản phẩm
    } catch (e) {
      // Thông báo lỗi
      print('Error: $e');
      Get.snackbar("Error", "Không thể lọc sản phẩm");
      return []; // Trả về một danh sách trống nếu có lỗi
    }
  }

  void clearAllProducts() {
    products.clear();
  }

}