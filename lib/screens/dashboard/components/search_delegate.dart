// import 'package:admin/screens/dashboard/components/product_details_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../Getx/Products/models.dart';
// import '../../../Getx/Products/search_controller.dart';
//
// class ProductSearchDelegate extends SearchDelegate {
//   final List<ProductModel> allProducts;
//   final searchController = Get.put(SearchControllers());
//
//   ProductSearchDelegate(this.allProducts);
//
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     searchController.updateSearchQuery(query, allProducts);
//     return Obx(() {
//       final products = searchController.filteredProducts;
//       return ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return ListTile(
//             title: Text(product.title.value),
//             onTap: () {
//               close(context, product);
//               Get.to(IndividualProductDetailsPage(product: product));
//             },
//           );
//         },
//       );
//     });
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     searchController.updateSearchQuery(query, allProducts);
//     return Obx(() {
//       final products = searchController.filteredProducts;
//       return ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return ListTile(
//             title: Text(product.title.value),
//             onTap: () {
//               query = product.title.value;
//               showResults(context);
//             },
//           );
//         },
//       );
//     });
//   }
// }