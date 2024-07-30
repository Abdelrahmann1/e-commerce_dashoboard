



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'new_controller.dart';

// class TranslationForm extends StatelessWidget {
//   final NewAdminPanelController productController = Get.find<NewAdminPanelController>();
//   final TextEditingController languageCodeController = TextEditingController();
//   final TextEditingController titleTranslationController = TextEditingController();
//   final TextEditingController descriptionTranslationController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//         left: 20,
//         right: 20,
//         top: 20,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: languageCodeController,
//             decoration: InputDecoration(labelText: 'Language Code (e.g., en, fr, es)'),
//           ),
//           TextField(
//             controller: titleTranslationController,
//             decoration: InputDecoration(labelText: 'Title Translation'),
//           ),
//           TextField(
//             controller: descriptionTranslationController,
//             decoration: InputDecoration(labelText: 'Description Translation'),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               final languageCode = languageCodeController.text.trim();
//               final title = titleTranslationController.text.trim();
//               final description = descriptionTranslationController.text.trim();
//
//               if (languageCode.isNotEmpty && title.isNotEmpty && description.isNotEmpty) {
//                 productController.titleTranslations[languageCode] = title;
//                 productController.descriptionTranslations[languageCode] = description;
//
//                 languageCodeController.clear();
//                 titleTranslationController.clear();
//                 descriptionTranslationController.clear();
//                 Get.back();
//               } else {
//                 Get.snackbar('Error', 'Please fill all the fields',
//                     backgroundColor: Colors.red, colorText: Colors.white);
//               }
//             },
//             child: Text('Add Translation'),
//           ),
//         ],
//       ),
//     );
//   }
// }


class TranslationForm extends StatelessWidget {
  final NewAdminPanelController productController = Get.find<NewAdminPanelController>();
  final TextEditingController languageCodeController = TextEditingController();
  final TextEditingController titleTranslationController = TextEditingController();
  final TextEditingController descriptionTranslationController = TextEditingController();

  final Color bgColor;

  TranslationForm({required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: languageCodeController,
                decoration: InputDecoration(
                  labelText: 'Language Code (e.g., en, fr, es)',
                  prefixIcon: Icon(Icons.language),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
              ),
              SizedBox(height: 10),
              TextField(
                controller: titleTranslationController,
                decoration: InputDecoration(
                  labelText: 'Title Translation',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionTranslationController,
                decoration: InputDecoration(
                  labelText: 'Description Translation',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final languageCode = languageCodeController.text.trim();
                  final title = titleTranslationController.text.trim();
                  final description = descriptionTranslationController.text.trim();

                  if (languageCode.isNotEmpty && title.isNotEmpty && description.isNotEmpty) {
                    productController.titleTranslations[languageCode] = title;
                    productController.descriptionTranslations[languageCode] = description;

                    languageCodeController.clear();
                    titleTranslationController.clear();
                    descriptionTranslationController.clear();
                    Get.back();
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please fill all the fields',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      icon: Icon(Icons.error, color: Colors.white),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Add Translation', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}