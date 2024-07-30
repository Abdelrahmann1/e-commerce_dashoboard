import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Brands/model.dart';

enum ProductType {
  single,
  variable
}

extension ProductTypeExtension on ProductType {
  String get stringValue => 'ProductType.${this.toString().split('.').last}';

  static ProductType fromString(String? value) {
    if (value == null || value.isEmpty) {
      print('Warning: Null or empty ProductType, defaulting to single');
      return ProductType.single;
    }

    final cleanValue = value.startsWith('ProductType.') ? value.split('.').last : value;

    switch (cleanValue.toLowerCase()) {
      case 'single':
        return ProductType.single;
      case 'variable':
        return ProductType.variable;
      default:
        print('Warning: Unknown ProductType "$value", defaulting to single');
        return ProductType.single;
    }
  }
}

// class ProductModel {
//   String id;
//   int stock;
//   String? sku;
//   double price;
//   String title;
//   DateTime? date;
//   double salePrice;
//   String thumbnail;
//   bool? isFeatured;
//   NewBrandModel? brand;
//   String? description;
//   String? categoryId;
//   List<String>? images;
//   ProductType productType;
//   List<ProductAttributeModel>? productAttributes;
//   List<ProductVariationModel>? productVariations;
//   List<ReviewModel>? reviews;
//
//   ProductModel({
//     required this.id,
//     required this.title,
//     required this.stock,
//     required this.price,
//     required this.thumbnail,
//     required this.productType,
//     this.sku,
//     this.date,
//     this.salePrice = 0.0,
//     this.isFeatured,
//     this.brand,
//     this.description,
//     this.categoryId,
//     this.images,
//     this.productAttributes,
//     this.productVariations,
//     this.reviews,
//   });
//
//   static ProductModel empty() => ProductModel(
//     id: '',
//     title: '',
//     stock: 0,
//     price: 0,
//     thumbnail: '',
//     productType: ProductType.single,
//   );
//
//   Map<String, dynamic> toJson() {
//     return {
//       'Title': title,
//       'Stock': stock,
//       'Price': price,
//       'Thumbnail': thumbnail,
//       'ProductType': productType.stringValue,
//       'SKU': sku,
//       'Date': date?.toIso8601String(),
//       'SalePrice': salePrice,
//       'IsFeatured': isFeatured,
//       'Brand': brand?.toJson(),
//       'Description': description,
//       'CategoryId': categoryId,
//       'Images': images,
//       'ProductAttributes': productAttributes?.map((e) => e.toJson()).toList(),
//       'ProductVariations': productVariations?.map((e) => e.toJson()).toList(),
//       'Reviews': reviews?.map((review) => review.toJson()).toList(),
//     };
//   }
//
//   factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//     if (!document.exists) return ProductModel.empty();
//
//     final data = document.data()!;
//     try {
//       return ProductModel(
//         id: document.id,
//         sku: data['SKU'],
//         title: data['Title'] ?? '',
//         stock: data['Stock'] ?? 0,
//         isFeatured: data['IsFeatured'],
//         price: (data['Price'] ?? 0.0).toDouble(),
//         salePrice: (data['SalePrice'] ?? 0.0).toDouble(),
//         thumbnail: data['Thumbnail'] ?? '',
//         categoryId: data['CategoryId'],
//         description: data['Description'],
//         productType: ProductTypeExtension.fromString(data['ProductType']),
//         brand: data['Brand'] != null ? NewBrandModel.fromJson(data['Brand']) : null,
//         images: data['Images'] != null ? List<String>.from(data['Images']) : null,
//         productAttributes: (data['ProductAttributes'] as List<dynamic>?)
//             ?.map((e) => ProductAttributeModel.fromMap(e))
//             .toList(),
//         productVariations: (data['ProductVariations'] as List<dynamic>?)
//             ?.map((e) => ProductVariationModel.fromJson(e))
//             .toList(),
//         reviews: (data['Reviews'] as List<dynamic>?)
//             ?.map((e) => ReviewModel.fromJson(e))
//             .toList(),
//       );
//     } catch (e) {
//       print('Error creating ProductModel from document ${document.id}: $e');
//       print('Raw data: $data');
//       return ProductModel.empty();
//     }
//   }
//
//   factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
//     final data = document.data() as Map<String, dynamic>;
//     try {
//       return ProductModel(
//         id: document.id,
//         sku: data['SKU'],
//         title: data['Title'] ?? '',
//         stock: data['Stock'] ?? 0,
//         isFeatured: data['IsFeatured'],
//         price: double.parse((data['Price'] ?? 0.0).toString()),
//         salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
//         thumbnail: data['Thumbnail'] ?? '',
//         categoryId: data['CategoryId'],
//         description: data['Description'],
//         productType: ProductTypeExtension.fromString(data['ProductType']),
//         brand: data['Brand'] != null ? NewBrandModel.fromJson(data['Brand']) : null,
//         images: data['Images'] != null ? List<String>.from(data['Images']) : null,
//         productAttributes: (data['ProductAttributes'] as List<dynamic>?)
//             ?.map((e) => ProductAttributeModel.fromJson(e))
//             .toList(),
//         productVariations: (data['ProductVariations'] as List<dynamic>?)
//             ?.map((e) => ProductVariationModel.fromJson(e))
//             .toList(),
//         reviews: (data['Reviews'] as List<dynamic>?)
//             ?.map((e) => ReviewModel.fromJson(e))
//             .toList(),
//       );
//     } catch (e) {
//       print('Error creating ProductModel from query document ${document.id}: $e');
//       print('Raw data: $data');
//       return ProductModel.empty();
//     }
//   }
//
//
// }

enum ProductCategory { all, outOfStock, limitedStock, otherStock }


class ProductModel {
  final String id;
  final RxInt stock;
  final RxString? sku;
  final RxDouble price;
  final RxString title;
  final Rx<DateTime?> date;
  final RxDouble salePrice;
  final RxString thumbnail;
  final RxBool? isFeatured;
  final Rx<NewBrandModel?> brand;
  final RxString? description;
  final RxString? categoryId;
  final RxList<String>? images;
  final Rx<ProductType> productType;
  final RxList<ProductAttributeModel>? productAttributes;
  final RxList<ProductVariationModel>? productVariations;
  final RxList<ReviewModel>? reviews;
  final RxMap<String, String> titleTranslations;
  final RxMap<String, String> descriptionTranslations;

  ProductModel({
    required this.id,
    required int stock,
    required double price,
    required String title,
    required String thumbnail,
    required ProductType productType,
    String? sku,
    DateTime? date,
    double salePrice = 0.0,
    bool? isFeatured,
    NewBrandModel? brand,
    String? description,
    String? categoryId,
    List<String>? images,
    List<ProductAttributeModel>? productAttributes,
    List<ProductVariationModel>? productVariations,
    List<ReviewModel>? reviews,
     Map<String, String>? titleTranslations,
     Map<String, String>? descriptionTranslations,
  }) :
        this.stock = stock.obs,
        this.sku = sku?.obs,
        this.price = price.obs,
        this.title = title.obs,
        this.date = date.obs,
        this.salePrice = salePrice.obs,
        this.thumbnail = thumbnail.obs,
        this.isFeatured = isFeatured?.obs,
        this.brand = brand.obs,
        this.description = description?.obs,
        this.categoryId = categoryId?.obs,
        this.images = images?.obs,
        this.productType = productType.obs,
        this.productAttributes = productAttributes?.obs,
        this.productVariations = productVariations?.obs,
        this.reviews = reviews?.obs,
  titleTranslations = RxMap<String, String>.from(titleTranslations!),
  descriptionTranslations = RxMap<String, String>.from(descriptionTranslations!);


  ProductCategory get category {
    if (stock.value == 0) {
      return ProductCategory.outOfStock;
    } else if (stock.value > 0 && stock.value <= 10) {
      return ProductCategory.limitedStock;
    } else {
      return ProductCategory.otherStock;
    }
  }

  static bool filterByCategory(ProductModel product, ProductCategory category) {
    switch (category) {
      case ProductCategory.all:
        return true;
      case ProductCategory.outOfStock:
        return product.stock.value == 0;
      case ProductCategory.limitedStock:
        return product.stock.value > 0 && product.stock.value <= 10;
      case ProductCategory.otherStock:
        return product.stock.value > 10;
      default:
        return false;
    }
  }


  static ProductModel empty() => ProductModel(
    id: '',
    title: '',
    stock: 0,
    price: 0,
    thumbnail: '',
    productType: ProductType.single,
  );

  void update(Map<String, dynamic> updates) {
    updates.forEach((key, value) {
      switch (key) {
        case 'Title':
          title.value = value;
          break;
        case 'Stock':
          stock.value = value;
          break;
        case 'Price':
          price.value = value;
          break;
        case 'Thumbnail':
          thumbnail.value = value;
          break;
        case 'ProductType':
          productType.value = ProductTypeExtension.fromString(value);
          break;
        case 'SKU':
          sku?.value = value;
          break;
        case 'Date':
          date.value = value != null ? DateTime.parse(value) : null;
          break;
        case 'SalePrice':
          salePrice.value = value;
          break;
        case 'IsFeatured':
          isFeatured?.value = value;
          break;
        case 'Brand':
          brand.value = value != null ? NewBrandModel.fromJson(value) : null;
          break;
        case 'Description':
          description?.value = value;
          break;
        case 'CategoryId':
          categoryId?.value = value;
          break;
        case 'Images':
          images?.value = List<String>.from(value);
          break;
        case 'ProductAttributes':
          productAttributes?.value = (value as List<dynamic>)
              .map((e) => ProductAttributeModel.fromJson(e))
              .toList();
          break;
        case 'ProductVariations':
          productVariations?.value = (value as List<dynamic>)
              .map((e) => ProductVariationModel.fromJson(e))
              .toList();
          break;
        case 'Reviews':
          reviews?.value = (value as List<dynamic>)
              .map((e) => ReviewModel.fromJson(e))
              .toList();
          break;
      }
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': title.value,
      'Stock': stock.value,
      'Price': price.value,
      'Thumbnail': thumbnail.value,
      'ProductType': productType.value.stringValue,
      'SKU': sku?.value,
      'Date': date.value?.toIso8601String(),
      'SalePrice': salePrice.value,
      'IsFeatured': isFeatured?.value,
      'Brand': brand.value?.toJson(),
      'Description': description?.value,
      'CategoryId': categoryId?.value,
      'Images': images?.value,
      'ProductAttributes': productAttributes?.map((e) => e.toJson()).toList(),
      'ProductVariations': productVariations?.map((e) => e.toJson()).toList(),
      'Reviews': reviews?.map((review) => review.toJson()).toList(),
       'TitleTranslations': titleTranslations,
      'DescriptionTranslations': descriptionTranslations,
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (!document.exists) return ProductModel.empty();

    final data = document.data()!;
    try {
      return ProductModel(
        id: document.id,
        sku: data['SKU'],
        title: data['Title'] ?? '',
        stock: data['Stock'] ?? 0,
        isFeatured: data['IsFeatured'],
        price: (data['Price'] ?? 0.0).toDouble(),
        salePrice: (data['SalePrice'] ?? 0.0).toDouble(),
        thumbnail: data['Thumbnail'] ?? '',
        categoryId: data['CategoryId'],
        description: data['Description'],
        productType: ProductTypeExtension.fromString(data['ProductType']),
        brand: data['Brand'] != null ? NewBrandModel.fromJson(data['Brand']) : null,
        images: data['Images'] != null ? List<String>.from(data['Images']) : null,
        productAttributes: (data['ProductAttributes'] as List<dynamic>?)
            ?.map((e) => ProductAttributeModel.fromMap(e))
            .toList(),
        productVariations: (data['ProductVariations'] as List<dynamic>?)
            ?.map((e) => ProductVariationModel.fromJson(e))
            .toList(),
        reviews: (data['Reviews'] as List<dynamic>?)
            ?.map((e) => ReviewModel.fromJson(e))
            .toList(),
        titleTranslations: Map<String, String>.from(data['titleTranslations'] ?? {}),
        descriptionTranslations: Map<String, String>.from(data['descriptionTranslations'] ?? {}),
      );
    } catch (e) {
      print('Error creating ProductModel from document ${document.id}: $e');
      print('Raw data: $data');
      return ProductModel.empty();
    }
  }

  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    try {
      return ProductModel(
        id: document.id,
        sku: data['SKU'],
        title: data['Title'] ?? '',
        stock: data['Stock'] ?? 0,
        isFeatured: data['IsFeatured'],
        price: double.parse((data['Price'] ?? 0.0).toString()),
        salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
        thumbnail: data['Thumbnail'] ?? '',
        categoryId: data['CategoryId'],
        description: data['Description'],
        productType: ProductTypeExtension.fromString(data['ProductType']),
        brand: data['Brand'] != null ? NewBrandModel.fromJson(data['Brand']) : null,
        images: data['Images'] != null ? List<String>.from(data['Images']) : null,
        productAttributes: (data['ProductAttributes'] as List<dynamic>?)
            ?.map((e) => ProductAttributeModel.fromJson(e))
            .toList(),
        productVariations: (data['ProductVariations'] as List<dynamic>?)
            ?.map((e) => ProductVariationModel.fromJson(e))
            .toList(),
        reviews: (data['Reviews'] as List<dynamic>?)
            ?.map((e) => ReviewModel.fromJson(e))
            .toList(),
        titleTranslations: Map<String, String>.from(data['titleTranslations'] ?? {}),
        descriptionTranslations: Map<String, String>.from(data['descriptionTranslations'] ?? {}),
      );
    } catch (e) {
      print('Error creating ProductModel from query document ${document.id}: $e');
      print('Raw data: $data');
      return ProductModel.empty();
    }
  }
}
//
class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  /// Json Format
  toJson() {
    return {'Name': name, 'Values': values};
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return ProductAttributeModel();

    return ProductAttributeModel(
      name: data.containsKey('Name') ? data['Name'] : '',
      values: List<String>. from(data['Values']),); // ProductAttributeModel
  }

  factory ProductAttributeModel.fromMap(Map<String, dynamic> map) {
    return ProductAttributeModel(
      name: map['Name'] as String,
      values: (map['Values'] as List).map((e) => e as String).toList(),
    );
  }
}
//


class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku='',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues
  });

  /// Create Empty Method for clean code
  static ProductVariationModel empty() => ProductVariationModel(id: '', attributeValues: {});

  /// json format
  toJson(){
    return {
      'Id': id,
      'SKU': sku,
      'Image': image,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttributeValues': attributeValues
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductVariationModel.fromJson(Map<String, dynamic> document){
    final data = document;
    if(data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      id: data['Id'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'] ?? '',
      stock: data['Stock'] ?? 0,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      image: data['Image'] ??'',
      attributeValues: Map<String, String>. from(data[ 'AttributeValues']),
    ); // ProductVariationModel
  }


  ProductVariationModel copyWith({
    String? id,
    int? stock,
    double? price,
    double? salePrice,
    String? image,
    String? description,
    Map<String, String>? attributeValues,
  }) {
    return ProductVariationModel(
      id: id ?? this.id,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      image: image ?? this.image,
      description: description ?? this.description,
      attributeValues: attributeValues ?? this.attributeValues,
    );
  }
}

//
class ReviewModel {
  final String reviewId;
  final String userId;
  final String review;
  final double rating;
  final DateTime timestamp;
  final String userFullName;
  final String userProfilePicture;

  ReviewModel({
    required this.reviewId,
    required this.userId,
    required this.review,
    required this.rating,
    required this.timestamp,
    required this.userFullName,
    required this.userProfilePicture,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json['reviewId'],
      userId: json['userId'],
      review: json['review'],
      rating: json['rating'].toDouble(),
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      userFullName: json['userFullName'] ?? '',
      userProfilePicture: json['userProfilePicture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewId': reviewId,
      'userId': userId,
      'review': review,
      'rating': rating,
      'timestamp': timestamp,
      'userFullName': userFullName,
      'userProfilePicture': userProfilePicture,
    };
  }

  ReviewModel copyWith({
    String? reviewId,
    String? userId,
    String? review,
    double? rating,
    DateTime? timestamp,
    String? userFullName,
    String? userProfilePicture,
  }) {
    return ReviewModel(
      reviewId: reviewId ?? this.reviewId,
      userId: userId ?? this.userId,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      timestamp: timestamp ?? this.timestamp,
      userFullName: userFullName ?? this.userFullName,
      userProfilePicture: userProfilePicture ?? this.userProfilePicture,
    );
  }
}

//
class NewBrandModel {
  final String id;
  final String name;
  final String image;
  int? productsCount;
  bool? isFeatured;

  NewBrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.productsCount,
    this.isFeatured,
  });

  // Empty Helper Method
  static NewBrandModel empty() => NewBrandModel(id: '', name: '', image: '');

  // Convert model to Json structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  // Map json oriented document snapshot from Firebase to User model
  factory NewBrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return NewBrandModel.empty();
    return NewBrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      productsCount: _parseProductsCount(data['ProductsCount']),
      isFeatured: data['IsFeatured'] ?? false,
    );
  }

  // Map Json oriented document snapshot from Firebase to UserModel
  factory NewBrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map JSON Record to the Model
      return NewBrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        productsCount: _parseProductsCount(data['ProductsCount']),
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return NewBrandModel.empty();
    }
  }

  factory NewBrandModel.fromQuerySnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return NewBrandModel(
      id: snapshot.id,
      image: data['Image'] ?? '',
      name: data['Name'] ?? '',
      productsCount: _parseProductsCount(data['ProductsCount']),
      isFeatured: data['IsFeatured'] ?? false,
    );
  }

  void incrementProductsCount() {
    productsCount = (productsCount ?? 0) + 1;
  }

  static int? _parseProductsCount(dynamic count) {
    if (count is int) {
      return count;
    } else if (count is String) {
      return int.tryParse(count);
    }
    return null;
  }
}