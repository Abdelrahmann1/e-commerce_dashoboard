import 'package:get/get.dart';

import '../../Getx/Orders/controller.dart';
import '../../Getx/Products/new_controller.dart';
import 'components/dash_board_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import 'components/add_product_form.dart';
import 'components/order_details_section.dart';
import 'components/product_list_section.dart';
import 'components/product_summery_section.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NewAdminPanelController productController = Get.put(NewAdminPanelController());
    Get.put(AdminOrderController());

    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            DashBoardHeader(),
            Gap(defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "My Products",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical: defaultPadding,
                              ),
                            ),
                            onPressed: () {
                              showAddProductForm(context, null);
                            },
                            icon: Icon(Icons.add),
                            label: Text("Add New"),
                          ),
                          SizedBox(width: 20),
                          IconButton(
                            onPressed: () {
                              //TODO: should complete call getAllProduct
                              productController.fetchProducts();
                            },
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      ProductSummarySections(),
                      SizedBox(height: defaultPadding),
                      ProductListSection(),
                    ],
                  ),
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  flex: 2,
                  child: OrderDetailsSection(),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
