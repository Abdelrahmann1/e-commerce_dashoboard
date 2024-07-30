// import '../../../core/data/data_provider.dart';
// import 'view_order_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/color_list.dart';
// import '../../../models/order.dart';
// import '../../../utility/constants.dart';
//
//
// class OrderListSection extends StatelessWidget {
//   const OrderListSection({
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
//             "All Order",
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
//                       label: Text("Customer Name"),
//                     ),
//                     DataColumn(
//                       label: Text("Order Amount"),
//                     ),
//                     DataColumn(
//                       label: Text("Payment"),
//                     ),
//                     DataColumn(
//                       label: Text("Status"),
//                     ),
//                     DataColumn(
//                       label: Text("Date"),
//                     ),
//                     DataColumn(
//                       label: Text("Edit"),
//                     ),
//                     DataColumn(
//                       label: Text("Delete"),
//                     ),
//                   ],
//                   rows: List.generate(
//                     dataProvider.orders.length,
//                     (index) => orderDataRow(dataProvider.orders[index],index+1, delete: () {
//                       //TODO: should complete call deleteOrder
//                     }, edit: () {
//                       showOrderForm(context, dataProvider.orders[index]);
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
// DataRow orderDataRow(Order orderInfo, int index, {Function? edit, Function? delete}) {
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
//               child: Text(orderInfo.userID?.name ?? ''),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text('${orderInfo.orderTotal?.total}')),
//       DataCell(Text(orderInfo.paymentMethod ?? '')),
//       DataCell(Text(orderInfo.orderStatus ?? '')),
//       DataCell(Text(orderInfo.orderDate ?? '')),
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
// import 'package:admin/screens/order/components/view_order_form.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../Getx/Orders/controller.dart';
// import '../../../Getx/Orders/model.dart';
// import '../../../utility/color_list.dart';
// import '../../../utility/constants.dart';
//
//
// class OrderListSection extends StatelessWidget {
//   const OrderListSection({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final AdminOrderController controller = Get.put(AdminOrderController());
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
//             "All Orders",
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (controller.errorMessage.isNotEmpty) {
//                 return Center(child: Text(controller.errorMessage.value));
//               } else {
//                 return DataTable(
//                   columnSpacing: defaultPadding,
//                   columns: [
//                     DataColumn(label: Text("Customer Name")),
//                     DataColumn(label: Text("Order Amount")),
//                     DataColumn(label: Text("Payment")),
//                     DataColumn(label: Text("Status")),
//                     DataColumn(label: Text("Date")),
//                     DataColumn(label: Text("Edit")),
//                     DataColumn(label: Text("Delete")),
//                   ],
//                   rows: List.generate(
//                     controller.orders.length,
//                         (index) => orderDataRow(controller.orders[index], index + 1,
//                       edit: () => showOrderForm(context, controller.orders[index]),
//                       delete: () => controller.deleteOrder(controller.orders[index].userId!, controller.orders[index].id!),
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
// DataRow orderDataRow(OrderModel orderInfo, int index, {Function? edit, Function? delete}) {
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
//               child: Text(orderInfo.userName ?? ''),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text('${orderInfo.totalAmount}')),
//       DataCell(Text(orderInfo.paymentMethod ?? '')),
//       DataCell(Text(orderInfo.status.toString())),
//       DataCell(Text(orderInfo.orderDate?.toString() ?? '')),
//       DataCell(IconButton(
//         onPressed: () {
//           if (edit != null) edit();
//         },
//         icon: Icon(Icons.edit, color: Colors.white),
//       )),
//       DataCell(IconButton(
//         onPressed: () {
//           if (delete != null) delete();
//         },
//         icon: Icon(Icons.delete, color: Colors.red),
//       )),
//     ],
//   );
// }


import 'package:admin/screens/order/components/view_order_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Getx/Orders/controller.dart';
import '../../../Getx/Orders/enum.dart';
import '../../../Getx/Orders/model.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';


class OrderListSection extends StatelessWidget {
  const OrderListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdminOrderController controller = Get.find<AdminOrderController>();

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "All Orders",
                style: Theme.of(context).textTheme.titleMedium,
              ),
           //   _buildFilterDropdown(controller),
            ],
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              } else {
                return DataTable(
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(label: Text("Customer Name")),
                    DataColumn(label: Text("Order Amount")),
                    DataColumn(label: Text("Payment")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("Delivery Date")),
                    DataColumn(label: Text("Edit")),
                    DataColumn(label: Text("Delete")),
                  ],
                  rows: List.generate(
                    controller.filteredOrders.length,
                        (index) => orderDataRow(controller.filteredOrders[index], index + 1,
                      edit: () => showOrderForm(context, controller.filteredOrders[index]),
                      delete: () => controller.deleteOrder(controller.filteredOrders[index].userId!, controller.filteredOrders[index].id!),
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

DataRow orderDataRow(OrderModel orderInfo, int index, {Function? edit, Function? delete}) {
  bool showDeliveryDate = orderInfo.status == OrderStatus.delivered;

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
              child: Text(orderInfo.userName ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text('${orderInfo.totalAmount}')),
      DataCell(Text(orderInfo.paymentMethod ?? '')),
      DataCell(Text(
        orderInfo.status.toString().split('.').last,
        style: TextStyle(color: getStatusColor(orderInfo.status)),
      )),
      //DataCell(Text(orderInfo.status.toString().split('.').last)),
      DataCell(Text(orderInfo.formattedOrderDate?.toString().tr ?? '')),
      DataCell(showDeliveryDate ? Text(orderInfo.formattedDeliveryDate?.toString().trim() ?? '') : Container()),

      //DataCell(Text(orderInfo.formattedDeliveryDate?.toString().trim() ?? '')),
      DataCell(IconButton(
        onPressed: () {
          if (edit != null) edit();
        },
        icon: Icon(Icons.edit, color: Colors.white),
      )),
      DataCell(IconButton(
        onPressed: () {
          if (delete != null) delete();
        },
        icon: Icon(Icons.delete, color: Colors.red),
      )),
    ],
  );
}


Color getStatusColor(OrderStatus status) {
  switch (status) {
    case OrderStatus.delivered:
      return Colors.green;
    case OrderStatus.cancelled:
      return Colors.red;
    case OrderStatus.pending:
      return Colors.orange;
    case OrderStatus.processing:
      return Colors.blue;
    case OrderStatus.shipped:
      return Colors.purple;
  // Add more cases as needed for other statuses
    default:
      return Colors.black;
  }
}
