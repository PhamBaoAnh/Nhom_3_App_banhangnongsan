import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project/data/repositories/product/product_repository.dart';
import 'package:project/features/shop/models/product_model.dart';

class AllProductController extends GetxController{
  static AllProductController get instance => Get.find();
  final repo =Get.put(ProductRepository());

final RxString selectSort ='Name'.obs;
final RxList <ProductModel> products= <ProductModel>[].obs;

  Future<List<ProductModel>>fetchProductsQuery(Query? query)async{
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
      case 'Higher Price':
        products.sort((a,b)=>a.price.compareTo(b.price));
        break;
      case 'Lower Price':
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
  void assignProducts(List<ProductModel> newProducts) {
    selectSort.value ='Name';
    products.assignAll(newProducts);
  }

}