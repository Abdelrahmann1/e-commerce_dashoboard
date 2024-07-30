// subcategory_repository.dart

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../Categories/model.dart';

// class SubCategoryRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String _collectionPath = 'subcategories';
//
//   Future<void> addSubCategory(CategoryModel subCategory) async {
//     int count = await _getDocumentCount();
//
//     subCategory.id = (count + 1).toString();
//
//     await _firestore.collection(_collectionPath).doc(subCategory.id).set({
//       'Name': subCategory.name,
//       'ParentId': subCategory.parentId,
//       'Image': subCategory.image,
//       'IsFeatured': subCategory.isFeatured ?? false, // Default to false if not provided
//     });
//   }
//
//   Future<void> updateSubCategory(CategoryModel subCategory) async {
//     await _firestore.collection(_collectionPath).doc(subCategory.id).update({
//       'Name': subCategory.name,
//       'ParentId': subCategory.parentId,
//       'Image': subCategory.image,
//       'IsFeatured': subCategory.isFeatured ?? false, // Default to false if not provided
//     });
//   }
//
//   Future<void> deleteSubCategory(String id) async {
//     await _firestore.collection(_collectionPath).doc(id).delete();
//   }
//
//   Stream<List<CategoryModel>> getAllSubCategories() {
//     return _firestore.collection(_collectionPath).orderBy('Id').snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return CategoryModel(
//           id: doc.id,
//           name: doc['Name'],
//           parentId: doc['ParentId'],
//           image: doc['Image'],
//           isFeatured: doc['IsFeatured'],
//         );
//       }).toList();
//     });
//   }
//
//   Future<int> _getDocumentCount() async {
//     QuerySnapshot querySnapshot = await _firestore.collection(_collectionPath).get();
//     return querySnapshot.size;
//   }
// }

// Repository
class SubCategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String _categoriesPath = 'Categories';
  final String _collectionPath = 'subCategories';
  final _db = FirebaseFirestore.instance;

  Future<int> _getDocumentCount() async {
   QuerySnapshot querySnapshot = await _firestore.collection(_collectionPath).get();
     return querySnapshot.size;
  }


  // Future<void> addSubCategory(CategoryModel subCategory) async {
  //   // await getNextCategoryId();
  //   // await _firestore.collection(_collectionPath).add(subCategory.toJson());
  //   try {
  //
  //     final nextId = await getNextCategoryId();
  //     final newsubCategory = CategoryModel(
  //       id: nextId,
  //       name: subCategory.name,
  //       image: subCategory.image,
  //       isFeatured: subCategory.isFeatured,
  //       parentId: subCategory.parentId,
  //     );
  //     await _firestore.collection(_collectionPath).add(newsubCategory.toJson());
  //   }catch (e) {}
  // }
  Future<String> getNextCategoryId() async {
    try {
      final querySnapshot = await _firestore.collection(_collectionPath)
          .orderBy('Id', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final lastId = int.parse(querySnapshot.docs.first['Id']);
        return (lastId + 1).toString();
      } else {
        return '1';
      }
    } catch (e) {
      print('Error getting next category ID: $e');
      throw e;
    }
  }

  Future<void> addSubCategory(CategoryModel subCategory) async {
    try {
      await _firestore.collection(_collectionPath).doc(subCategory.id).set(subCategory.toJson());
    } catch (e) {
      print('Error adding subcategory: $e');
      throw e;
    }
  }



  Future<void> updateSubCategory(CategoryModel subCategory) async {
    await _firestore.collection(_collectionPath).doc(subCategory.id).update(subCategory.toJson());
  }

  Future<void> deleteSubCategory(String id) async {
    await _firestore.collection(_collectionPath).doc(id).delete();
  }

  Stream<List<CategoryModel>> getAllCategories() {
    return _firestore.collection(_categoriesPath).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<CategoryModel>> getSubCategories() {
    return _firestore.collection(_collectionPath).where('ParentId', isNotEqualTo: '').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<CategoryModel>> getMainCategories() {
    return _firestore.collection(_categoriesPath)
        .where('ParentId', isEqualTo: '')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
    });
  }


  Future<String> uploadImage(XFile image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef = _storage.ref().child('category_images/$fileName');
    UploadTask uploadTask = storageRef.putData(await image.readAsBytes());
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}
