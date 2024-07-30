// admin_subcategory_controller.dart

import 'dart:io';
import 'package:admin/Getx/Sub%20Categories/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../Categories/model.dart';

// class AdminSubCategoryController extends GetxController {
//   static AdminSubCategoryController get instance => Get.find();
//
//   final SubCategoryRepository subCategoryRepository = Get.put(SubCategoryRepository());
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController parentIdController = TextEditingController();
//   final Rx<XFile?> selectedImage = Rx<XFile?>(null);
//   final RxBool isFeatured = RxBool(false); // Observable for isFeatured
//
//   List<CategoryModel> categories = [];
//
//   final GlobalKey<FormState> addSubCategoryFormKey = GlobalKey<FormState>();
//
//   @override
//   void onInit() {
//     super.onInit();
//     getAllCategories();
//   }
//
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       selectedImage.value = image;
//     }
//   }
//
//   Future<void> getAllCategories() async {
//     categories = await subCategoryRepository.getAllSubCategories().first;
//     update();
//   }
//
//   Future<void> addSubCategory() async {
//     if (nameController.text.isEmpty || selectedImage.value == null) {
//       // Handle validation or show error message
//       return;
//     }
//
//     final String imageUrl = await uploadImage(selectedImage.value!);
//
//     final subCategory = CategoryModel(
//       id: '', // Will be dynamically set by Firestore
//       name: nameController.text,
//       parentId: parentIdController.text,
//       image: imageUrl,
//       isFeatured: isFeatured.value, // Use observable value
//     );
//
//     await subCategoryRepository.addSubCategory(subCategory);
//
//     nameController.clear();
//     selectedImage.value = null;
//     parentIdController.clear();
//
//     getAllCategories(); // Refresh category list after adding
//   }
//
//   Future<void> updateSubCategory(CategoryModel subCategory) async {
//     // Implement update logic
//   }
//
//   Future<void> deleteSubCategory(String id) async {
//     await subCategoryRepository.deleteSubCategory(id);
//     getAllCategories(); // Refresh category list after deleting
//   }
//
//   Future<String> uploadImage(XFile image) async {
//     // Implement image upload logic
//     return ''; // Placeholder return
//   }
// }


// class AdminSubCategoryController extends GetxController {
//   static AdminSubCategoryController get instance => Get.find();
//
//   final SubCategoryRepository subCategoryRepository = Get.put(SubCategoryRepository());
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController parentIdController = TextEditingController();
//   final Rx<XFile?> selectedImage = Rx<XFile?>(null);
//   final RxBool isFeatured = RxBool(false); // Observable for isFeatured
//
//   List<CategoryModel> categories = [];
//   // Add selectedCategory and its getter/setter
//   CategoryModel? _selectedCategory;
//   CategoryModel? get selectedCategory => _selectedCategory;
//   set selectedCategory(CategoryModel? value) {
//     _selectedCategory = value;
//     update(); // Ensure to update the UI when selectedCategory changes
//   }
//   CategoryModel? selectedCategorys;
//   List<CategoryModel> categoriess = []; // Populate this with your data
//
//   final GlobalKey<FormState> addSubCategoryFormKey = GlobalKey<FormState>();
//
//   @override
//   void onInit() {
//     super.onInit();
//     getAllCategories();
//   }
//
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       selectedImage.value = image;
//     }
//   }
//
//   Future<void> getAllCategories() async {
//     categories = await subCategoryRepository.getAllSubCategories().first;
//     update();
//   }
//
//   Future<void> addSubCategory() async {
//     if (nameController.text.isEmpty || selectedImage.value == null) {
//       // Handle validation or show error message
//       return;
//     }
//
//     final String imageUrl = await uploadImage(selectedImage.value!);
//
//     final subCategory = CategoryModel(
//       id: '', // Will be dynamically set by Firestore
//       name: nameController.text,
//       parentId: parentIdController.text,
//       image: imageUrl,
//       isFeatured: isFeatured.value, // Use observable value
//     );
//
//     await subCategoryRepository.addSubCategory(subCategory);
//
//     nameController.clear();
//     selectedImage.value = null;
//     parentIdController.clear();
//
//     getAllCategories(); // Refresh category list after adding
//   }
//
//   Future<void> updateSubCategory(CategoryModel subCategory) async {
//     // Implement update logic
//     await subCategoryRepository.updateSubCategory(subCategory);
//     getAllCategories(); // Refresh category list after updating
//   }
//
//   Future<void> deleteSubCategory(String id) async {
//     await subCategoryRepository.deleteSubCategory(id);
//     getAllCategories(); // Refresh category list after deleting
//   }
//
//   Future<String> uploadImage(XFile image) async {
//     // Implement image upload logic
//     // This is a placeholder implementation
//     return ''; // Placeholder return
//   }
// }


// Controller
class AdminSubCategoryController extends GetxController {
  final SubCategoryRepository subCategoryRepository = Get.put(SubCategoryRepository());
  final TextEditingController nameController = TextEditingController();
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final RxBool isFeatured = RxBool(false);

  RxList<CategoryModel> subCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> mainCategories = <CategoryModel>[].obs;
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);

  final GlobalKey<FormState> addSubCategoryFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getSubCategories();
    getMainCategories();
  }

  void getSubCategories() {
    subCategoryRepository.getSubCategories().listen((updatedSubCategories) {
      subCategories.value = updatedSubCategories;
    });
  }

  void getMainCategories() {
    subCategoryRepository.getMainCategories().listen((updatedMainCategories) {
      mainCategories.value = updatedMainCategories;
    });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = image;
    }
  }

  // Future<void> addSubCategory() async {
  //   if (addSubCategoryFormKey.currentState!.validate() && selectedImage.value != null && selectedCategory.value != null) {
  //     String imageUrl = await subCategoryRepository.uploadImage(selectedImage.value!);
  //
  //     final subCategory = CategoryModel(
  //       id: '',
  //       name: nameController.text,
  //       image: imageUrl,
  //       isFeatured: isFeatured.value,
  //       parentId: selectedCategory.value!.id,
  //     );
  //
  //     await subCategoryRepository.addSubCategory(subCategory);
  //     resetForm();
  //   }
  // }

  Future<void> addSubCategory() async {
    if (addSubCategoryFormKey.currentState!.validate() && selectedImage.value != null && selectedCategory.value != null) {
      String imageUrl = await subCategoryRepository.uploadImage(selectedImage.value!);

      final nextId = await subCategoryRepository.getNextCategoryId();

      final subCategory = CategoryModel(
        id: nextId,
        name: nameController.text,
        image: imageUrl,
        isFeatured: isFeatured.value,
        parentId: selectedCategory.value!.id,
      );

      await subCategoryRepository.addSubCategory(subCategory);
      resetForm();
    }
  }

  Future<void> updateSubCategory(CategoryModel subCategory) async {
    if (selectedImage.value != null) {
      String imageUrl = await subCategoryRepository.uploadImage(selectedImage.value!);
      subCategory.image = imageUrl;
    }

    subCategory.name = nameController.text;
    subCategory.parentId = selectedCategory.value!.id;
    subCategory.isFeatured = isFeatured.value;

    await subCategoryRepository.updateSubCategory(subCategory);
    resetForm();
  }

  Future<void> deleteSubCategory(String id) async {
    await subCategoryRepository.deleteSubCategory(id);
  }

  void resetForm() {
    nameController.clear();
    selectedImage.value = null;
    selectedCategory.value = null;
    isFeatured.value = false;
  }

  void setSubCategoryForEdit(CategoryModel subCategory) {
    nameController.text = subCategory.name;
    selectedCategory.value = mainCategories.firstWhereOrNull((cat) => cat.id == subCategory.parentId);
    isFeatured.value = subCategory.isFeatured;
    // Note: We don't set the image here, as it would require downloading it first
  }
}
