// import '../../../core/data/data_provider.dart';
// import 'add_brand_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/color_list.dart';
// import '../../../utility/constants.dart';
// import '../../../models/brand.dart';
//
// class BrandListSection extends StatelessWidget {
//   const BrandListSection({
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
//             "All Brands",
//             style: Theme.of(context).textTheme.titleMedium,
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
//                       label: Text("Brands Name"),
//                     ),
//                     DataColumn(
//                       label: Text("Sub Category"),
//                     ),
//                     DataColumn(
//                       label: Text("Added Date"),
//                     ),
//                     DataColumn(
//                       label: Text("Edit"),
//                     ),
//                     DataColumn(
//                       label: Text("Delete"),
//                     ),
//                   ],
//                   rows: List.generate(
//                     dataProvider.brands.length,
//                     (index) => brandDataRow(dataProvider.brands[index], index + 1, edit: () {
//                       showBrandForm(context, dataProvider.brands[index]);
//                     }, delete: () {
//                       //TODO: should complete deleteBrand
//                     }),
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
// DataRow brandDataRow(Brand brandInfo, int index, {Function? edit, Function? delete}) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Row(
//           children: [
//             Container(
//               height: 24,
//               width: 24,
//               decoration: BoxDecoration(
//                 color: colors[index % colors.length],
//                 shape: BoxShape.circle,
//               ),
//               child: Text(index.toString(), textAlign: TextAlign.center),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(brandInfo.name!),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text(brandInfo.subcategoryId?.name ?? '')),
//       DataCell(Text(brandInfo.createdAt ?? '')),
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



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Getx/Brands/controller.dart';
import '../../../Getx/Brands/model.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import 'add_brand_form.dart';

class BrandListSection extends StatelessWidget {
  const BrandListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdminBrandController controller = Get.find<AdminBrandController>();

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
            "All Brands",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: Obx(() {
              return DataTable(
                columnSpacing: defaultPadding,
                columns: [
                  DataColumn(
                    label: Text("Brand Name"),
                  ),
                  DataColumn(
                    label: Text("Is Featured"),
                  ),
                  DataColumn(
                    label: Text("Products Count"), // New column for Products Count
                  ),
                  DataColumn(
                    label: Text("Edit"),
                  ),
                  DataColumn(
                    label: Text("Delete"),
                  ),
                ],
                rows: List.generate(
                  controller.brands.length,
                      (index) => brandDataRow(controller.brands[index], index + 1,
                      edit: () {
                        showBrandForm(context, controller.brands[index]);
                      }, delete: () {
                        controller.deleteBrand(controller.brands[index].id);
                      }),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

DataRow brandDataRow(BrandModel brandInfo, int index, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                shape: BoxShape.circle,
              ),
              child: Text(index.toString(), textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(brandInfo.name),
            ),
          ],
        ),
      ),
      DataCell(Text(brandInfo.isFeatured.toString())),
      DataCell(Text(brandInfo.productsCount?.toString() ?? '0')), // Display Products Count
      DataCell(IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ))),
      DataCell(IconButton(
          onPressed: () {
            if (delete != null) delete();
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ))),
    ],
  );
}
