
import 'package:admin/screens/dashboard/components/update_product_form.dart';
import 'package:get/get.dart';

import '../../../Getx/Products/models.dart';
import '../../../Getx/Products/new_controller.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/product.dart';
import '../../brands/components/brand_header.dart';
import 'add_product_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
//
// class ProductListSection extends StatelessWidget {
//   const ProductListSection({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "All Products",
//             style: Theme
//                 .of(context)
//                 .textTheme
//                 .titleMedium,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: Consumer<DataProvider>(
//               builder: (context, dataProvider, child) {
//                 return DataTable(
//                   columnSpacing: defaultPadding,
//                   // minWidth: 600,
//                   columns: [
//                     DataColumn(
//                       label: Text("Product Name"),
//                     ),
//                     DataColumn(
//                       label: Text("Category"),
//                     ),
//                     DataColumn(
//                       label: Text("Sub Category"),
//                     ),
//                     DataColumn(
//                       label: Text("Price"),
//                     ),
//                     DataColumn(
//                       label: Text("Edit"),
//                     ),
//                     DataColumn(
//                       label: Text("Delete"),
//                     ),
//                   ],
//                   rows: List.generate(
//                     dataProvider.products.length,
//                         (index) => productDataRow(dataProvider.products[index],edit: () {
//                           showAddProductForm(context, dataProvider.products[index]);
//                         },
//                           delete: () {
//                             //TODO: should complete call deleteProduct
//                           },),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// DataRow productDataRow(Product productInfo,{Function? edit, Function? delete}) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Row(
//           children: [
//             Image.network(
//               productInfo.images?.first.url ?? '',
//               height: 30,
//               width: 30,
//               errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//                 return Icon(Icons.error);
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(productInfo.name ?? ''),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text(productInfo.proCategoryId?.name ?? '')),
//       DataCell(Text(productInfo.proSubCategoryId?.name ?? '')),
//       DataCell(Text('${productInfo.price}'),),
//       DataCell(IconButton(
//           onPressed: () {
//             if (edit != null) edit();
//           },
//           icon: Icon(
//             Icons.edit,
//             color: Colors.white,
//           ))),
//       DataCell(IconButton(
//           onPressed: () {
//             if (delete != null) delete();
//           },
//           icon: Icon(
//             Icons.delete,
//             color: Colors.red,
//           ))),
//     ],
//   );
// }
//


/// #########Getx##################
///
///
///
///
///
///
///
///
///
///



class ProductListSection extends GetView<NewAdminPanelController> {
  const ProductListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Products",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: defaultPadding),
          // SearchField(
          //   onChange: (value) => controller.searchProducts(value),
          // ),
          SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: Obx(() {
              final displayedProducts = controller.filteredSearchResults;
              if (displayedProducts.isEmpty) {
                return Center(child: Text('No products available'));
              } else {
                return DataTable(
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(label: Text("Product Name")),
                    DataColumn(label: Text("Category")),
                    DataColumn(label: Text("Price")),
                    DataColumn(label: Text("Edit")),
                    DataColumn(label: Text("Delete")),
                  ],
                  rows: displayedProducts.map((product) => productDataRow(
                    product,
                    edit: () => showUpdateProductForm(context, product),
                    delete: () => controller.deleteProduct(product.id),
                  )).toList(),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
DataRow productDataRow(ProductModel productInfo, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Obx(() => Image.network(
              productInfo.images?.isNotEmpty == true ? productInfo.images!.first : '',
              height: 30,
              width: 30,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Icon(Icons.error);
              },
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Obx(() => Text(productInfo.title.value)),
            ),
          ],
        ),
      ),
      DataCell(Obx(() => Text(productInfo.categoryId?.value ?? ''))),
      DataCell(Obx(() => Text('${productInfo.price.value}'))),
      DataCell(IconButton(
        onPressed: () => edit?.call(),
        icon: Icon(Icons.edit, color: Colors.white),
      )),
      DataCell(IconButton(
        onPressed: () => delete?.call(),
        icon: Icon(Icons.delete, color: Colors.red),
      )),
    ],
  );
}


///
///
///
///
///
///
///
/// /// #########Getx##################