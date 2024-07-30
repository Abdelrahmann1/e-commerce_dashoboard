import 'package:get/get.dart';

import '../../Getx/Orders/controller.dart';
import '../../Getx/Orders/enum.dart';
import 'components/order_header.dart';
import 'components/order_list_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import '../../widgets/custom_dropdown.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminOrderController());
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            OrderHeader(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              "My Orders",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium,
                            ),
                          ),
                          Gap(20),
                          SizedBox(
                            width: 280,
                            child: _buildFilterDropdowns(controller),

                          ),
                          Gap(40),
                          IconButton(
                              onPressed: () {
                                //TODO: should complete call getAllOrders
                                //controller.fetchOrders();
                                controller.refreshOrders();
                              },
                              icon: Icon(Icons.refresh)),
                        ],
                      ),
                      Gap(defaultPadding),
                      OrderListSection(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(AdminOrderController controller) {
    return Obx(() =>
        DropdownButton<OrderStatus?>(
          value: controller.selectedFilter.value,
          hint: Text('Filter by Status'),
          onChanged: (OrderStatus? newValue) {
            controller.setFilter(newValue!);
          },
          items: [
            DropdownMenuItem<OrderStatus?>(
              value: null,
              child: Text('All'),
            ),
            ...OrderStatus.values.map((OrderStatus status) {
              return DropdownMenuItem<OrderStatus?>(
                value: status,
                child: Text(status
                    .toString()
                    .split('.')
                    .last),
              );
            }).toList(),
          ],
        ));
  }

  Widget _buildFilterDropdowns(AdminOrderController controller) {
    return Obx(() {
      return
        NewCustomDropdown<OrderStatus>(
          initialValue: controller.selectedFilter.value,
          items: OrderStatus.values,
          onChanged: (OrderStatus? newValue) {
            controller.setFilter(newValue!);
          },
          hintText: 'Filter by Status',
          displayItem: (OrderStatus status) =>
          status == OrderStatus.all ? 'All' : status.toString().split('.').last,
        );
    });
  }

}


// Custom Dropdown widget
class NewCustomDropdown<T> extends StatelessWidget {
  final T? initialValue;
  final List<T> items;
  final void Function(T?) onChanged;
  final String hintText;
  final String Function(T) displayItem;

  const NewCustomDropdown({
    Key? key,
    this.initialValue,
    required this.items,
    required this.onChanged,
    this.hintText = 'Select an option',
    required this.displayItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = items
        .where((item) => item == initialValue)
        .length;
    assert(count <= 1,
    'There should be exactly one item with value: $initialValue');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          labelText: hintText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        value: initialValue,
        items: items.map((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(displayItem(value)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
