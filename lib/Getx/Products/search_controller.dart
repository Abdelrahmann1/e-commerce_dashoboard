import 'package:get/get.dart';
import 'models.dart';

class ProductSearchController extends GetxController {
  var searchQuery = ''.obs;
  var allProducts = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;

  ProductSearchController({required List<ProductModel> allProducts}) {
    this.allProducts.value = allProducts;
    filterProducts();
  }

  void filterProducts() {
    if (searchQuery.value.isEmpty) {
      filteredProducts.value = allProducts;
    } else {
      filteredProducts.value = allProducts.where((product) {
        final query = searchQuery.value.toLowerCase();
        return product.title.value.toLowerCase().contains(query) ||
            (product.description?.value.toLowerCase().contains(query) ?? false);
      }).toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterProducts();
  }
}