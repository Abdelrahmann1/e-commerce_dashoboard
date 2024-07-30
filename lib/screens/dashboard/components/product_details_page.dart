// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../../models/product_summery_info.dart';
// import '../../../utility/constants.dart';
//
// class ProductDetailsPage extends StatelessWidget {
//   final ProductSummeryInfo info;
//
//   const ProductDetailsPage({
//     Key? key,
//     required this.info,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(info.title!),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(defaultPadding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Products Count: ${info.productsCount}',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Percentage: ${info.percentage!.toStringAsFixed(2)}%',
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             const SizedBox(height: 20),
//             SvgPicture.asset(
//               info.svgSrc!,
//               colorFilter: ColorFilter.mode(info.color ?? Colors.black, BlendMode.srcIn),
//               height: 100,
//               width: 100,
//             ),
//             // Add more details about the products or any other relevant information
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:admin/Getx/Products/new_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Getx/Products/models.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductCategory category;

  const ProductDetailsPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewAdminPanelController controller = Get.find();
    final List<ProductModel> categoryProducts = controller.getProductsByCategory(category);

    return Scaffold(
      appBar: AppBar(
        title: Text("${category.toString().split('.').last} Products"),
      ),
      body: ListView.builder(
        itemCount: categoryProducts.length,
        itemBuilder: (context, index) {
          final product = categoryProducts[index];
          return ListTile(
            title: Text(product.title.value),
            subtitle: Text("Stock: ${product.stock.value}"),
            trailing: Text("\$${product.price.value}"),
            onTap: () {
              // Navigate to individual product details if needed
              Get.to(() => IndividualProductDetailsPage(product: product));
            },
          );
        },
      ),
    );
  }
}



class IndividualProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const IndividualProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  _IndividualProductDetailsPageState createState() => _IndividualProductDetailsPageState();
}

class _IndividualProductDetailsPageState extends State<IndividualProductDetailsPage> {
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final averageRating = (product.reviews?.isNotEmpty ?? false)
        ? product.reviews!.map((r) => r.rating).reduce((a, b) => a + b) / product.reviews!.length
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title.value),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product.thumbnail.value,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 200),
                ),
              ),
              SizedBox(height: 20),
              Text(
                product.title.value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Price: \$${product.price.value}",
                    style: TextStyle(fontSize: 20),
                  ),
                  if (product.salePrice.value > 0) ...[
                    SizedBox(width: 10),
                    Text(
                      "Sale Price: \$${product.salePrice.value}",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Stock: ${product.stock.value}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              if (product.brand.value != null) ...[
                Text(
                  "Brand: ${product.brand.value!.name}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
              ],
              Text(
                "Description:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isDescriptionExpanded = !_isDescriptionExpanded;
                  });
                },
                child: Text(
                  product.description?.value ?? 'No description available.',
                  maxLines: _isDescriptionExpanded ? null : 3,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              if (product.description != null && product.description!.value.length > 100)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isDescriptionExpanded = !_isDescriptionExpanded;
                    });
                  },
                  child: Text(_isDescriptionExpanded ? "Show less" : "Show more"),
                ),
              SizedBox(height: 20),
              Text(
                "Category ID: ${product.categoryId?.value ?? 'Not specified'}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              if (product.images != null && product.images!.isNotEmpty) ...[
                Text(
                  "Images",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: product.images!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image.network(
                          product.images![index],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 100),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
              Text(
                "Average Rating: ${averageRating.toStringAsFixed(1)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < averageRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  );
                }),
              ),
              SizedBox(height: 20),
              if (product.reviews != null && product.reviews!.isNotEmpty) ...[
                Text(
                  "Reviews",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ...product.reviews!.map((review) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userFullName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < review.rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          );
                        }),
                      ),
                      SizedBox(height: 5),
                      Text(review.review ?? ''),
                      SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
