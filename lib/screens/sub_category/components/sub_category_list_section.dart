import '../../../Getx/Sub Categories/controller.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/sub_category.dart';
import 'add_sub_category_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import '../../category/components/add_category_form.dart';


// class SubCategoryListSection extends StatelessWidget {
//   const SubCategoryListSection({
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
//             "All SubCategory",
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
//                       label: Text("SubCategory Name"),
//                     ),
//                     DataColumn(
//                       label: Text("Category"),
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
//                     dataProvider.subCategories.length,
//                     (index) => subCategoryDataRow(
//                       dataProvider.subCategories[index],
//                       index + 1,
//                       edit: () {
//                         showAddSubCategoryForm(context, dataProvider.subCategories[index]);
//                       },
//                       delete: () {
//                         //TODO: should complete call deleteSubCategory
//                       },
//                     ),
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

class SubCategoryListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AdminSubCategoryController controller = Get.find();

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Subcategories",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 16.0),
          Obx(() => DataTable(
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Parent Category')),
              DataColumn(label: Text('Image')),
              DataColumn(label: Text('Is Featured')),
              DataColumn(label: Text('Actions')),
            ],
            rows: controller.subCategories
                .map((subCategory) => DataRow(cells: [
              DataCell(Text(subCategory.id)),
              DataCell(Text(subCategory.name)),
              DataCell(Text(controller.mainCategories.firstWhereOrNull((cat) => cat.id == subCategory.parentId)?.name ?? 'N/A')),
              DataCell(Image.network(subCategory.image, width: 50, height: 50)),
              DataCell(Text(subCategory.isFeatured.toString())),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => showAddSubCategoryForm(context, subCategory),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => controller.deleteSubCategory(subCategory.id),
                  ),
                ],
              )),
            ]))
                .toList(),
          )),
        ],
      ),
    );
  }
}


DataRow subCategoryDataRow(SubCategory subCatInfo, int index, {Function? edit, Function? delete}) {
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
              child: Text(subCatInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(subCatInfo.categoryId?.name ?? '')),
      DataCell(Text(subCatInfo.createdAt ?? '')),
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
