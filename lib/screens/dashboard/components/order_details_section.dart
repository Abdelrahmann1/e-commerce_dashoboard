import 'package:admin/Getx/Orders/model.dart';
import 'package:admin/models/order.dart';
import 'package:get/get.dart';

import '../../../Getx/Orders/controller.dart';
import '../../../Getx/Orders/enum.dart';
import '../../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import 'chart.dart';
import 'order_info_card.dart';

import 'package:flutter/material.dart';


class OrderDetailsSection extends GetView<AdminOrderController> {
  const OrderDetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final counts = controller.calculateOrdersWithStatus();
      return Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color:secondaryColor,  //Colors.blueGrey[900],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Orders Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16.0),
            ...OrderStatus.values.map((status) => OrderInfoCard(
              svgSrc: _getIconForStatus(status),
              title: _getTitleForStatus(status),
              totalOrder: counts[status] ?? 0,
              onTap: () => Get.to(() => OrderDetailsPage(status: status)),
            )),
          ],
        ),
      );
    });
  }

  String _getIconForStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.all:
        return "assets/icons/delivery1.svg";
      case OrderStatus.pending:
        return "assets/icons/delivery5.svg";
      case OrderStatus.processing:
        return "assets/icons/delivery6.svg";
      case OrderStatus.shipped:
        return "assets/icons/delivery4.svg";
      case OrderStatus.delivered:
        return "assets/icons/delivery3.svg";
      case OrderStatus.cancelled:
        return "assets/icons/delivery2.svg";
    }
  }

  String _getTitleForStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.all:
        return "All Orders";
      case OrderStatus.pending:
        return "Pending Orders";
      case OrderStatus.processing:
        return "Processed Orders";
      case OrderStatus.shipped:
        return "Shipped Orders";
      case OrderStatus.delivered:
        return "Delivered Orders";
      case OrderStatus.cancelled:
        return "Cancelled Orders";
    }
  }
}

// class OrderDetailsSection extends StatelessWidget {
//   final AdminOrderController controller = Get.find<AdminOrderController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return Center(child: CircularProgressIndicator());
//       }
//
//       if (controller.errorMessage.value.isNotEmpty) {
//         return Center(child: Text(controller.errorMessage.value));
//       }
//
//       var orderCounts = controller.getOrderCounts();
//
//       return ListView(
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         children: [
//           OrderInfoCard(
//             title: 'Pending Orders',
//             count: orderCounts[OrderStatus.pending] ?? 0,
//             color: Colors.blue,
//           ),
//           OrderInfoCard(
//             title: 'Processing Orders',
//             count: orderCounts[OrderStatus.processing] ?? 0,
//             color: Colors.orange,
//           ),
//           OrderInfoCard(
//             title: 'Shipped Orders',
//             count: orderCounts[OrderStatus.shipped] ?? 0,
//             color: Colors.yellow,
//           ),
//           OrderInfoCard(
//             title: 'Delivered Orders',
//             count: orderCounts[OrderStatus.delivered] ?? 0,
//             color: Colors.green,
//           ),
//           OrderInfoCard(
//             title: 'Cancelled Orders',
//             count: orderCounts[OrderStatus.cancelled] ?? 0,
//             color: Colors.red,
//           ),
//         ],
//       );
//     });
//   }
// }


// class OrderDetailsSection extends StatelessWidget {
//   const OrderDetailsSection({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AdminOrderController>(
//       init: AdminOrderController(), // Ensure AdminOrderController is initialized
//       builder: (controller) {
//         // Calculate order counts based on the filtered list
//         int totalOrder = controller.filteredOrders.length;
//         int pendingOrder = controller.filteredOrders.where((order) => order.status == OrderStatus.pending).length;
//         int processingOrder = controller.filteredOrders.where((order) => order.status == OrderStatus.processing).length;
//         int cancelledOrder = controller.filteredOrders.where((order) => order.status == OrderStatus.cancelled).length;
//         int shippedOrder = controller.filteredOrders.where((order) => order.status == OrderStatus.shipped).length;
//         int deliveredOrder = controller.filteredOrders.where((order) => order.status == OrderStatus.delivered).length;
//
//         return Container(
//           padding: EdgeInsets.all(defaultPadding),
//           decoration: BoxDecoration(
//             color: secondaryColor,
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Orders Details",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(height: defaultPadding),
//               Chart(), // Ensure Chart is implemented and used correctly
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery1.svg",
//                 title: "All Orders",
//                 totalOrder: totalOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery5.svg",
//                 title: "Pending Orders",
//                 totalOrder: pendingOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery6.svg",
//                 title: "Processed Orders",
//                 totalOrder: processingOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery2.svg",
//                 title: "Cancelled Orders",
//                 totalOrder: cancelledOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery4.svg",
//                 title: "Shipped Orders",
//                 totalOrder: shippedOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery3.svg",
//                 title: "Delivered Orders",
//                 totalOrder: deliveredOrder,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class OrderDetailsSection extends StatelessWidget {
//   const OrderDetailsSection({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DataProvider>(
//       builder: (context, dataProvider, child) {
//         //TODO: should complete Make this order number dynamic bt calling calculateOrdersWithStatus
//         int totalOrder = 0;
//         int pendingOrder = 0;
//         int processingOrder = 0;
//         int cancelledOrder = 0;
//         int shippedOrder = 0;
//         int deliveredOrder = 0;
//         return Container(
//           padding: EdgeInsets.all(defaultPadding),
//           decoration: BoxDecoration(
//             color: secondaryColor,
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Orders Details",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(height: defaultPadding),
//               Chart(),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery1.svg",
//                 title: "All Orders",
//                 totalOrder: totalOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery5.svg",
//                 title: "Pending Orders",
//                 totalOrder: pendingOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery6.svg",
//                 title: "Processed Orders",
//                 totalOrder: processingOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery2.svg",
//                 title: "Cancelled Orders",
//                 totalOrder: cancelledOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery4.svg",
//                 title: "Shipped Orders",
//                 totalOrder: shippedOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery3.svg",
//                 title: "Delivered Orders",
//                 totalOrder: deliveredOrder,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
