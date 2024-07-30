//
// // Category Getx controller
// import 'dart:io';
//
// import 'package:admin/Getx/Categories/model.dart';
// import 'package:admin/Getx/Categories/repository.dart';
// import 'package:admin/constants/constants_helpers.dart';
// import 'package:admin/constants/network.dart';
// import 'package:admin/screens/main/main_screen.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../constants/images.dart';
//
// class AdminCategoryController extends GetxController {
//
//
//   static AdminCategoryController get instance => Get.find();
//   final RxList<CategoryModel> categories = <CategoryModel>[].obs;
//   final categoryRepository = Get.put(CategoryRepository());
//   final nameController = TextEditingController();
//   final imageController = TextEditingController();
//   final isFeaturedController = false.obs;
//   final parentIdController = TextEditingController();
//   final Rx<XFile?> selectedImage = Rx<XFile?>(null);
//   GlobalKey<FormState> addCategoryFormKey =  GlobalKey<FormState>() ;
//   // Initialize NetworkManager
//   final NetworkManager networkManager = Get.put(NetworkManager());
//
//   @override
//   void onClose() {
//     // Clean up resources when the controller is closed
//     networkManager.dispose();
//     super.onClose();
//   }
//
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       selectedImage.value = image;
//     }
//   }
//   Rx<File?> selectedImagee = Rx<File?>(null);
//   Rx<XFile?> imgXFile = Rx<XFile?>(null);
//
//   void pickImagee() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//
//     if (image != null) {
//       selectedImagee.value = File(image.path);
//       imgXFile.value = image;
//       print("Image picked: ${selectedImage.value?.path}");  // Debug print
//       update(['imageUpdate']);  // Modify this line
//     } else {
//       print("No image selected");  // Debug print
//     }
//   }
//
//
//   Future<void> addCategory() async {
//     if (nameController.text.isEmpty || selectedImagee.value == null) {
//       TLoaders.errorSnackBar(
//           title: 'Error', message: 'Please fill all required fields');
//       return;
//     }
//
//     try {
//       TFullScreenLoader.openLoadingDialog(
//           'Adding category...', TImages.shopAnimation);
//
//       final isConnected = await NetworkManager.instance.isConnected();
//       if (!isConnected) {
//         TLoaders.errorSnackBar(
//             title: 'No Internet Connection',
//             message: 'Please check your internet connection and try again.');
//         return;
//       }
//
//       // Upload image to Firebase Storage and get the URL
//       final String imageUrl = await uploadImagee(selectedImagee.value!);
//
//       // Create category model
//       final category = CategoryModel(
//         id: '', // This will be replaced with the auto-generated ID in the repository
//         name: nameController.text,
//         image: imageUrl,
//         isFeatured: isFeaturedController.value,
//         parentId: parentIdController.text,
//       );
//
//       // Add category to Firestore
//       await categoryRepository.addCategory(category);
//
//       TLoaders.hideSnackBar();
//       TLoaders.successSnackBar(
//           title: 'Success', message: 'Category added successfully');
//       await categoryRepository.getAllCategories();
//       Get.offAll(() =>  MainScreen());
//
//       // Clear inputs
//       nameController.clear();
//       selectedImagee.value = null;
//       isFeaturedController.value = false;
//       parentIdController.clear();
//     } catch (e) {
//       TLoaders.hideSnackBar();
//       TLoaders.errorSnackBar(
//           title: 'Error', message: 'Failed to add category: $e');
//     }
//   }
//
//   Future<String> uploadImage(XFile image) async {
//     final storageRef = FirebaseStorage.instance.ref();
//     final imagesRef = storageRef.child('images/${image.name}');
//     try {
//       if (kIsWeb) {
//         // For web, use bytes
//         final Uint8List imageData = await image.readAsBytes();
//         await imagesRef.putData(imageData);
//       } else {
//         // For mobile, use File
//         await imagesRef.putFile(File(image.path));
//       }
//       final imageUrl = await imagesRef.getDownloadURL();
//       return imageUrl;
//     } catch (e) {
//       throw Exception('Failed to upload image: $e');
//     }
//   }
//
//
//   Future<String> uploadImagee(File image) async {
//     final storageRef = FirebaseStorage.instance.ref();
//     late final String fileName;
//     late final Uint8List imageData;
//
//     if (image is XFile) {
//       fileName = image.path;
//       imageData = await image.readAsBytes();
//     } else if (image is File) {
//       fileName = image.path.split('/').last;
//       imageData = await image.readAsBytes();
//     } else {
//       throw Exception('Unsupported image type');
//     }
//
//     final imagesRef = storageRef.child('images/$fileName');
//
//     try {
//       // Use putData for both web and mobile
//       await imagesRef.putData(imageData);
//       final imageUrl = await imagesRef.getDownloadURL();
//       return imageUrl;
//     } catch (e) {
//       throw Exception('Failed to upload image: $e');
//     }
//   }
// }
//

//---------------------Good-------------
import 'package:admin/Getx/Categories/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:firebase_storage/firebase_storage.dart';

import '../../constants/constants_helpers.dart';
import '../../constants/images.dart';
import '../../constants/network.dart';
import '../../screens/main/main_screen.dart';
import 'model.dart'; // Add this import for Firebase Storage

class AdminCategoryController extends GetxController {
  static AdminCategoryController get instance => Get.find();

  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final categoryRepository = Get.put(CategoryRepository());
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final isFeaturedController = false.obs;
  final parentIdController = TextEditingController();
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  GlobalKey<FormState> addCategoryFormKey = GlobalKey<FormState>();

  // Initialize NetworkManager
  final NetworkManager networkManager = Get.put(NetworkManager());
  @override
  void onInit() {
    fetchAllCategories();
    super.onInit();
  }
  @override
  void onClose() {
    // Clean up resources when the controller is closed
    networkManager.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = image;
    }
  }


  //---------Load --------------

  void loadCategoryDetails(CategoryModel category) {
    nameController.text = category.name;
    parentIdController.text = category.parentId ?? '';
    isFeaturedController.value = category.isFeatured;
    if (category.image != null) {
      selectedImage.value = XFile(category.image!);
    } else {
      selectedImage.value = null;
    }
  }

  // Future<void> addCategory() async {
  //   if (nameController.text.isEmpty || selectedImage.value == null) {
  //     TLoaders.errorSnackBar(
  //         title: 'Error', message: 'Please fill all required fields');
  //     return;
  //   }
  //
  //   try {
  //     TFullScreenLoader.openLoadingDialog(
  //         'Adding category...', TImages.shopAnimation);
  //
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       TLoaders.errorSnackBar(
  //           title: 'No Internet Connection',
  //           message: 'Please check your internet connection and try again.');
  //       return;
  //     }
  //
  //     // Upload image to Firebase Storage and get the URL
  //     final String imageUrl = await uploadImage(selectedImage.value!);
  //
  //     // Create category model
  //     final category = CategoryModel(
  //       id: '', // This will be replaced with the auto-generated ID in the repository
  //       name: nameController.text,
  //       image: imageUrl,
  //       isFeatured: isFeaturedController.value,
  //       parentId: parentIdController.text,
  //     );
  //
  //     // Add category to Firestore
  //     await categoryRepository.addCategory(category);
  //
  //     TLoaders.hideSnackBar();
  //     TLoaders.successSnackBar(
  //         title: 'Success', message: 'Category added successfully');
  //     await categoryRepository.getAllCategories();
  //     Get.offAll(() => MainScreen());
  //
  //     // Clear inputs
  //     nameController.clear();
  //     selectedImage.value = null;
  //     isFeaturedController.value = false;
  //     parentIdController.clear();
  //   } catch (e) {
  //     TLoaders.hideSnackBar();
  //     TLoaders.errorSnackBar(
  //         title: 'Error', message: 'Failed to add category: $e');
  //   }
  // }

  Future<void> addCategory() async {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a category name');
      return;
    }

    try {
      String? imageUrl;
      if (selectedImage.value != null) {
        imageUrl = await uploadImage(selectedImage.value!);
      }

      final category = CategoryModel(
        id: '', // Generate a new ID
        name: nameController.text,
        image: imageUrl ?? '',
        isFeatured: isFeaturedController.value,
        parentId: parentIdController.text,
      );

      await categoryRepository.addCategory(category);
      Get.snackbar('Success', 'Category added successfully');
      await fetchAllCategories();

      nameController.clear();
      selectedImage.value = null;
      isFeaturedController.value = false;
      parentIdController.clear();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add category: $e');
    }
  }
  Future<void> updateCategory(String categoryId) async {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a category name');
      return;
    }

    try {
      String? imageUrl;
      if (selectedImage.value != null) {
        imageUrl = await uploadImage(selectedImage.value!);
      }

      final category = CategoryModel(
        id: categoryId,
        name: nameController.text,
        image: imageUrl ?? '',
        isFeatured: isFeaturedController.value,
        parentId: parentIdController.text,
      );

      await categoryRepository.updateCategory(categoryId,category);
      Get.snackbar('Success', 'Category updated successfully');
      await fetchAllCategories();

      nameController.clear();
      selectedImage.value = null;
      isFeaturedController.value = false;
      parentIdController.clear();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update category: $e');
    }
  }
  Future<void> fetchAllCategories() async {
    try {
      categories.value = await categoryRepository.getAllCategories();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories: $e');
    }
  }
  // Future<void> fetchAllCategories() async {
  //   try {
  //     final categoriesList = await categoryRepository.getAllCategories();
  //     categories.assignAll(categoriesList);
  //   } catch (e) {
  //     TLoaders.errorSnackBar(
  //         title: 'Error', message: 'Failed to fetch categories: $e');
  //   }
  // }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await categoryRepository.deleteCategory(categoryId);
      fetchAllCategories();
      TLoaders.successSnackBar(
          title: 'Success', message: 'Category deleted successfully');
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to delete category: $e');
    }
  }
  Future<String> uploadImage(XFile image) async {
    final storageRef = FirebaseStorage.instance.ref();
    final String fileName = image.path.split('/').last;
    final imagesRef = storageRef.child('images/$fileName');

    try {
      if (kIsWeb) {
        // For web, use bytes
        final Uint8List imageData = await image.readAsBytes();
        await imagesRef.putData(imageData);
      } else {
        // For mobile, use File
        await imagesRef.putFile(File(image.path));
      }
      final imageUrl = await imagesRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}



//-----------------------testing-----------------------------