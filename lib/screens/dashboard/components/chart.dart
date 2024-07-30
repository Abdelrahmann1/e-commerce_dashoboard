// import '../../../core/data/data_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/constants.dart';
//
// class Chart extends StatelessWidget {
//   const Chart({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: Stack(
//         children: [
//           // PieChart(
//           //   PieChartData(
//           //     sectionsSpace: 0,
//           //     centerSpaceRadius: 70,
//           //     startDegreeOffset: -90,
//           //     sections: _buildPieChartSelectionData(context),
//           //   ),
//           // ),
//           Positioned.fill(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: defaultPadding),
//                 Consumer<DataProvider>(
//                   builder: (context, dataProvider, child) {
//                     return Text(
//                       '${0}', //TODO: should complete Make this order number dynamic bt calling calculateOrdersWithStatus
//                       style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         height: 0.5,
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: defaultPadding),
//                 Text("Order")
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // List<PieChartSectionData> _buildPieChartSelectionData(BuildContext context) {
//   //   final DataProvider dataProvider = Provider.of<DataProvider>(context);
//
//   //   //TODO: should complete Make this order number dynamic bt calling calculateOrdersWithStatus
//   //   int totalOrder = 0;
//   //   int pendingOrder = 0;
//   //   int processingOrder = 0;
//   //   int cancelledOrder = 0;
//   //   int shippedOrder = 0;
//   //   int deliveredOrder = 0;
//
//   //   List<PieChartSectionData> pieChartSelectionData = [
//   //     PieChartSectionData(
//   //       color: Color(0xFFFFCF26),
//   //       value: pendingOrder.toDouble(),
//   //       showTitle: false,
//   //       radius: 20,
//   //     ),
//   //     PieChartSectionData(
//   //       color: Color(0xFFEE2727),
//   //       value: cancelledOrder.toDouble(),
//   //       showTitle: false,
//   //       radius: 20,
//   //     ),
//   //     PieChartSectionData(
//   //       color: Color(0xFF2697FF),
//   //       value: shippedOrder.toDouble(),
//   //       showTitle: false,
//   //       radius: 20,
//   //     ),
//   //     PieChartSectionData(
//   //       color: Color(0xFF26FF31),
//   //       value: deliveredOrder.toDouble(),
//   //       showTitle: false,
//   //       radius: 20,
//   //     ),
//   //     PieChartSectionData(
//   //       color: Colors.white,
//   //       value: processingOrder.toDouble(),
//   //       showTitle: false,
//   //       radius: 20,
//   //     ),
//   //   ];
//
//   //   return pieChartSelectionData;
//    }
//

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Getx/Orders/controller.dart';
import '../../../Getx/Orders/enum.dart';
import '../../../utility/constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Positioned.fill(
            child: GetX<AdminOrderController>(
              builder: (controller) {
                final totalOrders = controller.allOrders.length;
                final pendingOrders = controller.allOrders.where((order) => order.status == OrderStatus.pending).length;
                final processingOrders = controller.allOrders.where((order) => order.status == OrderStatus.processing).length;
                final cancelledOrders = controller.allOrders.where((order) => order.status == OrderStatus.cancelled).length;
                final shippedOrders = controller.allOrders.where((order) => order.status == OrderStatus.shipped).length;
                final deliveredOrders = controller.allOrders.where((order) => order.status == OrderStatus.delivered).length;

                return PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 70,
                    startDegreeOffset: -90,
                    sections: _buildPieChartSections(
                      totalOrders: totalOrders,
                      pendingOrders: pendingOrders,
                      processingOrders: processingOrders,
                      cancelledOrders: cancelledOrders,
                      shippedOrders: shippedOrders,
                      deliveredOrders: deliveredOrders,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                GetX<AdminOrderController>(
                  builder: (controller) {
                    return Text(
                      '${controller.allOrders.length}',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                    );
                  },
                ),
                SizedBox(height: defaultPadding),
                Text("Orders")
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections({
    required int totalOrders,
    required int pendingOrders,
    required int processingOrders,
    required int cancelledOrders,
    required int shippedOrders,
    required int deliveredOrders,
  }) {
    return [
      PieChartSectionData(
        color: Color(0xFFFFCF26),
        value: pendingOrders.toDouble(),
        title: '${(pendingOrders / totalOrders * 100).toStringAsFixed(1)}%',
        radius: 20,
      ),
      PieChartSectionData(
        color: Color(0xFFEE2727),
        value: cancelledOrders.toDouble(),
        title: '${(cancelledOrders / totalOrders * 100).toStringAsFixed(1)}%',
        radius: 20,
      ),
      PieChartSectionData(
        color: Color(0xFF2697FF),
        value: shippedOrders.toDouble(),
        title: '${(shippedOrders / totalOrders * 100).toStringAsFixed(1)}%',
        radius: 20,
      ),
      PieChartSectionData(
        color: Color(0xFF26FF31),
        value: deliveredOrders.toDouble(),
        title: '${(deliveredOrders / totalOrders * 100).toStringAsFixed(1)}%',
        radius: 20,
      ),
      PieChartSectionData(
        color: Colors.white,
        value: processingOrders.toDouble(),
        title: '${(processingOrders / totalOrders * 100).toStringAsFixed(1)}%',
        radius: 20,
      ),
    ];
  }
}