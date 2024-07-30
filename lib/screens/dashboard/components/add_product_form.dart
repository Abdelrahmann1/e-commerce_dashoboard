//
// import '../../../models/brand.dart';
// import '../../../models/category.dart';
// import '../../../models/product.dart';
// import '../../../models/sub_category.dart';
// import '../../../models/variant_type.dart';
// import '../provider/dash_board_provider.dart';
// import '../../../utility/extensions.dart';
// import '../../../widgets/multi_select_drop_down.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/constants.dart';
// import '../../../widgets/custom_dropdown.dart';
// import '../../../widgets/custom_text_field.dart';
// import '../../../widgets/product_image_card.dart';
//
// class ProductSubmitForm extends StatelessWidget {
//
//
//   final Product? product;
//
//   const ProductSubmitForm({super.key, this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     context.dashBoardProvider.setDataForUpdateProduct(product);
//     return SingleChildScrollView(
//       child: Form(
//         key: context.dashBoardProvider.addProductFormKey,
//         child: Container(
//           width: size.width * 0.7,
//           padding: EdgeInsets.all(defaultPadding),
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(height: defaultPadding),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return ProductImageCard(
//                         labelText: 'Main Image',
//                         imageFile: dashProvider.selectedMainImage,
//                         imageUrlForUpdateImage: product?.images.safeElementAt(0)?.url,
//                         onTap: () {
//                           dashProvider.pickImage(imageCardNumber: 1);
//                         },
//                         onRemoveImage: () {
//                           dashProvider.selectedMainImage = null;
//                           dashProvider.updateUI();
//                         },
//                       );
//                     },
//                   ),
//                   Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return ProductImageCard(
//                         labelText: 'Second image',
//                         imageFile: dashProvider.selectedSecondImage,
//                         imageUrlForUpdateImage: product?.images.safeElementAt(1)?.url,
//                         onTap: () {
//                           dashProvider.pickImage(imageCardNumber: 2);
//                         },
//                         onRemoveImage: () {
//                           dashProvider.selectedSecondImage = null;
//                           dashProvider.updateUI();
//                         },
//                       );
//                     },
//                   ),
//                   Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return ProductImageCard(
//                         labelText: 'Third image',
//                         imageFile: dashProvider.selectedThirdImage,
//                         imageUrlForUpdateImage: product?.images.safeElementAt(2)?.url,
//                         onTap: () {
//                           dashProvider.pickImage(imageCardNumber: 3);
//                         },
//                         onRemoveImage: () {
//                           dashProvider.selectedThirdImage = null;
//                           dashProvider.updateUI();
//                         },
//                       );
//                     },
//                   ),
//                   Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return ProductImageCard(
//                         labelText: 'Fourth image',
//                         imageFile: dashProvider.selectedFourthImage,
//                         imageUrlForUpdateImage: product?.images.safeElementAt(3)?.url,
//                         onTap: () {
//                           dashProvider.pickImage(imageCardNumber: 4);
//                         },
//                         onRemoveImage: () {
//                           dashProvider.selectedFourthImage = null;
//                           dashProvider.updateUI();
//                         },
//                       );
//                     },
//                   ),
//                   Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return ProductImageCard(
//                         labelText: 'Fifth image',
//                         imageFile: dashProvider.selectedFifthImage,
//                         imageUrlForUpdateImage: product?.images.safeElementAt(4)?.url,
//                         onTap: () {
//                           dashProvider.pickImage(imageCardNumber: 5);
//                         },
//                         onRemoveImage: () {
//                           dashProvider.selectedFifthImage = null;
//                           dashProvider.updateUI();
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: defaultPadding),
//               CustomTextField(
//                 controller: context.dashBoardProvider.productNameCtrl,
//                 labelText: 'Product Name',
//                 onSave: (val) {},
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter name';
//                   }
//                 },
//               ),
//               SizedBox(height: defaultPadding),
//               CustomTextField(
//                 controller: context.dashBoardProvider.productDescCtrl,
//                 labelText: 'Product Description',
//                 lineNumber: 3,
//                 onSave: (val) {},
//               ),
//               SizedBox(height: defaultPadding),
//               Row(
//                 children: [
//                   Expanded(child: Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return CustomDropdown(
//                         key: ValueKey(dashProvider.selectedCategory?.sId),
//                         initialValue: dashProvider.selectedCategory,
//                         hintText: dashProvider.selectedCategory?.name ?? 'Select category',
//                         items: context.dataProvider.categories,
//                         displayItem: (Category? category) => category?.name ?? '',
//                         onChanged: (newValue) {
//                           if (newValue != null) {
//                             //TODO: should complete call  filterSubcategory
//                           }
//                         },
//                         validator: (value) {
//                           if (value == null) {
//                             return 'Please select a category';
//                           }
//                           return null;
//                         },
//                       );
//                     },
//                   )),
//                   Expanded(child: Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return CustomDropdown(
//                         key: ValueKey(dashProvider.selectedSubCategory?.sId),
//                         hintText: dashProvider.selectedSubCategory?.name ?? 'Sub category',
//                         items: dashProvider.subCategoriesByCategory,
//                         initialValue: dashProvider.selectedSubCategory,
//                         displayItem: (SubCategory? subCategory) => subCategory?.name ?? '',
//                         onChanged: (newValue) {
//                           if (newValue != null) {
//                             //TODO: should complete call filterBrand
//                           }
//                         },
//                         validator: (value) {
//                           if (value == null) {
//                             return 'Please select sub category';
//                           }
//                           return null;
//                         },
//                       );
//                     },
//                   )),
//                   Expanded(
//                     child: Consumer<DashBoardProvider>(
//                       builder: (context, dashProvider, child) {
//                         return CustomDropdown(
//                             key: ValueKey(dashProvider.selectedBrand?.sId),
//                             initialValue: dashProvider.selectedBrand,
//                             items: dashProvider.brandsBySubCategory,
//                             hintText: dashProvider.selectedBrand?.name ?? 'Select Brand',
//                             displayItem: (Brand? brand) => brand?.name ?? '',
//                             onChanged: (newValue) {
//                               if (newValue != null) {
//                                 dashProvider.selectedBrand = newValue;
//                                 dashProvider.updateUI();
//                               }
//                             },
//                             validator: (value) {
//                               if (value == null) {
//                                 return 'Please brand';
//                               }
//                               return null;
//                             });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       controller: context.dashBoardProvider.productPriceCtrl,
//                       labelText: 'Price',
//                       inputType: TextInputType.number,
//                       onSave: (val) {},
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Please enter price';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomTextField(
//                       controller: context.dashBoardProvider.productOffPriceCtrl,
//                       labelText: 'Offer price',
//                       inputType: TextInputType.number,
//                       onSave: (val) {},
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomTextField(
//                       controller: context.dashBoardProvider.productQntCtrl,
//                       labelText: 'Quantity',
//                       inputType: TextInputType.number,
//                       onSave: (val) {},
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Please enter quantity';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(width: defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Consumer<DashBoardProvider>(
//                       builder: (context, dashProvider, child) {
//                         return CustomDropdown(
//                           key: ValueKey(dashProvider.selectedVariantType?.sId),
//                           initialValue: dashProvider.selectedVariantType,
//                           items: context.dataProvider.variantTypes,
//                           displayItem: (VariantType? variantType) => variantType?.name ?? '',
//                           onChanged: (newValue) {
//                             if (newValue != null) {
//                               //TODO: should complete call filterVariant
//                             }
//                           },
//                           hintText: 'Select Variant type',
//                         );
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: Consumer<DashBoardProvider>(
//                       builder: (context, dashProvider, child) {
//                         final filteredSelectedItems =
//                             dashProvider.selectedVariants.where((item) => dashProvider.variantsByVariantType.contains(item)).toList();
//                         return MultiSelectDropDown(
//                           items: dashProvider.variantsByVariantType,
//                           onSelectionChanged: (newValue) {
//                             dashProvider.selectedVariants = newValue;
//                             dashProvider.updateUI();
//                           },
//                           displayItem: (String item) => item,
//                           selectedItems: filteredSelectedItems,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: defaultPadding),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: secondaryColor,
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the popup
//                     },
//                     child: Text('Cancel'),
//                   ),
//                   SizedBox(width: defaultPadding),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: primaryColor,
//                     ),
//                     onPressed: () {
//                       // Validate and save the form
//                       if (context.dashBoardProvider.addProductFormKey.currentState!.validate()) {
//                         context.dashBoardProvider.addProductFormKey.currentState!.save();
//                         //TODO: should complete call submitProduct
//                         Navigator.of(context).pop();
//                       }
//                     },
//                     child: Text('Submit'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // How to show the popup
// void showAddProductForm(BuildContext context, Product? product) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: bgColor,
//         title: Center(child: Text('Add Product'.toUpperCase(), style: TextStyle(color: primaryColor))),
//         content: ProductSubmitForm(product: product),
//       );
//     },
//   );
// }
//
// extension SafeList<T> on List<T>? {
//   T? safeElementAt(int index) {
//     // Check if the list is null or if the index is out of range
//     if (this == null || index < 0 || index >= this!.length) {
//       return null;
//     }
//     return this![index];
//   }
// }
//
//




import 'package:admin/Getx/Products/models.dart';
import 'package:get/get.dart';

import '../../../Getx/Categories/model.dart';
import '../../../Getx/Products/controller.dart';
import '../../../Getx/Products/new_controller.dart';
import '../../../models/brand.dart';
import '../../../models/category.dart';
import '../../../models/product.dart';
import '../../../models/sub_category.dart';
import '../../../models/variant_type.dart';
import '../provider/dash_board_provider.dart';
import '../../../utility/extensions.dart';
import '../../../widgets/multi_select_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/product_image_card.dart';
import 'attributes_variations.dart';
import 'image_widgets.dart';

class ProductSubmitForm extends StatelessWidget {
  final NewAdminPanelController controller = Get.put(NewAdminPanelController());




  final ProductModel? productModel;

   ProductSubmitForm({super.key, this.productModel});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // context.dashBoardProvider.setDataForUpdateProduct(productModel);
    Get.put(ColorManagementSystem());
    return SingleChildScrollView(
      child: Form(
        key:  controller.addProductFormKey, //context.dashBoardProvider.addProductFormKey,
        child: Container(
          width: size.width * 0.7,
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImagePickerWidgets(),


              CustomTextField(
                controller: controller.titleController, //context.dashBoardProvider.productNameCtrl,
                labelText: 'Product Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                },
              ),
              SizedBox(height: defaultPadding),
              CustomTextField(
                controller: controller.descriptionController, //context.dashBoardProvider.productDescCtrl,
                labelText: 'Product Description',
                lineNumber: 3,
                onSave: (val) {},
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [


                  _buildType(),
                  SizedBox(width: defaultPadding/2),
                  _buildCategoryDropdown(),
                  SizedBox(width: defaultPadding/2),
                  _buildBrandDropdown(),
                  // Expanded(child: Consumer<DashBoardProvider>(
                  //   builder: (context, dashProvider, child) {
                  //     return CustomDropdown(
                  //       key: ValueKey(dashProvider.selectedSubCategory?.sId),
                  //       hintText: dashProvider.selectedSubCategory?.name ?? 'Sub category',
                  //       items: dashProvider.subCategoriesByCategory,
                  //       initialValue: dashProvider.selectedSubCategory,
                  //       displayItem: (SubCategory? subCategory) => subCategory?.name ?? '',
                  //       onChanged: (newValue) {
                  //         if (newValue != null) {
                  //           //TODO: should complete call filterBrand
                  //         }
                  //       },
                  //       validator: (value) {
                  //         if (value == null) {
                  //           return 'Please select sub category';
                  //         }
                  //         return null;
                  //       },
                  //     );
                  //   },
                  // )),
                  // Expanded(
                  //   child: Consumer<DashBoardProvider>(
                  //     builder: (context, dashProvider, child) {
                  //       return CustomDropdown(
                  //           key: ValueKey(dashProvider.selectedBrand?.sId),
                  //           initialValue: dashProvider.selectedBrand,
                  //           items: dashProvider.brandsBySubCategory,
                  //           hintText: dashProvider.selectedBrand?.name ?? 'Select Brand',
                  //           displayItem: (Brand? brand) => brand?.name ?? '',
                  //           onChanged: (newValue) {
                  //             if (newValue != null) {
                  //               dashProvider.selectedBrand = newValue;
                  //               dashProvider.updateUI();
                  //             }
                  //           },
                  //           validator: (value) {
                  //             if (value == null) {
                  //               return 'Please brand';
                  //             }
                  //             return null;
                  //           });
                  //     },
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.salePriceController, //context.dashBoardProvider.productPriceCtrl,
                      labelText: 'Price',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter price';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: controller.priceController, //context.dashBoardProvider.productOffPriceCtrl,
                      labelText: 'Offer price',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: controller.stockController, //context.dashBoardProvider.productQntCtrl,
                      labelText: 'Quantity',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter quantity';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(width: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: _buildChoice(),

                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              _buildAttributesAndVariations(),
              SizedBox(height: defaultPadding),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: defaultPadding),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     foregroundColor: Colors.white,
                  //     backgroundColor: primaryColor,
                  //   ),
                  //   onPressed: () {
                  //     // Validate and save the form
                  //     if (context.dashBoardProvider.addProductFormKey.currentState!.validate()) {
                  //       context.dashBoardProvider.addProductFormKey.currentState!.save();
                  //       //TODO: should complete call submitProduct
                  //       Navigator.of(context).pop();
                  //     }
                  //   },
                  //   child: Text('Submit'),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      Get.bottomSheet(
                        TranslationForm(bgColor: bgColor),
                        isScrollControlled: true,
                      );
                    },
                    child: Text('Add Translations'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () async {
                      if (controller.addProductFormKey.currentState!.validate()) {
                        controller.addProductFormKey.currentState!.save();

                        // Show progress indicator
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );

                        // Perform the network request
                        await controller.addProduct().then((_) {
                          // Hide progress indicator
                          Navigator.of(context).pop();

                          // Navigate back or show success message
                          Navigator.of(context).pop();
                        }).catchError((error) {
                          // Hide progress indicator
                          Navigator.of(context).pop();

                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $error'),
                            ),
                          );
                        });
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoice() {
    return Obx(() =>
        SwitchListTile(
          title: const Text('Is Featured'),
          value: controller.isFeatured.value,
          onChanged: (value) {
            controller.isFeatured.value = value;
          },
        ));
  }

  Widget _buildAttributesAndVariations() {
    return Column(
      children: [
        NewProductAttributeForm(),
        NewProductVariationForm(),
      ],
    );
  }
  Widget _buildType() {
    return Obx(() {
      return Expanded(
        child: CustomDropdown<ProductType>(
          key: ValueKey(controller.selectedProductType.value),
          initialValue: controller.selectedProductType.value,
          hintText: 'Select Product Type',
          items: ProductType.values,
          displayItem: (ProductType type) => type.name,
          onChanged: (ProductType? newValue) {
            if (newValue != null) {
              controller.selectedProductType.value = newValue;
            }
          },
          validator: (value) {
            if (value == null) {
              return 'Please select a product type';
            }
            return null;
          },
        ),
      );
    });
  }

  Widget _buildCategoryDropdown() {
    return Expanded(
      child: Obx(() => DropdownButtonFormField<CategoryModel>(
        value: controller.selectedCategory.value,
        items: controller.categories.map((category) {
          return DropdownMenuItem<CategoryModel>(
            value: category,
            child: Text(category.name),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            controller.selectCategory(newValue);
          }
        },
        decoration: InputDecoration(
          labelText: 'Category',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        ),
      )),
    );
  }

  Widget _buildBrandDropdown() {
    return Expanded(
      child: Obx(() => DropdownButtonFormField<NewBrandModel>(
        value: controller.selectedBrand.value,
        items: controller.brands.map((brand) {
          return DropdownMenuItem<NewBrandModel>(
            value: brand,
            child: Text(brand.name),
          );
        }).toList(),
        onChanged: (newValue) {
          controller.selectBrand(newValue!);
        },
        decoration: InputDecoration(
          labelText: 'Brand',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        ),
      )),
    );
  }


}

// How to show the popup
void showAddProductForm(BuildContext context, ProductModel? product) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(child: Text('Add Product'.toUpperCase(), style: TextStyle(color: primaryColor))),
        content: ProductSubmitForm(productModel: product),
      );
    },
  );
}

extension SafeList<T> on List<T>? {
  T? safeElementAt(int index) {
    // Check if the list is null or if the index is out of range
    if (this == null || index < 0 || index >= this!.length) {
      return null;
    }
    return this![index];
  }
}





