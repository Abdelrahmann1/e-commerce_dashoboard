// class SubCategoryModel {
//   String id;
//   String name;
//   String image;
//   bool isFeatured;
//   String parentId;
//
//   SubCategoryModel({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.isFeatured,
//     required this.parentId,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'Id': id,
//       'Name': name,
//       'Image': image,
//       'IsFeatured': isFeatured,
//       'ParentId': parentId,
//     };
//   }
//
//   factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
//     return SubCategoryModel(
//       id: json['Id'] as String,
//       name: json['Name'] as String,
//       image: json['Image'] as String,
//       isFeatured: json['IsFeatured'] as bool,
//       parentId: json['ParentId'] as String,
//     );
//   }
// }



class SubCategoryModel {
  String id;
  String name;
  String parentId;
  String image;
  bool isFeatured;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.parentId,
    required this.image,
    this.isFeatured = false,
  });

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      id: map['Id'],
      name: map['Name'],
      parentId: map['ParentId'],
      image: map['Image'],
      isFeatured: map['IsFeatured'] ?? false,
    );
  }
}