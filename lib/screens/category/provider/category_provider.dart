import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/constants_helpers.dart';
import '../../../constants/images.dart';
import '../../../constants/network.dart';
import '../../../services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/category.dart';
import '../../main/main_screen.dart';

class CategoryProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addCategoryFormKey = GlobalKey<FormState>();
  TextEditingController categoryNameCtrl = TextEditingController();
  Category? categoryForUpdate;


  File? selectedImage;
  XFile? imgXFile;


  CategoryProvider(this._dataProvider);

  //TODO: should complete addCategory

  //TODO: should complete updateCategory

  //TODO: should complete submitCategory


  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      imgXFile = image;
      notifyListeners();
    }
  }

  //TODO: should complete deleteCategory

  //TODO: should complete setDataForUpdateCategory


  //? to create form data for sending image with body
  Future<FormData> createFormData({required XFile? imgXFile, required Map<String, dynamic> formData}) async {
    if (imgXFile != null) {
      MultipartFile multipartFile;
      if (kIsWeb) {
        String fileName = imgXFile.name;
        Uint8List byteImg = await imgXFile.readAsBytes();
        multipartFile = MultipartFile(byteImg, filename: fileName);
      } else {
        String fileName = imgXFile.path.split('/').last;
        multipartFile = MultipartFile(imgXFile.path, filename: fileName);
      }
      formData['img'] = multipartFile;
    }
    final FormData form = FormData(formData);
    return form;
  }

  //? set data for update on editing
  setDataForUpdateCategory(Category? category) {
    if (category != null) {
      clearFields();
      categoryForUpdate = category;
      categoryNameCtrl.text = category.name ?? '';
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update category
  clearFields() {
    categoryNameCtrl.clear();
    selectedImage = null;
    imgXFile = null;
    categoryForUpdate = null;
  }
}





//
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../../Getx/Categories/model.dart';
//
// /// Newwwwwwwwwwwww
// class CategoryProvider with ChangeNotifier {
//   final List<CategoryModel> _categories = [];
//   final _db = FirebaseFirestore.instance;
//   XFile? _selectedImage;
//
//   List<CategoryModel> get categories => _categories;
//   XFile? get selectedImage => _selectedImage;
//
//   Future<void> getAllCategories() async {
//     try {
//       final snapshot = await _db.collection('Categories').get();
//       _categories.clear();
//       _categories.addAll(snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)));
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching categories: $e');
//     }
//   }
//
//   Future<void> addCategory(CategoryModel category) async {
//     try {
//       final nextId = await getNextCategoryId();
//       final newCategory = CategoryModel(
//         id: nextId,
//         name: category.name,
//         image: category.image,
//         isFeatured: category.isFeatured,
//         parentId: category.parentId,
//       );
//
//       await _db.collection('Categories').doc(nextId).set(newCategory.toJson());
//       await getAllCategories();
//     } catch (e) {
//       print('Error adding category: $e');
//       throw e;
//     }
//   }
//
//   Future<String> getNextCategoryId() async {
//     try {
//       final querySnapshot = await _db.collection('Categories')
//           .orderBy('id', descending: true)
//           .limit(1)
//           .get();
//
//       if (querySnapshot.docs.isNotEmpty) {
//         final lastId = int.parse(querySnapshot.docs.first['id']);
//         return (lastId + 1).toString();
//       } else {
//         return '1';
//       }
//     } catch (e) {
//       print('Error getting next category ID: $e');
//       throw e;
//     }
//   }
//
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       _selectedImage = image;
//       notifyListeners();
//     }
//   }
//
//   Future<String> uploadImage(XFile image) async {
//     final storageRef = FirebaseStorage.instance.ref();
//     final imagesRef = storageRef.child('images/${image.name}');
//     try {
//       if (kIsWeb) {
//         final Uint8List imageData = await image.readAsBytes();
//         await imagesRef.putData(imageData);
//       } else {
//         await imagesRef.putFile(File(image.path));
//       }
//       return await imagesRef.getDownloadURL();
//     } catch (e) {
//       print('Failed to upload image: $e');
//       throw Exception('Failed to upload image');
//     }
//   }
//
//   void clearSelectedImage() {
//     _selectedImage = null;
//     notifyListeners();
//   }
// }
