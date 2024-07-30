// import '../../../core/data/data_provider.dart';
// import 'add_poster_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../models/poster.dart';
// import '../../../utility/constants.dart';
//
//
// class PosterListSection extends StatelessWidget {
//   const PosterListSection({
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
//             "All Posters",
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
//                       label: Text("Edit"),
//                     ),
//                     DataColumn(
//                       label: Text("Delete"),
//                     ),
//                   ],
//                   rows: List.generate(
//                     dataProvider.posters.length,
//                     (index) => posterDataRow(dataProvider.posters[index], delete: () {
//                       //TODO: should complete call deletePoster
//
//                     }, edit: () {
//                       showAddPosterForm(context, dataProvider.posters[index]);
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
// DataRow posterDataRow(Poster poster, {Function? edit, Function? delete}) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Row(
//           children: [
//             Image.network(
//               poster.imageUrl ?? '',
//               height: 30,
//               width: 30,
//               errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//                 return Icon(Icons.error);
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(poster.posterName ?? ''),
//             ),
//           ],
//         ),
//       ),
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

import '../../../Getx/Banners/controller.dart';
import '../../../Getx/Banners/model.dart';
import '../../../utility/constants.dart';
import 'add_poster_form.dart';
//
// class PosterListSection extends StatelessWidget {
//   const PosterListSection({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final AdminBannerController bannerController = Get.put(AdminBannerController());
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
//             "All Posters",
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: Obx(() {
//               return DataTable(
//                 columnSpacing: defaultPadding,
//                 columns: [
//                   DataColumn(
//                     label: Text("Poster Name"),
//                   ),
//                   DataColumn(
//                     label: Text("Edit"),
//                   ),
//                   DataColumn(
//                     label: Text("Delete"),
//                   ),
//                 ],
//                 rows: List.generate(
//                   bannerController.banners.length,
//                       (index) => posterDataRow(
//                     bannerController.banners[index],
//                     delete: () async {
//                       await bannerController.deleteBanner(bannerController.banners[index].id!);
//                     },
//                     edit: () {
//                       showAddPosterForm(context, bannerController.banners[index]);
//                     },
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// DataRow posterDataRow(BannerModel poster, {Function? edit, Function? delete}) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Row(
//           children: [
//             Image.network(
//               poster.imageUrl ?? '',
//               height: 30,
//               width: 30,
//               errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//                 return Icon(Icons.error);
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(poster.targetScreen ?? ''),
//             ),
//           ],
//         ),
//       ),
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


class PosterListSection extends StatelessWidget {
  const PosterListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdminBannerController bannerController = Get.put(AdminBannerController());

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
            "All Posters",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: Obx(() {
              return DataTable(
                columnSpacing: defaultPadding,
                columns: [
                  DataColumn(
                    label: Text("Poster Name"),
                  ),
                  DataColumn(
                    label: Text("Poster ID"),
                  ),
                  DataColumn(
                    label: Text("Active"),
                  ),
                  DataColumn(
                    label: Text("Edit"),
                  ),
                  DataColumn(
                    label: Text("Delete"),
                  ),
                ],
                rows: List.generate(
                  bannerController.banners.length,
                      (index) => posterDataRow(
                    bannerController.banners[index],
                    delete: () async {
                      await bannerController.deleteBanner(bannerController.banners[index].id);
                    },
                    edit: () {
                      showAddPosterForm(context, bannerController.banners[index]);
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

DataRow posterDataRow(BannerModel poster, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.network(
              poster.imageUrl,
              height: 30,
              width: 30,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Icon(Icons.error);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(poster.targetScreen),
            ),
          ],
        ),
      ),
      DataCell(Text(poster.id.toString())),
      DataCell(Text(poster.active.toString())),
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
