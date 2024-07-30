
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Getx/Products/new_controller.dart';

class ImagePickerWidgets extends StatelessWidget {
  final NewAdminPanelController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Thumbnail Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                ProductImageCards(
                  labelText: 'Thumbnail',
                  imageFile: controller.thumbnailImage.value != null
                      ? File.fromRawPath(controller.thumbnailImage.value!)
                      : null,
                  imageUint8List: controller.thumbnailImage.value,
                  onTap: () async {
                    await controller.selectThumbnailImageurl();
                  },
                  onRemoveImage: controller.thumbnailImage.value != null
                      ? () {
                    controller.thumbnailImage.value = null;
                  }
                      : null,
                ),
              ],
            );
          }),
          SizedBox(height: 16),
          Text('Product Images', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Obx(() {
            final List<Widget> productImageCards = [
              ...controller.productImages.entries.map((entry) {
                return ProductImageCards(
                  labelText: 'Product Image',
                  imageFile: File.fromRawPath(entry.value),
                  imageUint8List: entry.value,
                  onTap: () {
                    // Handle tap on existing product image if needed
                  },
                  onRemoveImage: () {
                    controller.productImages.remove(entry.key);
                  },
                );
              }).toList(),
              Padding(
                padding: const EdgeInsets.only(right: 32),
                child: ProductImageCards(
                  labelText: 'Add Product Image',
                  onTap: () async {
                    await controller.selectProductImages();
                  },
                ),
              ),
            ];

            return LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = (constraints.maxWidth / 150).floor();
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: productImageCards.length,
                  itemBuilder: (context, index) => productImageCards[index],
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
class ProductImageCards extends StatelessWidget {
  final String labelText;
  final String? imageUrlForUpdateImage;
  final File? imageFile;
  final Uint8List? imageUint8List;
  final VoidCallback onTap;
  final VoidCallback? onRemoveImage;

  const ProductImageCards({
    Key? key,
    required this.labelText,
    this.imageFile,
    this.imageUint8List,
    required this.onTap,
    this.imageUrlForUpdateImage,
    this.onRemoveImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          child: Container(
            height: 130,
            width: size.width * 0.12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (imageUint8List != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        imageUint8List!,
                        width: double.infinity,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                  else if (imageFile != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? Image.network(
                        imageFile?.path ?? '',
                        width: double.infinity,
                        height: 80,
                        fit: BoxFit.cover,
                      )
                          : Image.file(
                        imageFile!,
                        width: double.infinity,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                  else if (imageUrlForUpdateImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrlForUpdateImage ?? '',
                          width: double.infinity,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Icon(Icons.camera_alt, size: 50, color: Colors.grey[600]),
                  SizedBox(height: 8),
                  Text(
                    textAlign: TextAlign.center,
                    labelText,

                    style: TextStyle(

                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if ((imageUint8List != null || imageFile != null) && onRemoveImage != null)
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: onRemoveImage,
            ),
          ),
      ],
    );
  }
}
