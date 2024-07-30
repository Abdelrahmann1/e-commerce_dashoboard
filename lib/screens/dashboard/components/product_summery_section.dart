import 'package:admin/screens/dashboard/components/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../Getx/Products/models.dart';
import '../../../Getx/Products/new_controller.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/product_summery_info.dart';
import '../../../utility/constants.dart';
import 'product_summery_card.dart';

// class ProductSummerySection extends StatelessWidget {
//   const ProductSummerySection({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;
//
//     return Consumer<DataProvider>(
//       builder: (context, dataProvider, _) {
//         int totalProduct = 1;
//         //TODO: should complete Make this product number dynamic bt calling calculateProductWithQuantity
//         totalProduct = 1;
//         int outOfStockProduct = 0;
//         int limitedStockProduct = 0;
//         int otherStockProduct = totalProduct - outOfStockProduct - limitedStockProduct;
//
//         List<ProductSummeryInfo> productSummeryItems = [
//           ProductSummeryInfo(
//             title: "All Product",
//             productsCount: totalProduct,
//             svgSrc: "assets/icons/Product.svg",
//             color: primaryColor,
//             percentage: 100,
//           ),
//           ProductSummeryInfo(
//             title: "Out of Stock",
//             productsCount: outOfStockProduct,
//             svgSrc: "assets/icons/Product2.svg",
//             color: Color(0xFFEA3829),
//             percentage: totalProduct != 0 ? (outOfStockProduct / totalProduct) * 100 : 0,
//           ),
//           ProductSummeryInfo(
//             title: "Limited Stock",
//             productsCount: limitedStockProduct,
//             svgSrc: "assets/icons/Product3.svg",
//             color: Color(0xFFECBE23),
//             percentage: totalProduct != 0 ? (limitedStockProduct / totalProduct) * 100 : 0,
//           ),
//           ProductSummeryInfo(
//             title: "Other Stock",
//             productsCount: otherStockProduct,
//             svgSrc: "assets/icons/Product4.svg",
//             color: Color(0xFF47e228),
//             percentage: totalProduct != 0 ? (otherStockProduct / totalProduct) * 100 : 0,
//           ),
//         ];
//
//         return Column(
//           children: [
//             GridView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: productSummeryItems.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 crossAxisSpacing: defaultPadding,
//                 mainAxisSpacing: defaultPadding,
//                 childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
//               ),
//               itemBuilder: (context, index) => ProductSummeryCard(
//                 info: productSummeryItems[index],
//                 onTap: (productType) {
//                   //TODO: should complete call filterProductsByQuantity
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


// class ProductSummerySection extends StatelessWidget {
//   const ProductSummerySection({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;
//     final NewAdminPanelController productController = Get.put(NewAdminPanelController());
//
//     return Obx(() {
//       int totalProduct = productController.productCount;
//       int outOfStockProduct = productController.outOfStockCount;
//       int limitedStockProduct = productController.limitedStockCount;
//       int otherStockProduct = totalProduct - outOfStockProduct - limitedStockProduct;
//
//       List<ProductSummeryInfo> productSummeryItems = [
//         ProductSummeryInfo(
//           title: "All Product",
//           productsCount: totalProduct,
//           svgSrc: "assets/icons/Product.svg",
//           color: primaryColor,
//           percentage: 100,
//         ),
//         ProductSummeryInfo(
//           title: "Out of Stock",
//           productsCount: outOfStockProduct,
//           svgSrc: "assets/icons/Product2.svg",
//           color: Color(0xFFEA3829),
//           percentage: totalProduct != 0 ? (outOfStockProduct / totalProduct) * 100 : 0,
//         ),
//         ProductSummeryInfo(
//           title: "Limited Stock",
//           productsCount: limitedStockProduct,
//           svgSrc: "assets/icons/Product3.svg",
//           color: Color(0xFFECBE23),
//           percentage: totalProduct != 0 ? (limitedStockProduct / totalProduct) * 100 : 0,
//         ),
//         ProductSummeryInfo(
//           title: "Other Stock",
//           productsCount: otherStockProduct,
//           svgSrc: "assets/icons/Product4.svg",
//           color: Color(0xFF47e228),
//           percentage: totalProduct != 0 ? (otherStockProduct / totalProduct) * 100 : 0,
//         ),
//       ];
//
//       return Column(
//         children: [
//           GridView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: productSummeryItems.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 4,
//               crossAxisSpacing: defaultPadding,
//               mainAxisSpacing: defaultPadding,
//               childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
//             ),
//             itemBuilder: (context, index) => ProductSummeryCard(
//               info: productSummeryItems[index],
//               onTap: (productType) {
//                 //TODO: should complete call filterProductsByQuantity
//               },
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }


class ProductSummerySection extends StatelessWidget {
  const ProductSummerySection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final NewAdminPanelController productController = Get.put(NewAdminPanelController());

    return Obx(() {
      int totalProduct = productController.productCount;
      int outOfStockProduct = productController.outOfStockCount;
      int limitedStockProduct = productController.limitedStockCount;
      int otherStockProduct = totalProduct - outOfStockProduct - limitedStockProduct;

      List<ProductSummeryInfo> productSummeryItems = [
        ProductSummeryInfo(
          title: "All Product",
          productsCount: totalProduct,
          svgSrc: "assets/icons/Product.svg",
          color: primaryColor,
          percentage: 100,
        ),
        ProductSummeryInfo(
          title: "Out of Stock",
          productsCount: outOfStockProduct,
          svgSrc: "assets/icons/Product2.svg",
          color: Color(0xFFEA3829),
          percentage: totalProduct != 0 ? (outOfStockProduct / totalProduct) * 100 : 0,
        ),
        ProductSummeryInfo(
          title: "Limited Stock",
          productsCount: limitedStockProduct,
          svgSrc: "assets/icons/Product3.svg",
          color: Color(0xFFECBE23),
          percentage: totalProduct != 0 ? (limitedStockProduct / totalProduct) * 100 : 0,
        ),
        ProductSummeryInfo(
          title: "Other Stock",
          productsCount: otherStockProduct,
          svgSrc: "assets/icons/Product4.svg",
          color: Color(0xFF47e228),
          percentage: totalProduct != 0 ? (otherStockProduct / totalProduct) * 100 : 0,
        ),
      ];

      return Column(
        children: [
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: productSummeryItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            ),
            itemBuilder: (context, index) => ProductSummeryCard(
              info: productSummeryItems[index],
              onTap: (productType) {
                //TODO: should complete call filterProductsByQuantity
              },
            ),
          ),
        ],
      );
    });
  }
}



class ProductSummarySections extends StatelessWidget {
  const ProductSummarySections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return GetX<NewAdminPanelController>(
      builder: (controller) {
        List<ProductModel> products = controller.products;
        List<ProductSummary> summaries = ProductSummary.generateSummaries(products);

        return Column(
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: summaries.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
              ),
              itemBuilder: (context, index) {
                if (index < summaries.length) {
                  return ProductSummaryCards(
                    summary: summaries[index],
                    onTap: (category) {
                      Get.to(() => ProductDetailsPage(category: category));
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
class ProductSummary {
  final ProductCategory category;
  final String title;
  final String svgSrc;
  final Color color;
  final int count;
  final double percentage;

  ProductSummary({
    required this.category,
    required this.title,
    required this.svgSrc,
    required this.color,
    required this.count,
    required this.percentage,
  });

  static List<ProductSummary> generateSummaries(List<ProductModel> products) {
    int totalProducts = products.length;
    int outOfStockCount = products.where((p) => p.category == ProductCategory.outOfStock).length;
    int limitedStockCount = products.where((p) => p.category == ProductCategory.limitedStock).length;
    int otherStockCount = totalProducts - outOfStockCount - limitedStockCount;

    return [
      ProductSummary(
        category: ProductCategory.all,
        title: "All Products",
        svgSrc: "assets/icons/Product.svg",
        color: Colors.blue,
        count: totalProducts,
        percentage: 100.0,
      ),
      ProductSummary(
        category: ProductCategory.outOfStock,
        title: "Out of Stock",
        svgSrc: "assets/icons/Product2.svg",
        color: Colors.red,
        count: outOfStockCount,
        percentage: totalProducts > 0 ? (outOfStockCount / totalProducts) * 100 : 0,
      ),
      ProductSummary(
        category: ProductCategory.limitedStock,
        title: "Limited Stock",
        svgSrc: "assets/icons/Product3.svg",
        color: Colors.orange,
        count: limitedStockCount,
        percentage: totalProducts > 0 ? (limitedStockCount / totalProducts) * 100 : 0,
      ),
      ProductSummary(
        category: ProductCategory.otherStock,
        title: "Other Stock",
        svgSrc: "assets/icons/Product4.svg",
        color: Colors.green,
        count: otherStockCount,
        percentage: totalProducts > 0 ? (otherStockCount / totalProducts) * 100 : 0,
      ),
    ];
  }
}


