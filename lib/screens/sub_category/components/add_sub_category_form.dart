import '../../../Getx/Categories/model.dart';
import '../../../Getx/Sub Categories/controller.dart';
import '../../../Getx/Sub Categories/model.dart';
import '../../../models/sub_category.dart';
import '../provider/sub_category_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../models/category.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';

 // class SubCategorySubmitForm extends StatelessWidget {
 //   final SubCategory? subCategory;
 //
 //  const SubCategorySubmitForm({super.key, this.subCategory});
 //
 //   @override
 //   Widget build(BuildContext context) {
 //     context.subCategoryProvider.setDataForUpdateCategory(subCategory);
 //     var size = MediaQuery.of(context).size;
 //     return SingleChildScrollView(
 //       child: Form(
 //         key: context.subCategoryProvider.addSubCategoryFormKey,
 //         child: Container(
 //           padding: EdgeInsets.all(defaultPadding),
 //           width: size.width * 0.5,
 //           decoration: BoxDecoration(
 //             color: bgColor,
 //             borderRadius: BorderRadius.circular(12.0),
 //           ),
 //          child: Column(
 //             mainAxisSize: MainAxisSize.min,
 //            children: [
 //               Gap(defaultPadding),
 //               Row(
 //                 children: [
 //                   Expanded(
 //                     child: Consumer<SubCategoryProvider>(
 //                       builder: (context, subCatProvider, child) {
 //                         return CustomDropdown(
 //                           initialValue: subCatProvider.selectedCategory,
 //                           hintText: subCatProvider.selectedCategory?.name ?? 'Select category',
 //                           items: context.dataProvider.categories,
 //                           displayItem: (Category? category) => category?.name ?? '',
 //                           onChanged: (newValue) {
 //                             if (newValue != null) {
 //                              subCatProvider.selectedCategory = newValue;
 //                              subCatProvider.updateUi();
 //                             }
 //                           },
 //                           validator: (value) {
 //                             if (value == null) {
 //                               return 'Please select a category';
 //                             }
 //                             return null;
 //                          },
 //                         );
 //                       },
 //                     ),
 //                   ),
 //                   Expanded(
 //                     child: CustomTextField(
 //                       controller: context.subCategoryProvider.subCategoryNameCtrl,
 //                       labelText: 'Sub Category Name',
 //                       onSave: (val) {},
 //                       validator: (value) {
 //                         if (value == null || value.isEmpty) {
 //                           return 'Please enter a sub category name';
 //                         }
 //                         return null;
 //                       },
 //                     ),
 //                   ),
 //                ],
 //              ),
 //               Gap(defaultPadding * 2),
 //               Row(
 //                mainAxisAlignment: MainAxisAlignment.center,
 //                 children: [
 //                   ElevatedButton(
 //                     style: ElevatedButton.styleFrom(
 //                       foregroundColor: Colors.white,
 //                      backgroundColor: secondaryColor,
 //                     ),
 //                     onPressed: () {
 //                       Navigator.of(context).pop(); // Close the popup
 //                     },
 //                     child: Text('Cancel'),
 //                   ),
 //                  Gap(defaultPadding),
 //                   ElevatedButton(
 //                     style: ElevatedButton.styleFrom(
 //                       foregroundColor: Colors.white,
 //                       backgroundColor: primaryColor,
 //                     ),
 //                     onPressed: () {
 //                      // Validate and save the form
 //                       if (context.subCategoryProvider.addSubCategoryFormKey.currentState!.validate()) {
 //                         context.subCategoryProvider.addSubCategoryFormKey.currentState!.save();
 //                        //TODO: should complete call submitSubCategory
 //                         Navigator.of(context).pop();
 //                       }
 //                     },
 //                    child: Text('Submit'),
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
// class SubCategorySubmitForm extends StatelessWidget {
//   final CategoryModel? subCategory;
//
//   const SubCategorySubmitForm({Key? key, this.subCategory}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final AdminSubCategoryController subCategoryController = Get.find();
//
//     return SingleChildScrollView(
//       child: Form(
//         key: subCategoryController.addSubCategoryFormKey,
//         child: Container(
//           padding: EdgeInsets.all(16.0),
//           width: MediaQuery.of(context).size.width * 0.5,
//           decoration: BoxDecoration(
//             color: Colors.blueGrey,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: subCategoryController.nameController,
//                 decoration: InputDecoration(labelText: 'Subcategory Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               DropdownButtonFormField<CategoryModel>(
//                 value: subCategoryController.selectedCategory,
//                 hint: Text('Select Parent Category'),
//                 items: subCategoryController.categories
//                     .map((category) => DropdownMenuItem<CategoryModel>(
//                   value: category,
//                   child: Text(category.name),
//                 ))
//                     .toList(),
//                 onChanged: (newValue) {
//                   subCategoryController.selectedCategory = newValue;
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select a category';
//                   }
//                   return null;
//                 },
//               ),
//
//
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: subCategoryController.pickImage,
//                 child: Text('Pick Image'),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: subCategoryController.addSubCategory,
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//  // How to show the category popup
//  void showAddSubCategoryForm(BuildContext context, CategoryModel? subCategory) {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          backgroundColor: bgColor,
//          title: Center(child: Text('Add Sub Category'.toUpperCase(), style: TextStyle(color: primaryColor))),
//          content: SubCategorySubmitForm(subCategory: subCategory),
//        );
//      },
//  );
//  }
//


class SubCategorySubmitForm extends StatelessWidget {
  final CategoryModel? subCategory;

  const SubCategorySubmitForm({Key? key, this.subCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdminSubCategoryController controller = Get.find();

    if (subCategory != null) {
      controller.setSubCategoryForEdit(subCategory!);
    }

    return SingleChildScrollView(
      child: Form(
        key: controller.addSubCategoryFormKey,
        child: Container(
          padding: EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(labelText: 'Subcategory Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Obx(() => DropdownButtonFormField<CategoryModel>(
                value: controller.selectedCategory.value,
                hint: Text('Select Parent Category'),
                items: controller.mainCategories
                    .map((category) => DropdownMenuItem<CategoryModel>(
                  value: category,
                  child: Text(category.name),
                ))
                    .toList(),
                onChanged: (newValue) {
                  controller.selectedCategory.value = newValue;
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              )),

              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: controller.pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 16.0),
              Obx(() => CheckboxListTile(
                title: Text('Is Featured'),
                value: controller.isFeatured.value,
                onChanged: (bool? value) {
                  controller.isFeatured.value = value ?? false;
                },
              )),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: subCategory == null
                    ? controller.addSubCategory
                    : () => controller.updateSubCategory(subCategory!),
                child: Text(subCategory == null ? 'Submit' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showAddSubCategoryForm(BuildContext context, CategoryModel? subCategory) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(child: Text(subCategory == null ? 'Add Sub Category' : 'Edit Sub Category', style: TextStyle(color: Theme.of(context).primaryColor))),
        content: SubCategorySubmitForm(subCategory: subCategory),
      );
    },
  );
}
