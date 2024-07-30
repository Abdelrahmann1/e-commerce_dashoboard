// import 'package:get/get.dart';
//
// import '../../../models/category.dart';
// import '../provider/category_provider.dart';
// import '../../../utility/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/constants.dart';
// import '../../../widgets/category_image_card.dart';
// import '../../../widgets/custom_text_field.dart';
//
// class CategorySubmitForm extends StatelessWidget {
//   final Category? category;
//
//   const CategorySubmitForm({super.key, this.category});
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     //TODO: should complete call setDataForUpdateCategory
//     return SingleChildScrollView(
//       child: Form(
//         key: context.categoryProvider.addCategoryFormKey,
//         child: Container(
//           padding: EdgeInsets.all(defaultPadding),
//           width: size.width * 0.3,
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Gap(defaultPadding),
//               Consumer<CategoryProvider>(
//                 builder: (context, catProvider, child) {
//                   return CategoryImageCard(
//                     labelText: "Category",
//                     imageFile: catProvider.selectedImage,
//                     imageUrlForUpdateImage: category?.image,
//                     onTap: () {
//                       catProvider.pickImage();
//                     },
//                   );
//                 },
//               ),
//               Gap(defaultPadding),
//               CustomTextField(
//                 controller: context.categoryProvider.categoryNameCtrl,
//                 labelText: 'Category Name',
//                 onSave: (val) {},
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a category name';
//                   }
//                   return null;
//                 },
//               ),
//               Gap(defaultPadding * 2),
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
//                   Gap(defaultPadding),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: primaryColor,
//                     ),
//                     onPressed: () {
//                       // Validate and save the form
//                       if (context.categoryProvider.addCategoryFormKey.currentState!.validate()) {
//                         context.categoryProvider.addCategoryFormKey.currentState!.save();
//                         //TODO: should complete call submitCategory
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
// // How to show the category popup
// void showAddCategoryForm(BuildContext context, Category? category) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: bgColor,
//         title: Center(child: Text('Add Category'.toUpperCase(), style: TextStyle(color: primaryColor))),
//         content: CategorySubmitForm(category: category),
//       );
//     },
//   );
// }
//
//
//
// /// Ui with Getx
//


import 'dart:io';

import 'package:admin/Getx/Categories/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Getx/Categories/controller.dart';
import '../../../widgets/category_image_card.dart';
import '../../../utility/constants.dart';
import '../../../models/category.dart'; // Update with your model import
import 'package:gap/gap.dart';

import '../../../widgets/custom_text_field.dart';

// class CategorySubmitForm extends StatelessWidget {
//   final CategoryModel? category;
//
//   const CategorySubmitForm({Key? key, this.category}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final AdminCategoryController categoryController = Get.put(
//         AdminCategoryController());
//
//     var size = MediaQuery
//         .of(context)
//         .size;
//
//     return SingleChildScrollView(
//       child: Form(
//         key: categoryController.addCategoryFormKey,
//         child: Container(
//           padding: EdgeInsets.all(defaultPadding),
//           width: size.width * 0.3,
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Gap(defaultPadding),
//               GetBuilder<AdminCategoryController>(
//                 id: 'imageUpdate', // Add this line
//                 builder: (controller) =>
//                     Obx(() {
//                       return CategoryImageCard(
//                         labelText: "Category",
//                         imageFile: controller.selectedImage.value != null
//                             ? File(controller.selectedImage.value!.path)
//                             : null,
//                         imageUrlForUpdateImage: category?.image,
//
//                         onTap: () {
//                           controller.pickImage();
//                         },
//                       );
//                     }),
//               ),
//               Gap(defaultPadding),
//               CustomTextField(
//                 controller: categoryController.nameController,
//                 labelText: 'Category Name',
//                 onSave: (val) {},
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a category name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               Obx(() =>
//                   CheckboxListTile(
//                     title: const Text('Featured'),
//                     value: categoryController.isFeaturedController.value,
//                     onChanged: (value) =>
//                     categoryController.isFeaturedController.value = value!,
//                   )),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: categoryController.parentIdController,
//                 decoration:
//                 InputDecoration(labelText: 'Parent ID (Optional)'),
//               ),
//               const SizedBox(height: 32),
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
//                   const SizedBox(width: 16),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: primaryColor,
//                     ),
//                     onPressed: () {
//                       // Validate and submit the form
//                       if (categoryController.addCategoryFormKey.currentState!
//                           .validate()) {
//                         categoryController.addCategoryFormKey.currentState!
//                             .save();
//                         categoryController
//                             .addCategory(); // Call to add category
//                         Navigator.of(context)
//                             .pop(); // Close the popup after submission
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
// // How to show the category popup
void showAddCategoryForm(BuildContext context, CategoryModel? category) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(child: Text('Add Category'.toUpperCase(),
            style: TextStyle(color: primaryColor))),
        content: CategorySubmitForm(category: category),
      );
    },
  );
}



//------------------test -------------

class CategorySubmitForm extends StatelessWidget {
  final CategoryModel? category;

  const CategorySubmitForm({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdminCategoryController categoryController = Get.put(AdminCategoryController());

    if (category != null) {
      categoryController.loadCategoryDetails(category!);
    }

    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: categoryController.addCategoryFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: size.width * 0.3,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(defaultPadding),
              GetBuilder<AdminCategoryController>(
                id: 'imageUpdate',
                builder: (controller) => Obx(
                  ()=> CategoryImageCard(
                    labelText: "Category",
                    imageFile: controller.selectedImage.value != null
                        ? File(controller.selectedImage.value!.path)
                        : null,
                    imageUrlForUpdateImage: category?.image,
                    onTap: () {

                      controller.pickImage();
                    },
                  ),
                ),
              ),
              Gap(defaultPadding),
              CustomTextField(
                controller: categoryController.nameController,
                labelText: 'Category Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(() => CheckboxListTile(
                title: const Text('Featured'),
                value: categoryController.isFeaturedController.value,
                onChanged: (value) =>
                categoryController.isFeaturedController.value = value!,
              )),
              const SizedBox(height: 16),
              TextField(
                controller: categoryController.parentIdController,
                decoration: InputDecoration(labelText: 'Parent ID (Optional)'),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      if (categoryController.addCategoryFormKey.currentState!.validate()) {
                        categoryController.addCategoryFormKey.currentState!.save();
                        if (category != null) {
                          categoryController.updateCategory(category!.id);
                        } else {
                          categoryController.addCategory();
                        }
                        Navigator.of(context).pop();
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
}
