// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class BannerModel
// {
//   String imageUrl;
//   final String targetScreen;
//   final bool active;
//
//   BannerModel({required this.imageUrl, required this.targetScreen, required this.active});
//
//   Map<String,dynamic> toJson()
//   {
//     return {
//       "imageUrl": imageUrl,
//       "targetScreen": targetScreen,
//       "active": active
//     };
//   }
//
//   factory BannerModel.fromSnapshot(DocumentSnapshot snapshot){
//     final data = snapshot.data() as Map<String,dynamic>;
//     return BannerModel(
//         imageUrl: data['imageUrl']??'',
//         targetScreen: data['targetScreen']??'',
//         active: data['active']??false
//     );
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String id;
  final String imageUrl;
  final String targetScreen;
  final bool active;

  BannerModel({
    required this.id,
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "imageUrl": imageUrl,
      "targetScreen": targetScreen,
      "active": active,
    };
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      id: snapshot.id,
      imageUrl: data['imageUrl'] ?? '',
      targetScreen: data['targetScreen'] ?? '',
      active: data['active'] ?? false,
    );
  }
}
