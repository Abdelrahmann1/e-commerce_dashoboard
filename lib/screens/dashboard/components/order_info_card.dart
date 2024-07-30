import 'package:admin/Getx/Orders/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Getx/Orders/controller.dart';
import '../../../Getx/Orders/enum.dart';
import '../../../utility/constants.dart';

// class OrderInfoCard extends StatelessWidget {
//   const OrderInfoCard({
//     Key? key,
//     required this.title,
//     required this.svgSrc,
//     required this.totalOrder,
//   }) : super(key: key);
//
//   final String title, svgSrc;
//   final int totalOrder;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: defaultPadding),
//       padding: EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
//         borderRadius: const BorderRadius.all(
//           Radius.circular(defaultPadding),
//         ),
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             height: 20,
//             width: 20,
//             child: SvgPicture.asset(svgSrc),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                     "$totalOrder Files",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodySmall!
//                         .copyWith(color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// class OrderInfoCard extends StatelessWidget {
//   final String title;
//   final int count;
//   final Color color;
//
//   OrderInfoCard({
//     required this.title,
//     required this.count,
//     required this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: color,
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: ListTile(
//         title: Text(title, style: TextStyle(color: Colors.white)),
//         trailing: Text(count.toString(), style: TextStyle(color: Colors.white, fontSize: 24)),
//       ),
//     );
//   }
// }

class OrderInfoCard extends StatelessWidget {
  final String title, svgSrc;
  final int totalOrder;
  final VoidCallback onTap;

  const OrderInfoCard({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.totalOrder,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.blue.withOpacity(0.15)),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(svgSrc),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(
                      "$totalOrder Orders",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderDetailsPage extends GetView<AdminOrderController> {
  final OrderStatus status;

  OrderDetailsPage({required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${status.toString().split('.').last} Orders'),
      ),
      body: Obx(() {
        final orders = status == OrderStatus.all
            ? controller.allOrders
            : controller.allOrders.where((order) => order.status == status).toList();
        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(order.userName!),
              subtitle: Text('Amount: \$${order.totalAmount.toStringAsFixed(2)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(order.status.toString().split('.').last),
                  SizedBox(width: 10),
                  Text(order.orderDate.toString().split(' ')[0]),
                  if (order.deliveryDate != null) ...[
                    SizedBox(width: 10),
                    Text(order.deliveryDate.toString().split(' ')[0]),
                  ],
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Implement edit functionality
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Implement delete functionality
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}