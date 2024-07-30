// import 'dart:io';
//
// import 'package:image_picker/image_picker.dart';
//
// import '../provider/poster_provider.dart';
// import '../../../utility/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import '../../../models/poster.dart';
// import '../../../utility/constants.dart';
// import '../../../widgets/category_image_card.dart';
// import '../../../widgets/custom_text_field.dart';
//
// class PosterSubmitForm extends StatelessWidget {
//   final Poster? poster;
//
//   const PosterSubmitForm({super.key, this.poster});
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     context.posterProvider.setDataForUpdatePoster(poster);
//     return SingleChildScrollView(
//       child: Form(
//         key: context.posterProvider.addPosterFormKey,
//         child: Container(
//           padding: EdgeInsets.all(defaultPadding),
//           width: size.width * 0.3,
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Gap(defaultPadding),
//               Consumer<PosterProvider>(
//                 builder: (context, posterProvider, child) {
//                   return CategoryImageCard(
//                     labelText: "Poster",
//                     imageFile: posterProvider.selectedImage,
//                     imageUrlForUpdateImage: poster?.imageUrl,
//                     onTap: () {
//                       posterProvider.pickImage();
//                     },
//                   );
//                 },
//               ),
//               Gap(defaultPadding),
//               CustomTextField(
//                 controller: context.posterProvider.posterNameCtrl,
//                 labelText: 'Poster Name',
//                 onSave: (val) {},
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a poster name';
//                   }
//                   return null;
//                 },
//               ),
//               Gap(defaultPadding * 2),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: secondaryColor,
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the popup
//                     },
//                     child: Text('Cancel'),
//                   ),
//                   Gap(defaultPadding),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: primaryColor,
//                     ),
//                     onPressed: () {
//                       // Validate and save the form
//                       if (context.posterProvider.addPosterFormKey.currentState!.validate()) {
//                         context.posterProvider.addPosterFormKey.currentState!.save();
//                         //TODO: should complete call submitPoster
//                         Navigator.of(context).pop();
//                       }
//                     },
//                     child: Text('Submit'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // How to show the category popup
// void showAddPosterForm(BuildContext context, Poster? poster) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: bgColor,
//         title: Center(child: Text('Add Poster'.toUpperCase(), style: TextStyle(color: primaryColor))),
//         content: PosterSubmitForm(poster: poster),
//       );
//     },
//   );
// }


import 'package:admin/Getx/Banners/model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../Getx/Banners/controller.dart';
import '../../../utility/constants.dart';
import '../../../widgets/category_image_card.dart';
import '../../../widgets/custom_text_field.dart';

// class PosterSubmitForm extends StatelessWidget {
//   final BannerModel? poster;
//
//   const PosterSubmitForm({Key? key, this.poster}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     final AdminBannerController bannerController = Get.put(AdminBannerController());
//
//     if (poster != null) {
//       bannerController.targetScreenController.text = poster!.targetScreen ?? '';
//       bannerController.imageUrl.value = poster!.imageUrl ?? '';
//       bannerController.active.value = poster!.active ?? false;
//     }
//
//     return SingleChildScrollView(
//       child: Form(
//         key: bannerController.addPosterFormKey,
//         child: Container(
//           padding: EdgeInsets.all(defaultPadding),
//           width: size.width * 0.3,
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Gap(defaultPadding),
//               Obx(() {
//                 return CategoryImageCard(
//                   labelText: "Poster",
//                   imageFile: bannerController.selectedImage.value,
//                   imageUrlForUpdateImage: bannerController.imageUrl.value,
//                   onTap: () {
//                     bannerController.pickImage();
//                   },
//                 );
//               }),
//               Gap(defaultPadding),
//               CustomTextField(
//                 controller: bannerController.targetScreenController,
//                 labelText: 'Poster Name',
//                 onSave: (val) {},
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a poster name';
//                   }
//                   return null;
//                 },
//               ),
//               Gap(defaultPadding * 2),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: secondaryColor,
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the popup
//                     },
//                     child: Text('Cancel'),
//                   ),
//                   Gap(defaultPadding),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: primaryColor,
//                     ),
//                     onPressed: () async {
//                       if (bannerController.addPosterFormKey.currentState!.validate()) {
//                         bannerController.addPosterFormKey.currentState!.save();
//                         if (poster != null) {
//                           await bannerController.updateBanner(poster!.id!);
//                         } else {
//                           await bannerController.addBanner();
//                         }
//                         Navigator.of(context).pop();
//                       }
//                     },
//                     child: Text('Submit'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class PosterSubmitForm extends StatelessWidget {
  final BannerModel? poster;

  const PosterSubmitForm({Key? key, this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final AdminBannerController bannerController = Get.put(AdminBannerController());

    if (poster != null) {
      bannerController.targetScreenController.text = poster!.targetScreen;

      bannerController.imageUrl.value = poster!.imageUrl;
      bannerController.active.value = poster!.active;
    }

    return SingleChildScrollView(
      child: Form(
        key: bannerController.addPosterFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: size.width * 0.3,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(defaultPadding),
              Obx(() {
                return CategoryImageCard(
                  labelText: "Poster",
                  imageFile: bannerController.selectedImage.value,
                  imageUrlForUpdateImage: bannerController.imageUrl.value,
                  onTap: () {
                    bannerController.pickImage();
                  },
                );
              }),
              Gap(defaultPadding),
              CustomTextField(
                controller: bannerController.targetScreenController,
                labelText: 'Poster Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a poster name';
                  }
                  return null;
                },
              ),
              Gap(defaultPadding),
              Obx(() => CheckboxListTile(
                title: Text("Active"),
                value: bannerController.active.value,
                onChanged: (value) {
                  bannerController.active.value = value ?? false;
                },
              )),

              Gap(defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: Text('Cancel'),
                  ),
                  Gap(defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () async {
                      if (bannerController.addPosterFormKey.currentState!.validate()) {
                        bannerController.addPosterFormKey.currentState!.save();
                        if (poster != null) {
                          await bannerController.updateBanner(poster!.id);
                        } else {
                          await bannerController.addBanner();
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void showAddPosterForm(BuildContext context, BannerModel? poster) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(child: Text('Add Poster'.toUpperCase(), style: TextStyle(color: primaryColor))),
        content: PosterSubmitForm(poster: poster),
      );
    },
  );
}

