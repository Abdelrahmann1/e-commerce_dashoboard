//Category Repository
import 'package:admin/Getx/Categories/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/constants_helpers.dart';

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  ///  Get All categories
  Future<List<CategoryModel>> getAllCategories()async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList() ;
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }catch(e) {
      throw 'Something went wrong , please try again';
    }
  }
  ///   Get Sub categories
  Future<List<CategoryModel>> getSubCategories(String categoryId)async{
    try{
      final snapshot = await _db.collection("Categories").where('ParentId', isEqualTo: categoryId).get();
      final result = snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }catch(e) {
      throw 'Something went wrong , please try again';
    }
  }
// upload categories to the cloud fire store

  Future<String> getNextCategoryId() async {
    try {
      final querySnapshot = await _db.collection('Categories')
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

  Future<void> addCategory(CategoryModel category) async {
    try {
      final nextId = await getNextCategoryId();
      final newCategory = CategoryModel(
        id: nextId,
        name: category.name,
        image: category.image,
        isFeatured: category.isFeatured,
        parentId: category.parentId,
      );

      await _db.collection('Categories').doc(nextId).set(newCategory.toJson());
    } catch (e) {
      print('Error adding category: $e');
      throw e;
    }
  }


  Future<void> updateCategory(String id, CategoryModel category) async {
    try {
      await _db.collection('Categories').doc(id).update(category.toJson());
    } catch (e) {
      print('Error updating category: $e');
      throw e;
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _db.collection('Categories').doc(categoryId).delete();
    } catch (e) {
      print('Error deleting category: $e');
      throw e;
    }
  }

}