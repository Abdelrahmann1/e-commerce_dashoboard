// // // import 'dart:io';
// // // import 'package:flutter/foundation.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:image_picker/image_picker.dart';
// // //
// // // class CategoryImageCard extends StatelessWidget {
// // //   final String labelText;
// // //   final String? imageUrlForUpdateImage;
// // //   final File? imageFile;
// // //   final VoidCallback onTap;
// // //
// // //   const CategoryImageCard({
// // //     super.key,
// // //     required this.labelText,
// // //     this.imageFile,
// // //     required this.onTap,
// // //     this.imageUrlForUpdateImage,
// // //   });
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     print(imageFile);
// // //     var size = MediaQuery.of(context).size;
// // //     return GestureDetector(
// // //       onTap: onTap,
// // //       child: Card(
// // //         child: Container(
// // //           height: 130,
// // //           width: size.width * 0.12,
// // //           decoration: BoxDecoration(
// // //             borderRadius: BorderRadius.circular(8),
// // //             color: Colors.grey[200],
// // //           ),
// // //           child: Column(
// // //             mainAxisAlignment: MainAxisAlignment.center,
// // //             children: <Widget>[
// // //               if (imageFile != null)
// // //                 ClipRRect(
// // //                   borderRadius: BorderRadius.circular(8),
// // //                   child: kIsWeb
// // //                       ? Image.network(
// // //                           imageFile?.path ?? '',
// // //                           width: double.infinity,
// // //                           height: 80,
// // //                           fit: BoxFit.cover,
// // //                         )
// // //                       : Image.file(
// // //                           imageFile!,
// // //                           width: double.infinity,
// // //                           height: 80,
// // //                           fit: BoxFit.cover,
// // //                         ),
// // //                 )
// // //               else if ( imageUrlForUpdateImage != null)
// // //                 ClipRRect(
// // //                   borderRadius: BorderRadius.circular(8),
// // //                   child: Image.network(
// // //                     imageUrlForUpdateImage ?? '',
// // //                     width: double.infinity,
// // //                     height: 80,
// // //                     fit: BoxFit.cover,
// // //                   )
// // //                 )
// // //               else
// // //                 Icon(Icons.camera_alt, size: 50, color: Colors.grey[600]),
// // //               SizedBox(height: 8),
// // //               Text(
// // //                 labelText,
// // //                 style: TextStyle(
// // //                   fontSize: 14,
// // //                   color: Colors.grey[800],
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// // import 'dart:io';
// //
// // import 'package:flutter/material.dart';
// //
// // class CategoryImageCard extends StatelessWidget {
// //   final String labelText;
// //   final File? imageFile;
// //   final String? imageUrlForUpdateImage;
// //   final VoidCallback onTap;
// //
// //   const CategoryImageCard({
// //     Key? key,
// //     required this.labelText,
// //     this.imageFile,
// //     this.imageUrlForUpdateImage,
// //     required this.onTap,
// //   }) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         height: 150,
// //         width: 150,
// //         decoration: BoxDecoration(
// //           border: Border.all(color: Colors.grey),
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         child: imageFile != null
// //             ? Image.file(
// //           imageFile!,
// //           fit: BoxFit.cover,
// //         )
// //             : (imageUrlForUpdateImage != null && imageUrlForUpdateImage!.isNotEmpty)
// //             ? Image.network(
// //           imageUrlForUpdateImage!,
// //           fit: BoxFit.cover,
// //           errorBuilder: (context, error, stackTrace) {
// //             return Icon(
// //               Icons.camera_alt,
// //               size: 50,
// //               color: Colors.grey[600],
// //             );
// //           },
// //         )
// //             : Center(
// //           child: Icon(
// //             Icons.camera_alt,
// //             size: 50,
// //             color: Colors.grey[600],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'dart:io';
//
// class CategoryImageCard extends StatelessWidget {
//   final String labelText;
//   final File? imageFile;
//   final String? imageUrlForUpdateImage;
//   final VoidCallback onTap;
//
//   const CategoryImageCard({
//     Key? key,
//     required this.labelText,
//     this.imageFile,
//     this.imageUrlForUpdateImage,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         height: 150,
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey[400]!),
//         ),
//         child: imageFile != null
//             ? kIsWeb
//             ? Image.network(
//           imageFile!.path,
//           fit: BoxFit.cover,
//         )
//             : Image.file(
//           imageFile!,
//           fit: BoxFit.cover,
//         )
//             : imageUrlForUpdateImage != null
//             ? Image.network(
//           imageUrlForUpdateImage!,
//           fit: BoxFit.cover,
//         )
//             : Center(
//           child: Icon(
//             Icons.camera_alt,
//             size: 50,
//             color: Colors.grey[600],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:io';

class CategoryImageCard extends StatelessWidget {
  final String labelText;
  final File? imageFile;
  final String? imageUrlForUpdateImage;
  final VoidCallback onTap;

  const CategoryImageCard({
    Key? key,
    required this.labelText,
    this.imageFile,
    this.imageUrlForUpdateImage,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: imageFile != null
            ? kIsWeb
            ? Image.network(
          imageFile!.path,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.camera_alt,
                size: 50,
                color: Colors.grey[600],
              ),
            );
          },
        )
            : Image.file(
          imageFile!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.camera_alt,
                size: 50,
                color: Colors.grey[600],
              ),
            );
          },
        )
            : imageUrlForUpdateImage != null
            ? Image.network(
          imageUrlForUpdateImage!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.camera_alt,
                size: 50,
                color: Colors.grey[600],
              ),
            );
          },
        )
            : Center(
          child: Icon(
            Icons.camera_alt,
            size: 50,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
