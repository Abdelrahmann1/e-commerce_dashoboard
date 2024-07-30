import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/constants_helpers.dart';
import 'model.dart';

class BannersRepository extends GetxController {
  static BannersRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get all banners related to the current user
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db.collection('Banners').where('active', isEqualTo: true).get();
      return result.docs.map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  // Upload banner to the Cloud Firestore
  Future<void> addBanner(BannerModel banner) async {
    try {
      final nextId = await getNextDocumentId();
      await _db.collection('Banners').doc(nextId.toString()).set({
        'id': nextId,
        ...banner.toJson(),
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to add banner: $e';
    }
  }

  // Update banner in the Cloud Firestore
  Future<void> updateBanner(String id, Map<String, dynamic> data) async {
    try {
      await _db.collection('Banners').doc(id).update(data);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to update banner: $e';
    }
  }

  // Delete banner from the Cloud Firestore
  Future<void> deleteBanner(String id) async {
    try {
      await _db.collection('Banners').doc(id).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to delete banner: $e';
    }
  }

  Future<int> getNextDocumentId() async {
    final querySnapshot = await _db
        .collection('Banners')
        .orderBy('id', descending: true)
        .limit(1)
        .get();
    if (querySnapshot.docs.isEmpty) {
      return 1;
    } else {
      final lastId = querySnapshot.docs.first.data()['id'] as int;
      return lastId + 1;
    }
  }
}
