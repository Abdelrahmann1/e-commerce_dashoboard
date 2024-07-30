import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'model.dart';

// class AdminBannerController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final ImagePicker _picker = ImagePicker();
//
//   final TextEditingController targetScreenController = TextEditingController();
//   final RxBool active = false.obs;
//   final RxString imageUrl = ''.obs;
//   final Rx<File?> selectedImage = Rx<File?>(null);
//   final Rx<Uint8List?> selectedImageBytes = Rx<Uint8List?>(null);
//   RxList<BannerModel> banners = <BannerModel>[].obs;
//
//   final RxString targetScreenError = ''.obs;
//
//   var addPosterFormKey = GlobalKey<FormState>();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchBanners();
//   }
//
//   bool validateForm() {
//     bool isValid = true;
//
//     if (imageUrl.value.isEmpty) {
//       Get.snackbar('Error', 'Please select an image');
//       isValid = false;
//     }
//
//     if (targetScreenController.text.isEmpty) {
//       targetScreenError.value = 'Target Screen cannot be empty';
//       isValid = false;
//     } else {
//       targetScreenError.value = '';
//     }
//
//     return isValid;
//   }
//
//   Future<void> pickImage() async {
//     if (kIsWeb) {
//       final pickedBytes = await ImagePickerWeb.getImageAsBytes();
//       if (pickedBytes != null) {
//         selectedImageBytes.value = pickedBytes;
//         String downloadUrl = await uploadImageWeb(
//             pickedBytes, 'banner_${DateTime.now().millisecondsSinceEpoch}.jpg');
//         imageUrl.value = downloadUrl;
//       }
//     } else {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         selectedImage.value = File(pickedFile.path);
//         String downloadUrl = await uploadImage(selectedImage.value!,
//             'banner_${DateTime.now().millisecondsSinceEpoch}.jpg');
//         imageUrl.value = downloadUrl;
//       }
//     }
//   }
//   Future<int> getNextDocumentId() async {
//     final querySnapshot = await _firestore
//         .collection('Banners')
//         .orderBy('id', descending: true)
//         .limit(1)
//         .get();
//     if (querySnapshot.docs.isEmpty) {
//       return 1;
//     } else {
//       final lastId = querySnapshot.docs.first.data()['id'] as int;
//       return lastId + 1;
//     }
//   }
//   Future<void> addBanner() async {
//     if (validateForm()) {
//       try {
//         final nextId = await getNextDocumentId();
//
//         final banner = BannerModel(
//           imageUrl: imageUrl.value,
//           targetScreen: '/${targetScreenController.text}',
//           active: active.value,
//         );
//
//         await _firestore.collection('Banners').doc(nextId.toString()).set({
//           'id': nextId,
//           ...banner.toJson(),
//         });
//
//         Get.snackbar('Success', 'Banner added successfully');
//         fetchBanners();
//
//         targetScreenController.clear();
//         active.value = false;
//         imageUrl.value = '';
//         selectedImage.value = null;
//         selectedImageBytes.value = null;
//       } catch (e) {
//         Get.snackbar('Error', 'Failed to add Banner: $e');
//       }
//     }
//   }
//
//   Future<void> updateBanner(String id) async {
//     if (validateForm()) {
//       try {
//         await _firestore.collection('Banners').doc(id).update({
//           'imageUrl': imageUrl.value,
//           'targetScreen': '/${targetScreenController.text}',
//           'active': active.value,
//         });
//
//         Get.snackbar('Success', 'Banner updated successfully');
//         fetchBanners();
//       } catch (e) {
//         Get.snackbar('Error', 'Failed to update Banner: $e');
//       }
//     }
//   }
//
//   Future<void> deleteBanner(String id) async {
//     try {
//       await _firestore.collection('Banners').doc(id).delete();
//       Get.snackbar('Success', 'Banner deleted successfully');
//       fetchBanners();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to delete Banner: $e');
//     }
//   }
//
//   void fetchBanners() {
//     _firestore.collection('Banners').snapshots().listen((snapshot) {
//       banners.value = snapshot.docs.map((doc) {
//         return BannerModel.fromSnapshot(doc);
//       }).toList();
//     });
//   }
//
//   Future<String> uploadImage(File file, String fileName) async {
//     try {
//       final ref = _storage.ref().child('banners').child(fileName);
//       await ref.putFile(file);
//       return await ref.getDownloadURL();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to upload image: $e');
//       return '';
//     }
//   }
//
//   Future<String> uploadImageWeb(Uint8List bytes, String fileName) async {
//     try {
//       final ref = _storage.ref().child('banners').child(fileName);
//       await ref.putData(bytes);
//       return await ref.getDownloadURL();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to upload image: $e');
//       return '';
//     }
//   }
// }

class AdminBannerController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController targetScreenController = TextEditingController();
  final RxBool active = false.obs;
  final RxString imageUrl = ''.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<Uint8List?> selectedImageBytes = Rx<Uint8List?>(null);
  RxList<BannerModel> banners = <BannerModel>[].obs;
  var addPosterFormKey = GlobalKey<FormState>();
  final RxString targetScreenError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  bool validateForm() {
    bool isValid = true;

    if (imageUrl.value.isEmpty) {
      Get.snackbar('Error', 'Please select an image');
      isValid = false;
    }

    if (targetScreenController.text.isEmpty) {
      targetScreenError.value = 'Target Screen cannot be empty';
      isValid = false;
    } else {
      targetScreenError.value = '';
    }

    return isValid;
  }

  Future<void> pickImage() async {
    if (kIsWeb) {
      final pickedBytes = await ImagePickerWeb.getImageAsBytes();
      if (pickedBytes != null) {
        selectedImageBytes.value = pickedBytes;
        String downloadUrl = await uploadImageWeb(
            pickedBytes, 'banner_${DateTime.now().millisecondsSinceEpoch}.jpg');
        imageUrl.value = downloadUrl;
      }
    } else {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        String downloadUrl = await uploadImage(selectedImage.value!,
            'banner_${DateTime.now().millisecondsSinceEpoch}.jpg');
        imageUrl.value = downloadUrl;
      }
    }
  }

  Future<void> addBanner() async {
    if (validateForm()) {
      try {
        final newBannerRef = _firestore.collection('Banners').doc();
        final banner = BannerModel(
          id: newBannerRef.id,
          imageUrl: imageUrl.value,
          targetScreen: '/${targetScreenController.text}',
          active: active.value,
        );

        await newBannerRef.set(banner.toJson());

        Get.snackbar('Success', 'Banner added successfully');
        fetchBanners();

        targetScreenController.clear();
        active.value = false;
        imageUrl.value = '';
        selectedImage.value = null;
        selectedImageBytes.value = null;
      } catch (e) {
        Get.snackbar('Error', 'Failed to add Banner: $e');
      }
    }
  }

  Future<void> updateBanner(String id) async {
    if (validateForm()) {
      try {
        final bannerRef = _firestore.collection('Banners').doc(id);
        final banner = BannerModel(
          id: id,
          imageUrl: imageUrl.value,
          targetScreen: '/${targetScreenController.text}',
          active: active.value,
        );

        await bannerRef.update(banner.toJson());

        Get.snackbar('Success', 'Banner updated successfully');
        fetchBanners();

        targetScreenController.clear();
        active.value = false;
        imageUrl.value = '';
        selectedImage.value = null;
        selectedImageBytes.value = null;
      } catch (e) {
        Get.snackbar('Error', 'Failed to update Banner: $e');
      }
    }
  }

  Future<void> deleteBanner(String id) async {
    try {
      await _firestore.collection('Banners').doc(id).delete();
      Get.snackbar('Success', 'Banner deleted successfully');
      fetchBanners();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete Banner: $e');
    }
  }

  void fetchBanners() {
    _firestore.collection('Banners').snapshots().listen((snapshot) {
      banners.value = snapshot.docs.map((doc) {
        return BannerModel.fromSnapshot(doc);
      }).toList();
    });
  }

  Future<String> uploadImage(File file, String fileName) async {
    try {
      final ref = _storage.ref().child('banners').child(fileName);
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
      return '';
    }
  }

  Future<String> uploadImageWeb(Uint8List bytes, String fileName) async {
    try {
      final ref = _storage.ref().child('banners').child(fileName);
      await ref.putData(bytes);
      return await ref.getDownloadURL();
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
      return '';
    }
  }
}

