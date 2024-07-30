// import '../../../core/data/data_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/constants.dart';
// import '../../../models/category.dart';
// import 'add_category_form.dart';
//
// class CategoryListSection extends StatelessWidget {
//   const CategoryListSection({
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
//             "All Categories",
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
//                       label: Text("Category Name"),
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
//                     dataProvider.categories.length,
//                     (index) => categoryDataRow(dataProvider.categories[index], delete: () {
//                       //TODO: should complete call  deleteCategory
//                     }, edit: () {
// //showAddCategoryForm(context, dataProvider.categories[index]);
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
// DataRow categoryDataRow(Category CatInfo, {Function? edit, Function? delete}) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Row(
//           children: [
//             Image.network(
//               CatInfo.image ?? '',
//               height: 30,
//               width: 30,
//               errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//                 return Icon(Icons.error);
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(CatInfo.name ?? ''),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text(CatInfo.createdAt ?? '')),
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



import 'package:admin/Getx/Categories/model.dart';
import 'package:admin/screens/category/components/add_category_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Getx/Categories/controller.dart';
import '../../../utility/constants.dart';

/// New
///
///
///
// class CategoryListSection extends StatelessWidget {
//   const CategoryListSection({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final AdminCategoryController categoryController = Get.find<AdminCategoryController>();
//
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
//             "All Categories",
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: Obx(() {
//               if (categoryController.categories.isEmpty) {
//                 return Center(child: Text("No categories available"));
//               } else {
//                 return DataTable(
//                   columnSpacing: defaultPadding,
//                   columns: [
//                     DataColumn(
//                       label: Text("Category Name"),
//                     ),
//                     DataColumn(
//                       label: Text("Id"),
//                     ),
//                     DataColumn(
//                       label: Text("Edit"),
//                     ),
//                     DataColumn(
//                       label: Text("Delete"),
//                     ),
//                   ],
//                   rows: List.generate(
//                     categoryController.categories.length,
//                         (index) => categoryDataRow(
//                       categoryController.categories[index],
//                       delete: () {
//                         // Call deleteCategory method from AdminCategoryController
//                         categoryController.deleteCategory(categoryController.categories[index].id);
//                       },
//                       edit: () {
//                         showAddCategoryForm(context, categoryController.categories[index]);
//                       },
//                     ),
//                   ),
//                 );
//               }
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// DataRow categoryDataRow(CategoryModel catInfo, {Function? edit, Function? delete}) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Row(
//           children: [
//             Image.network(
//               catInfo.image ?? '',
//               height: 30,
//               width: 30,
//               errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//                 return Icon(Icons.error);
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(catInfo.name),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text(catInfo.id ?? '')),
//       DataCell(IconButton(
//         onPressed: () {
//           if (edit != null) edit();
//         },
//         icon: Icon(
//           Icons.edit,
//           color: Colors.white,
//         ),
//       )),
//       DataCell(IconButton(
//         onPressed: () {
//           if (delete != null) delete();
//         },
//         icon: Icon(
//           Icons.delete,
//           color: Colors.red,
//         ),
//       )),
//     ],
//   );
// }


//-----------test----------------

class CategoryListSection extends StatelessWidget {
  const CategoryListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdminCategoryController categoryController = Get.find<AdminCategoryController>();

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
            "All Categories",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: Obx(() {
              if (categoryController.categories.isEmpty) {
                return Center(child: Text("No categories found"));
              } else {
                return DataTable(
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text("Category Name"),
                    ),
                    DataColumn(
                      label: Text("Id"),
                    ),
                    DataColumn(
                      label: Text("Edit"),
                    ),
                    DataColumn(
                      label: Text("Delete"),
                    ),
                  ],
                  rows: List.generate(
                    categoryController.categories.length,
                        (index) => categoryDataRow(
                      categoryController.categories[index],
                      delete: () {
                        categoryController.deleteCategory(categoryController.categories[index].id);
                      },
                      edit: () {
                        showAddCategoryForm(context, categoryController.categories[index]);
                      },
                    ),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

DataRow categoryDataRow(CategoryModel catInfo, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.network(
              catInfo.image ?? '',
              height: 30,
              width: 30,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Icon(Icons.error);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(catInfo.name),
            ),
          ],
        ),
      ),
      DataCell(Text(catInfo.id ?? '')),
      DataCell(IconButton(
        onPressed: () {
          if (edit != null) edit();
        },
        icon: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      )),
      DataCell(IconButton(
        onPressed: () {
          if (delete != null) delete();
        },
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      )),
    ],
  );
}
