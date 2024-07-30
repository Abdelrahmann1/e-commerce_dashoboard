

import 'package:admin/Getx/Products/new_controller.dart';
import 'package:admin/utility/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../../../Getx/Products/models.dart';
import '../../../widgets/custom_text_field.dart';

class ColorOption {
  final String name;
  final Color color;

  ColorOption(this.name, this.color);
}

class ColorManagementSystem extends GetxController {
  static ColorManagementSystem get instance => Get.find();
  RxList<ColorOption> availableColors = <ColorOption>[].obs;

  void addColor(String name, Color color) {
    availableColors.add(ColorOption(name, color));
  }

  void removeColor(ColorOption colorOption) {
    availableColors.remove(colorOption);
  }
}
class NewProductAttributeForm extends StatelessWidget {
  final NewAdminPanelController controller = Get.find<NewAdminPanelController>();
  final ColorManagementSystem colorSystem = Get.find<ColorManagementSystem>();

  NewProductAttributeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: controller.selectedAttributeType.value,
          hint: const Text('Select attribute type'),
          onChanged: controller.setAttributeType,
          items: ['Color', 'Size'].map((attribute) {
            return DropdownMenuItem<String>(
              value: attribute,
              child: Text(attribute),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: 'Attribute Type',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
        Obx(() {
          if (controller.selectedAttributeType.value == 'Color') {
            return _buildColorSelector();
          } else if (controller.selectedAttributeType.value == 'Size') {
            return _buildSizeInput();
          } else {
            return const SizedBox.shrink();
          }
        }),
        SizedBox(height: defaultPadding/2),
        ElevatedButton(
          onPressed: controller.addAttributess,
          child: const Text('Add Attribute'),
        ),
        SizedBox(height: defaultPadding),
        Obx(() => ListView.builder(
          shrinkWrap: true,
          itemCount: controller.productAttributes.length,
          itemBuilder: (context, index) {
            var attribute = controller.productAttributes[index];
            return AttributeListTile(attribute: attribute);
          },
        )),
      ],
    );
  }

  Widget _buildColorSelector() {
    return Column(
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: colorSystem.availableColors.map((colorOption) {
            return Obx(() => FilterChip(
              label: Text(colorOption.name),
              selected: controller.selectedColorsss.contains(colorOption.name),
              onSelected: (selected) {
                if (selected) {
                  controller.selectedColorsss.add(colorOption.name);
                } else {
                  controller.selectedColorsss.remove(colorOption.name);
                }
              },
              avatar: CircleAvatar(backgroundColor: colorOption.color),
            ));
          }).toList(),
        ),
        const SizedBox(height: 10),
        Text('Selected colors: ${controller.selectedColorsss.join(", ")}'),
      ],
    );
  }

  Widget _buildSizeInput() {
    return Column(
      children: [
        CustomTextField(
          controller: controller.sizeInputControllerss,
          labelText: 'Enter Size',
          inputType: TextInputType.text,
          onSave: (val) {},
        ),
        ElevatedButton(
          onPressed: () {
            if (controller.sizeInputControllerss.text.isNotEmpty) {
              controller.selectedSizesss.add(controller.sizeInputControllerss.text);
              controller.sizeInputControllerss.clear();
            }
          },
          child: const Text('Add Size'),
        ),
        const SizedBox(height: 10),
        Obx(() => Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: controller.selectedSizesss.map((size) {
            return Chip(
              label: Text(size),
              onDeleted: () => controller.selectedSizesss.remove(size),
            );
          }).toList(),
        )),
      ],
    );
  }
}


class AttributeListTile extends StatelessWidget {
  final ProductAttributeModel attribute;

  AttributeListTile({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewAdminPanelController controller = Get.put(NewAdminPanelController());

    return ExpansionTile(
      title: Text(attribute.name!.capitalizeFirst!),
      children: [
        ...attribute.values!.map((value) => ListTile(title: Text(value))),
        TextButton(
          onPressed: () => controller.removeAttribute(attribute),
          child: const Text('Remove Attribute'),
        ),
      ],
    );
  }
}


class NewProductVariationForm extends GetView<NewAdminPanelController> {
  NewProductVariationForm({super.key});

  @override
  final NewAdminPanelController controller = Get.put(NewAdminPanelController());
  final ColorManagementSystem colorSystem = Get.put(ColorManagementSystem());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          labelText: 'Variation ID (optional)',
          controller: controller.variationIdController,
          onSave: (value) {
            // Save logic for variation ID
          },
        ),
        CustomTextField(
          labelText: 'Stock',
          controller: controller.variationStockController,
          inputType: TextInputType.number,
          onSave: (value) {
            // Save logic for stock
          },
        ),
        CustomTextField(
          labelText: 'Price',
          controller: controller.variationPriceController,
          inputType: const TextInputType.numberWithOptions(decimal: true),
          onSave: (value) {
            // Save logic for price
          },
        ),
        CustomTextField(
          labelText: 'Sale Price',
          controller: controller.variationSalePriceController,
          inputType: const TextInputType.numberWithOptions(decimal: true),
          onSave: (value) {
            // Save logic for sale price
          },
        ),
        CustomTextField(
          labelText: 'Description',
          controller: controller.variationDescriptionController,
          onSave: (value) {
            // Save logic for description
          },
        ),
        CustomTextField(
          labelText: 'SKU',
          controller: controller.variationSkuController,
          onSave: (value) {
            // Save logic for SKU
          },
        ),
        ElevatedButton(
          onPressed: () => _showColorManagementDialog(context),
          child: const Text('Manage Colors'),
        ),
        SizedBox(height: defaultPadding/2),
        Obx(() => _buildAttributeSelectors()),
        SizedBox(height: defaultPadding),

        ElevatedButton(
          onPressed: controller.addVariation,
          child: const Text('Add Variation'),
        ),
        Obx(() => ListView.builder(
          shrinkWrap: true,
          itemCount: controller.productVariations.length,
          itemBuilder: (context, index) {
            var variation = controller.productVariations[index];
            return VariationListTile(variation: variation);
          },
        )),
      ],
    );
  }

  Widget _buildAttributeSelectors() {
    return Column(
      children: controller.productAttributes.map((attribute) {
        if (attribute.name == 'Color') {
          return _buildColorSelector(attribute);
        } else if (attribute.name == 'Size') {
          return _buildSizeSelector(attribute);
        }
        return const SizedBox.shrink();
      }).toList(),
    );
  }

  Widget _buildColorSelector(ProductAttributeModel attribute) {
    return Obx(() => Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: attribute.values != null
          ? attribute.values!.map((colorName) {
        final isSelected = controller.selectedColorsss != null &&
            controller.selectedColorsss.contains(colorName);
        final colorOption = colorSystem.availableColors.firstWhere(
              (c) => c.name == colorName,
          orElse: () => ColorOption(colorName, Colors.grey),
        );
        return FilterChip(
          label: Text(colorName),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              if (controller.selectedColorsss != null) {
                controller.selectedColorsss!
                    .add(colorName.capitalizeFirst!);
              }
            } else {
              if (controller.selectedColorsss != null) {
                controller.selectedColorsss!.remove(colorName);
              }
            }
          },
          avatar: CircleAvatar(backgroundColor: colorOption.color),
        );
      }).toList()
          : [],
    ));
  }

  Widget _buildSizeSelector(ProductAttributeModel attribute) {
    return Obx(() => Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: attribute.values != null
          ? attribute.values!.map((size) {
        final isSelected = controller.selectedSizesss != null &&
            controller.selectedSizesss.contains(size);
        return FilterChip(
          label: Text(size),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              if (controller.selectedSizesss != null) {
                controller.selectedSizesss!.add(size);
              }
            } else {
              if (controller.selectedSizesss != null) {
                controller.selectedSizesss!.remove(size);
              }
            }
          },
        );
      }).toList()
          : [],
    ));
  }

  void _showColorManagementDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Manage Colors'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => _addNewColor(context),
                  child: const Text('Add New Color'),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Obx(() {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: colorSystem.availableColors.length,
                      itemBuilder: (context, index) {
                        final colorOption = colorSystem.availableColors[index];
                        return ListTile(
                          leading: Container(
                            width: 20,
                            height: 20,
                            color: colorOption.color,
                          ),
                          title: Text(colorOption.name),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                colorSystem.removeColor(colorOption),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _addNewColor(BuildContext context) {
    final colorNameController = TextEditingController();
    Color selectedColor = Colors.white;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Color'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: colorNameController,
                decoration: const InputDecoration(labelText: 'Color Name'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final Color? pickedColor = await showDialog<Color>(
                    context: context,
                    builder: (context) {
                      Color tempColor = selectedColor;
                      return AlertDialog(
                        title: const Text('Pick a color'),
                        content: SingleChildScrollView(
                          child: BlockPicker(
                            pickerColor: tempColor,
                            onColorChanged: (Color color) {
                              tempColor = color;
                            },
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: const Text('Select'),
                            onPressed: () =>
                                Navigator.of(context).pop(tempColor),
                          ),
                        ],
                      );
                    },
                  );

                  if (pickedColor != null) {
                    selectedColor = pickedColor;
                  }
                },
                child: const Text('Pick Color'),
              ),
              const SizedBox(height: 10),
              Container(
                width: 50,
                height: 50,
                color: selectedColor,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Add Color'),
              onPressed: () {
                if (colorNameController.text.isNotEmpty) {
                  colorSystem.addColor(
                      colorNameController.text.capitalizeFirst!, selectedColor);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}


// class NewProductVariationForm extends GetView<NewAdminPanelController> {
//   NewProductVariationForm({super.key});
//
//   @override
//   final NewAdminPanelController controller = Get.put(NewAdminPanelController());
//   final ColorManagementSystem colorSystem = Get.put(ColorManagementSystem());
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: controller.variationIdController,
//           decoration:
//           const InputDecoration(labelText: 'Variation ID (optional)'),
//         ),
//         TextField(
//           controller: controller.variationStockController,
//           decoration: const InputDecoration(labelText: 'Stock'),
//           keyboardType: TextInputType.number,
//         ),
//         TextField(
//           controller: controller.variationPriceController,
//           decoration: const InputDecoration(labelText: 'Price'),
//           keyboardType: const TextInputType.numberWithOptions(decimal: true),
//         ),
//         TextField(
//           controller: controller.variationSalePriceController,
//           decoration: const InputDecoration(labelText: 'Sale Price'),
//           keyboardType: const TextInputType.numberWithOptions(decimal: true),
//         ),
//         TextField(
//           controller: controller.variationDescriptionController,
//           decoration: const InputDecoration(labelText: 'Description'),
//         ),
//         TextField(
//           controller: controller.variationSkuController,
//           decoration: const InputDecoration(labelText: 'SKU'),
//         ),
//         ElevatedButton(
//           onPressed: () => _showColorManagementDialog(context),
//           child: const Text('Manage Colors'),
//         ),
//         Obx(() => _buildAttributeSelectors()),
//         ElevatedButton(
//           onPressed: controller.addVariation,
//           child: const Text('Add Variation'),
//         ),
//         Obx(() => ListView.builder(
//           shrinkWrap: true,
//           itemCount: controller.productVariations.length,
//           itemBuilder: (context, index) {
//             var variation = controller.productVariations[index];
//             return VariationListTile(variation: variation);
//           },
//         )),
//       ],
//     );
//   }
//
//
//   Widget _buildAttributeSelectors() {
//     return Column(
//       children: controller.productAttributes.map((attribute) {
//         if (attribute.name == 'Color') {
//           return  _buildColorSelector(attribute);
//         } else if (attribute.name == 'Size') {
//           return  _buildSizeSelector(attribute);
//         }
//         return const SizedBox.shrink();
//       }).toList(),
//     );
//   }
//
//   Widget _buildColorSelector(ProductAttributeModel attribute) {
//     return Obx(() => Wrap(
//       spacing: 8.0,
//       runSpacing: 8.0,
//       children: attribute.values != null
//           ? attribute.values!.map((colorName) {
//         final isSelected = controller.selectedColorsss != null &&
//             controller.selectedColorsss.contains(colorName);
//         final colorOption = colorSystem.availableColors.firstWhere(
//               (c) => c.name == colorName,
//           orElse: () => ColorOption(colorName, Colors.grey),
//         );
//         return FilterChip(
//           label: Text(colorName),
//           selected: isSelected,
//           onSelected: (selected) {
//             if (selected) {
//               if (controller.selectedColorsss != null) {
//                 controller.selectedColorsss!.add(colorName.capitalizeFirst!);
//               }
//             } else {
//               if (controller.selectedColorsss != null) {
//                 controller.selectedColorsss!.remove(colorName);
//               }
//             }
//           },
//           avatar: CircleAvatar(backgroundColor: colorOption.color),
//         );
//       }).toList()
//           : [],
//     ));
//   }
//
//   Widget _buildSizeSelector(ProductAttributeModel attribute) {
//     return Obx(() => Wrap(
//       spacing: 8.0,
//       runSpacing: 8.0,
//       children: attribute.values != null
//           ? attribute.values!.map((size) {
//         final isSelected = controller.selectedSizesss != null &&
//             controller.selectedSizesss.contains(size);
//         return FilterChip(
//           label: Text(size),
//           selected: isSelected,
//           onSelected: (selected) {
//             if (selected) {
//               if (controller.selectedSizesss != null) {
//                 controller.selectedSizesss!.add(size);
//               }
//             } else {
//               if (controller.selectedSizesss != null) {
//                 controller.selectedSizesss!.remove(size);
//               }
//             }
//           },
//         );
//       }).toList()
//           : [],
//     ));
//   }
//
//   void _showColorManagementDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Manage Colors'),
//           content: SizedBox(
//             width: double.maxFinite,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => _addNewColor(context),
//                   child: const Text('Add New Color'),
//                 ),
//                 const SizedBox(height: 10),
//                 Flexible(
//                   child: Obx(() {
//                     return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: colorSystem.availableColors.length,
//                       itemBuilder: (context, index) {
//                         final colorOption = colorSystem.availableColors[index];
//                         return ListTile(
//                           leading: Container(
//                             width: 20,
//                             height: 20,
//                             color: colorOption.color,
//                           ),
//                           title: Text(colorOption.name),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () =>
//                                 colorSystem.removeColor(colorOption),
//                           ),
//                         );
//                       },
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Close'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _addNewColor(BuildContext context) {
//     final colorNameController = TextEditingController();
//     Color selectedColor = Colors.white;
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add New Color'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: colorNameController,
//                 decoration: const InputDecoration(labelText: 'Color Name'),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   final Color? pickedColor = await showDialog<Color>(
//                     context: context,
//                     builder: (context) {
//                       Color tempColor = selectedColor;
//                       return AlertDialog(
//                         title: const Text('Pick a color'),
//                         content: SingleChildScrollView(
//                           child: BlockPicker(
//                             pickerColor: tempColor,
//                             onColorChanged: (Color color) {
//                               tempColor = color;
//                             },
//                           ),
//                         ),
//                         actions: <Widget>[
//                           TextButton(
//                             child: const Text('Cancel'),
//                             onPressed: () => Navigator.of(context).pop(),
//                           ),
//                           TextButton(
//                             child: const Text('Select'),
//                             onPressed: () =>
//                                 Navigator.of(context).pop(tempColor),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//
//                   if (pickedColor != null) {
//                     selectedColor = pickedColor;
//                   }
//                 },
//                 child: const Text('Pick Color'),
//               ),
//               const SizedBox(height: 10),
//               Container(
//                 width: 50,
//                 height: 50,
//                 color: selectedColor,
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             TextButton(
//               child: const Text('Add Color'),
//               onPressed: () {
//                 if (colorNameController.text.isNotEmpty) {
//                   colorSystem.addColor(colorNameController.text.capitalizeFirst!, selectedColor);
//                   Navigator.of(context).pop();
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

class VariationListTile extends StatelessWidget {
  final ProductVariationModel variation;
  final NewAdminPanelController controller = Get.put(NewAdminPanelController());

  VariationListTile({Key? key, required this.variation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Variation ${controller.productVariations.indexOf(variation) + 1}'),
      children: [
        Obx(() {
          final imageBytes = controller.variationImages[variation.id];

          if (imageBytes != null) {
            return Image.memory(
              imageBytes,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            );
          } else if (variation.image != null && variation.image!.isNotEmpty) {
            return Stack(
              children: [
                Image.network(variation.image!, height: 100, width: 100, fit: BoxFit.cover),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      controller.variationImages.remove(variation.id);
                      controller.update(); // Ensure UI updates
                    },
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox(height: 100, width: 100, child: Icon(Icons.camera_alt));
          }
        }),
        ElevatedButton(
          onPressed: () => controller.selectVariationImage(variation.id),
          child: const Text('Select Image'),
        ),
        Text('Colors: ${variation.attributeValues['Color'] ?? "N/A"}'),
        Text('Size: ${variation.attributeValues['Size'] ?? "N/A"}'),
        Text('Stock: ${variation.stock}'),
        Text('Price: ${variation.price}'),
        Text('Sale Price: ${variation.salePrice}'),
        Text('Description: ${variation.description ?? "N/A"}'),
        Text('SKU: ${variation.sku ?? "N/A"}'),
        TextButton(
          onPressed: () => controller.removeVariation(variation),
          child: const Text('Remove Variation'),
        ),
      ],
    );
  }
}
