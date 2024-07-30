import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Getx/Products/models.dart';
import '../../../Getx/Products/new_controller.dart';

void showUpdateProductForm(BuildContext context, ProductModel product) {
  final titleController = TextEditingController(text: product.title.value);
  final priceController = TextEditingController(text: product.price.value.toString());
  final stockController = TextEditingController(text: product.stock.value.toString());
  final productController = Get.find<NewAdminPanelController>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Product'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: stockController,
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Update'),
            onPressed: () async {
              final updatedFields = <String, dynamic>{};

              if (titleController.text.trim() != product.title.value) {
                updatedFields['Title'] = titleController.text.trim();
              }
              if (double.parse(priceController.text) != product.price.value) {
                updatedFields['Price'] = double.parse(priceController.text);
              }
              if (int.parse(stockController.text) != product.stock.value) {
                updatedFields['Stock'] = int.parse(stockController.text);
              }

              if (updatedFields.isNotEmpty) {
                await productController.updateProduct(product.id, updatedFields);
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}