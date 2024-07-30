

import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel
{
  final String id;
  final String name;
  final String image;
  int? productsCount;
  bool? isFeatured;

  BrandModel({
    required this.id,
    required this.name,
    required this.image ,
    this.productsCount,
    this.isFeatured
  });

  // -- Empty Helper Method
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  /// Convert model to Json structure so that you con store data in Firebase
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image':image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  // -- Map json oriented document snapshot from Firebase to User model
  factory BrandModel.fromJson(Map<String, dynamic> document){
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id']?? '',
      name: data['Name']??'',
      image: data['Image']?? '',
      productsCount :int.parse((data['ProductsCount'] ?? 0).toString()),
      isFeatured: data['IsFeatured']?? false,
    );

  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if (document.data() != null){
      final data = document.data() !;

// Map JSON Record to the Model
      return BrandModel(
        id: document.id,
        name: data['Name']??'',
        image: data['Image']?? '',
        productsCount: data['ProductsCount'] ?? 0,
        isFeatured: data['IsFeatured']?? false,
      );

    }else{
      return BrandModel.empty();
    }
  }


  factory BrandModel.fromQuerySnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BrandModel(
      id: snapshot.id,
      image: data['image'] ?? '',
      name: data['name'] ?? '',
      productsCount: data['productsCount'] ?? 0,
      isFeatured: data['isFeatured'],
    );
  }

  void incrementProductsCount() {
    productsCount = (productsCount ?? 0) + 1;
  }

  factory BrandModel.fromSnapshotss(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return BrandModel(
      id: document.id,
      name: data?['Name'] ?? '',
      image: data?['Image'] ?? '',
      productsCount: int.tryParse(data?['ProductsCount']?.toString() ?? '0') ?? 0,
      isFeatured: data?['IsFeatured'] ?? false,
    );
  }

}