import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../Categories/model.dart';
import '../Orders/enum.dart';
import 'models.dart';
class NewAdminPanelController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Text editing controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  final TextEditingController thumbnailUrlController = TextEditingController();

  // Brands list
  RxList<NewBrandModel> brands = RxList<NewBrandModel>([]);
  RxList<NewBrandModel> filteredBrands = RxList<NewBrandModel>([]);
  Rx<NewBrandModel?> selectedBrand = Rx<NewBrandModel?>(null);

  // Product type
  Rx<ProductType> selectedProductType = ProductType.single.obs;

  // Rx variables for images
  RxList<File?> selectedImages = RxList<File?>([]);
  Rx<bool> isFeatured = Rx<bool>(false);

  // Uploaded image URLs
  RxString thumbnailUrl = ''.obs;





  // ImagePicker instance
  final ImagePicker _picker = ImagePicker();

  /// New Images Methods #######################################
  ///
  ///
  // Updated image handling variables
// Updated image handling variables


  // Rxn variables for image URLs
  var thumbnailImageUrl = Rxn<dynamic>();
  var secondImageUrl = Rxn<dynamic>();
  var thirdImageUrl = Rxn<dynamic>();
  var fourthImageUrl = Rxn<dynamic>();
  var fifthImageUrl = Rxn<dynamic>();
  Rx<dynamic> thumbnailImage = Rx<dynamic>(null);
  // RxList<dynamic> productImages = RxList<dynamic>([]);
  var productImages = <String, Uint8List>{}.obs; // Map to store images with unique IDs
  // RxMap<String, dynamic> variationImages = RxMap<String, dynamic>({});
  final RxMap<String, Uint8List?> variationImages = RxMap<String, Uint8List?>();

  var addProductFormKey = GlobalKey<FormState>();
  Future<void> selectThumbnailImageurl() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (kIsWeb) {
          thumbnailImage.value = await pickedFile.readAsBytes();
        } else {
          thumbnailImage.value = File(pickedFile.path);
        }
      }
    } catch (e) {
      print('Error selecting thumbnail image: $e');
    }
  }



  Future<void> selectProductImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        final images = <String, Uint8List>{};
        if (kIsWeb) {
          for (var file in pickedFiles) {
            String uniqueId = UniqueKey().toString();
            images[uniqueId] = await file.readAsBytes();
          }
        } else {
          for (var file in pickedFiles) {
            String uniqueId = UniqueKey().toString();
            images[uniqueId] = await File(file.path).readAsBytes();
          }
        }
        productImages.addAll(images); // Add new images to the map
      }
    } catch (e) {
      print('Error selecting product images: $e');
    }
  }






  Future<void> selectVariationImage(String variationId) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery); // Single image
      if (pickedFile != null) {
        final imageBytes = await _getImageBytes(pickedFile);
        variationImages[variationId] = imageBytes; // Store image bytes for each variation ID
        update(); // Ensure UI updates
      }
    } catch (e) {
      print('Error selecting variation image: $e');
    }
  }

  Future<Uint8List> _getImageBytes(XFile xFile) async {
    return await xFile.readAsBytes();
  }


  Future<File> convertUint8ListToFile(Uint8List uint8list) async {
    try {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/${UniqueKey().toString()}.png';
      final file = File(filePath);
      await file.writeAsBytes(uint8list);
      return file;
    } catch (e) {
      print('Error converting Uint8List to file: $e');
      rethrow;
    }
  }
  Future<void> uploadVariationImages() async {
    for (var variation in productVariations) {
      if (variationImages.containsKey(variation.id)) {
        String url = await uploadImageToFirebase(variationImages[variation.id], 'variation_images');
        if (url.isNotEmpty) {
          variation.image = url;
        }
      }
    }
  }

  // Updated method to upload images to Firebase Storage
  Future<String> uploadImageToFirebase(dynamic image, String folder) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}_${UniqueKey().toString()}';
      Reference ref = _storage.ref().child(folder).child(fileName);

      TaskSnapshot uploadTask;
      if (kIsWeb) {
        if (image is Uint8List) {
          uploadTask = await ref.putData(image);
        } else {
          throw Exception('Invalid image data for web upload');
        }
      } else {
        if (image is File) {
          uploadTask = await ref.putFile(image);
        } else {
          throw Exception('Invalid image data for mobile upload');
        }
      }

      String downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }




  ///
  ///
  ///
  ///
  /// New Images Methods #######################################

  /// ---------- Attributes  & Variations
  ///
  // New variables for product attributes and variations

  // new -------------------------------------------------------

  final Rx<String?> selectedAttributeType = Rx<String?>(null);
  final Rx<String?> selectedColorValue = Rx<String?>(null);

  final TextEditingController attributeNameController = TextEditingController();
  final TextEditingController attributeValueController =
  TextEditingController();
  final TextEditingController sizeInputController = TextEditingController();

  var selectedSizes;

  var selectedColors;

  void setAttributeType(String? type) {
    selectedAttributeType.value = type;
    attributeNameController.text = type ?? '';
  }

  void setColorValue(String? value) {
    selectedColorValue.value = value;
    if (value != null) {
      attributeValueController.text = value;
    }
  }

  void addAttribute() {
    if (attributeNameController.text.isNotEmpty &&
        attributeValueController.text.isNotEmpty) {
      productAttributes.add(ProductAttributeModel(
        name: attributeNameController.text,
        values: [attributeValueController.text],
      ));
      attributeValueController.clear();
      sizeInputController.clear();
    }
  }

  // new -------------------------------------------------------

  RxList<ProductAttributeModel> productAttributes =
  RxList<ProductAttributeModel>([]);
  RxList<ProductVariationModel> productVariations =
  RxList<ProductVariationModel>([]);



  final TextEditingController variationIdController = TextEditingController();
  final TextEditingController variationStockController =
  TextEditingController();
  final TextEditingController variationPriceController =
  TextEditingController();
  final TextEditingController variationSalePriceController =
  TextEditingController();
  final TextEditingController variationDescriptionController =
  TextEditingController();
  final TextEditingController variationSkuController = TextEditingController();

  void removeAttribute(ProductAttributeModel attribute) {
    productAttributes.remove(attribute);
    update();
  }

  void addVariation() {
    var newVariation = ProductVariationModel(
      id: variationIdController.text,
      stock: int.parse(variationStockController.text),
      price: double.parse(variationPriceController.text),
      salePrice: double.parse(variationSalePriceController.text),
      description: variationDescriptionController.text,
      sku: variationSkuController.text,
      attributeValues: {
        'Color': selectedColorsss.isNotEmpty ? selectedColorsss.toList().join(', ') : '',
        'Size': selectedSizesss.isNotEmpty ? selectedSizesss.toList().join(', ') : '',
      },
    );
    productVariations.add(newVariation);
    update();
  }

  void updateVariationAttributeValue(
      ProductVariationModel variation, String attributeName, String value) {
    variation.attributeValues[attributeName] = value;
    update();
  }

  void removeVariation(ProductVariationModel variation) {
    productVariations.remove(variation);
    update();
  }


  final selectedColorsss = <String>[].obs;
  final selectedSizesss = <String>[].obs;
  final sizeInputControllerss = TextEditingController();

  void addAttributess() {
    if (selectedAttributeType.value == 'Color' && selectedColorsss.isNotEmpty) {
      productAttributes.add(ProductAttributeModel(
        name: 'Color',
        values: selectedColorsss.toList(),
      ));
      selectedColorsss.clear();
    } else if (selectedAttributeType.value == 'Size' && selectedSizesss.isNotEmpty) {
      productAttributes.add(ProductAttributeModel(
        name: 'Size',
        values: selectedSizesss.toList(),
      ));
      selectedSizesss.clear();
    }
  }

  ///  ---------- Attributes  & Variations ---------------------------------

  ///  ---------- get Category ID  ---------------------------------

// Categories list
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxList<CategoryModel> filteredCategories = RxList<CategoryModel>([]);
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);

  void fetchCategories() async {
    try {
      final categoriesSnapshot =
      await _firestore.collection('Categories').get();
      if (categoriesSnapshot.docs.isNotEmpty) {
        categories.assignAll(categoriesSnapshot.docs
            .map((doc) => CategoryModel.fromSnapshot(doc))
            .toList());
        filteredCategories.assignAll(categories);
      }
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  void filterCategories(String searchText) {
    if (searchText.isEmpty) {
      filteredCategories.assignAll(categories);
    } else {
      var filteredList = categories
          .where((category) =>
          category.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      filteredCategories.assignAll(filteredList);
    }
  }

  void selectCategory(CategoryModel category) {
    selectedCategory.value = category;
    categoryIdController.text =
        category.id; // Optionally set the ID in the controller
  }

  String? getCategoryIdByName(String categoryName) {
    var category = categories.firstWhere(
            (cat) => cat.name.toLowerCase() == categoryName.toLowerCase(),
        orElse: () => CategoryModel.empty());
    return category.id;
  }

  ///  ---------- get Category ID  ---------------------------------
  ///
  ///
  ///
  ///
  ///


  /// ########## CRUD for Product #######################
  ///
  ///
  ///
  final products = <ProductModel>[].obs;
  // Fetch Products
  Future<void> fetchProducts() async {
    try {
      final snapshot = await _firestore.collection('Products').get();
      final productsList = snapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
      products.assignAll(productsList);
      update();
    } catch (error) {
      Get.snackbar('Error', 'Failed to fetch products: $error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Update Product
  void listenToProductChanges() {
    _firestore.collection('Products').snapshots().listen((snapshot) {
      products.value = snapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
    });
  }

  Future<void> updateProduct(String productId, Map<String, dynamic> updatedFields) async {
    try {
      await _firestore.collection('Products').doc(productId).update(updatedFields);

      // Update local product
      final index = products.indexWhere((product) => product.id == productId);
      if (index != -1) {
        products[index].update(updatedFields);
      }

      Get.snackbar('Success', 'Product updated successfully', backgroundColor: Colors.green, colorText: Colors.white);
    } catch (error) {
      Get.snackbar('Error', 'Failed to update product: $error', backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Delete Product
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('Products').doc(productId).delete();
      products.removeWhere((product) => product.id == productId);
      Get.snackbar('Success', 'Product deleted successfully',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (error) {
      Get.snackbar('Error', 'Failed to delete product: $error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // New method to get the product count
  int get productCount => products.length;
  int get outOfStockCount => products.where((p) => p.stock == 0).length;
  int get limitedStockCount => products.where((p) => p.stock > 0 && p.stock <= 5).length;



  Rx<ProductCategory> currentCategory = ProductCategory.all.obs;
  void filterProductsByCategory(ProductCategory category) {
    currentCategory.value = category;
    // The actual filtering will be done in the UI
  }

  List<ProductModel> get filteredProducts {
    switch (currentCategory.value) {
      case ProductCategory.outOfStock:
        return products.where((p) => p.stock.value == 0).toList();
      case ProductCategory.limitedStock:
        return products.where((p) => p.stock.value > 0 && p.stock.value <= 10).toList();
      case ProductCategory.otherStock:
        return products.where((p) => p.stock.value > 10).toList();
      case ProductCategory.all:
      default:
        return products;
    }
  }

  List<ProductModel> getProductsByCategory(ProductCategory category) {
    switch (category) {
      case ProductCategory.outOfStock:
        return products.where((p) => p.stock.value == 0).toList();
      case ProductCategory.limitedStock:
        return products.where((p) => p.stock.value > 0 && p.stock.value <= 10).toList();
      case ProductCategory.otherStock:
        return products.where((p) => p.stock.value > 10).toList();
      case ProductCategory.all:
      default:
        return products;
    }
  }

  ///
  ///
  ///
  /// ########## CRUD for Product #######################
  ///
  ///


  // Search :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

  // final searchQuery = ''.obs;
  // final searchResults = <ProductModel>[].obs;
  //
  // void searchProducts(String query) {
  //   searchQuery.value = query.toLowerCase();
  //   if (searchQuery.isEmpty) {
  //     searchResults.assignAll(products);
  //   } else {
  //     searchResults.assignAll(products.where((product) {
  //       final title = product.title.value.toLowerCase();
  //       final description = product.description?.value?.toLowerCase() ?? '';
  //       final sku = product.sku?.value.toLowerCase();
  //       final brand = product.brand.value?.name.toLowerCase() ?? '';
  //
  //       return title.contains(searchQuery.value)
  //           // ||
  //           // description.contains(searchQuery.value) ||
  //           // sku!.contains(searchQuery.value) ||
  //           // brand.contains(searchQuery.value)
  //       ;
  //     }).toList());
  //   }
  // }
  //
  // List<ProductModel> get filteredSearchResults {
  //   if (searchQuery.isEmpty) {
  //     return filteredProducts;
  //   } else {
  //     return searchResults.where((product) {
  //       final stock = product.stock.value;
  //       switch (currentCategory.value) {
  //         case ProductCategory.outOfStock:
  //           return stock == 0;
  //         case ProductCategory.limitedStock:
  //           return stock > 0 && stock <= 10;
  //         case ProductCategory.otherStock:
  //           return stock > 10;
  //         case ProductCategory.all:
  //         default:
  //           return true;
  //       }
  //     }).toList();
  //   }
  // }

  final searchQuery = ''.obs;
  final searchResults = <ProductModel>[].obs;

  void searchProducts(String query) {
    searchQuery.value = query.toLowerCase().trim();
    if (searchQuery.isEmpty) {
      searchResults.assignAll(products);
    } else {
      searchResults.assignAll(products.where((product) {
        final title = product.title.value.toLowerCase();
        return title.contains(searchQuery.value);
      }).toList());
    }
  }

  List<ProductModel> get filteredSearchResults {
    final currentProducts = searchQuery.isEmpty ? products : searchResults;
    return currentProducts.where((product) {
      switch (currentCategory.value) {
        case ProductCategory.outOfStock:
          return product.stock.value == 0;
        case ProductCategory.limitedStock:
          return product.stock.value > 0 && product.stock.value <= 10;
        case ProductCategory.otherStock:
          return product.stock.value > 10;
        case ProductCategory.all:
        default:
          return true;
      }
    }).toList();
  }

  // Search :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

  @override
  void onInit() {
    super.onInit();
    // Initialize any necessary data or fetch brands
    fetchBrands();
    fetchCategories();
    fetchProducts();
    listenToProductChanges();
  }

  /// ---------- Attributes  & Variations ---------------------------------
  ///
  ///
  ///
  ///
  // new

  // Updated method to add product attribute
  void addProductAttribute() {
    String name = attributeNameController.text.trim();
    String value = attributeValueController.text.trim();
    if (name.isNotEmpty && value.isNotEmpty) {
      var existingAttribute = productAttributes.firstWhere(
            (attr) => attr.name == name,
        orElse: () => ProductAttributeModel(name: name, values: []),
      );
      if (!existingAttribute.values!.contains(value)) {
        existingAttribute.values!.add(value);
      }
      if (!productAttributes.contains(existingAttribute)) {
        productAttributes.add(existingAttribute);
      }
      attributeNameController.clear();
      attributeValueController.clear();
    }
  }

  void removeProductAttribute(ProductAttributeModel attribute) {
    productAttributes.remove(attribute);
    // Remove this attribute from all variations
    for (var variation in productVariations) {
      variation.attributeValues.remove(attribute.name);
    }
  }

  void addProductVariation() {
    if (productAttributes.isEmpty) {
      Get.snackbar('Error', 'Please add at least one product attribute first');
      return;
    }

    Map<String, String> attributeValues = {};
    for (var attribute in productAttributes) {
      attributeValues[attribute.name!] =
          attribute.values!.first; // Default to first value
    }

    productVariations.add(ProductVariationModel(
      id: variationIdController.text.isEmpty
          ? DateTime.now().millisecondsSinceEpoch.toString()
          : variationIdController.text,
      stock: int.tryParse(variationStockController.text) ?? 0,
      price: double.tryParse(variationPriceController.text) ?? 0.0,
      salePrice: double.tryParse(variationSalePriceController.text) ?? 0.0,
      description: variationDescriptionController.text,
      sku: variationSkuController.text,
      attributeValues: attributeValues,
    ));

    variationIdController.clear();
    variationStockController.clear();
    variationPriceController.clear();
    variationSalePriceController.clear();
    variationDescriptionController.clear();
    variationSkuController.clear();
  }

  void removeProductVariation(ProductVariationModel variation) {
    productVariations.remove(variation);
  }


  final selectedColorValues = ''.obs;
  final sizeInputControllers = TextEditingController();

  void addAttributes() {
    if (selectedAttributeType.value == 'Color') {
      String colorValue = selectedColorValues.value;
      if (!productAttributes.any((attr) => attr.name == 'Color')) {
        productAttributes.add(ProductAttributeModel(
          name: 'Color',
          values: [colorValue],
        ));
      } else {
        productAttributes
            .firstWhere((attr) => attr.name == 'Color')
            .values!
            .add(colorValue);
      }
    } else if (selectedAttributeType.value == 'Size') {
      String sizeValue = sizeInputControllers.text;
      if (!productAttributes.any((attr) => attr.name == 'Size')) {
        productAttributes.add(ProductAttributeModel(
          name: 'Size',
          values: [sizeValue],
        ));
      } else {
        productAttributes
            .firstWhere((attr) => attr.name == 'Size')
            .values!
            .add(sizeValue);
      }
    }

    // Clear input controllers or selected values after adding attribute
    sizeInputControllers.clear();
    selectedColorValues.value = '';
  }

  ///
  ///
  ///
  ///  ---------- Attributes  & Variations ---------------------------------

  // Fetch brands from Firestore
  void fetchBrands() async {
    try {
      final brandsSnapshot = await _firestore.collection('Brands').get();
      if (brandsSnapshot.docs.isNotEmpty) {
        brands.assignAll(brandsSnapshot.docs
            .map((doc) => NewBrandModel.fromQuerySnapshot(doc))
            .toList());
        filteredBrands.assignAll(brands);
      }
    } catch (error) {
      print('Error fetching brands: $error');
    }
  }

  // Method to filter brands based on search text
  void filterBrands(String searchText) {
    if (searchText.isEmpty) {
      filteredBrands.assignAll(brands);
    } else {
      var filteredList = brands
          .where((brand) =>
          brand.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      filteredBrands.assignAll(filteredList);
    }
  }
  final RxMap<String, String> titleTranslations = <String, String>{}.obs;
  final RxMap<String, String> descriptionTranslations = <String, String>{}.obs;

  // Method to set translations
  void setTranslations(Map<String, String> titles, Map<String, String> descriptions) {
    titleTranslations.value = titles;
    descriptionTranslations.value = descriptions;
  }
  // Method to add a new product
  Future<void> addProduct() async {
    String? validationError = _validateProduct();
    if (validationError != null) {
      Get.snackbar('Error', validationError,
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    List<String> imageUrls =
    await uploadImagesToFirebase(selectedImages.toList());
    final newProductId = await _getNextProductId();

    // New #####################################333


    // Upload thumbnail
    String thumbnailUrls = '';
    if (thumbnailImage.value != null) {
      thumbnailUrls = await uploadImageToFirebase(thumbnailImage.value, 'thumbnails');
    }


    Future<List<String>> uploadProductImages() async {
      List<String> productImageUrls = [];
      for (var imageEntry in productImages.entries) {
        Uint8List imageData = imageEntry.value;
        String url = await uploadImageToFirebase(imageData, 'product_images');
        if (url.isNotEmpty) {
          productImageUrls.add(url);
        }
      }
      return productImageUrls;
    }

    // Upload variation images and update variations
    for (var variation in productVariations) {
      if (variationImages.containsKey(variation.id)) {
        String url = await uploadImageToFirebase(variationImages[variation.id], 'variation_images');
        if (url.isNotEmpty) {
          variation.image = url;
        }
      }
    }

    List<String> productImageUrls = await uploadProductImages();
    await uploadVariationImages();


    final product = ProductModel(
      id: newProductId,
      title: titleController.text.trim(),
      stock: int.parse(stockController.text),
      price: double.parse(priceController.text),
      salePrice: double.parse(salePriceController.text),
      sku: skuController.text.trim(),
      thumbnail: thumbnailUrls,
      productType: selectedProductType.value,
      description: descriptionController.text.trim(),
      categoryId: categoryIdController.text.trim(),
      images: productImageUrls,
      isFeatured: isFeatured.value,
      brand: selectedBrand.value,
      date: DateTime.now(),
      productAttributes: productAttributes,
      productVariations: productVariations,
      titleTranslations: titleTranslations,  // Added field
      descriptionTranslations: descriptionTranslations,  // Added field
    );

    try {
      await _firestore
          .collection('Products')
          .doc(newProductId)
          .set(product.toJson());

      if (selectedBrand.value != null) {
        await _updateBrandProductCount(selectedBrand.value!.id);
      }

      Get.snackbar('Success', 'Product added successfully',
          backgroundColor: Colors.green, colorText: Colors.white);
      _clearForm();
    } catch (error) {
      Get.snackbar('Error', 'Failed to add product: $error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Method to select a brand
  void selectBrand(NewBrandModel brand) {
    selectedBrand.value = brand;
  }


  Future<String> uploadThumbnailToFirebase(File thumbnailFile) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}_thumbnail';
      Reference ref = _storage.ref().child('thumbnails').child(fileName);

      TaskSnapshot uploadTask;
      if (kIsWeb) {
        // Web-specific upload method
        uploadTask = await ref.putData(await thumbnailFile.readAsBytes());
      } else {
        // Mobile (Android/iOS) specific upload method
        uploadTask = await ref.putFile(thumbnailFile);
      }

      String downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading thumbnail: $e');
      return '';
    }
  }

  Future<List<String>> uploadImagesToFirebase(List<File?> images) async {
    List<String> downloadUrls = [];

    try {
      for (int i = 0; i < images.length; i++) {
        File? image = images[i];
        if (image != null) {
          String fileName = '${DateTime.now().millisecondsSinceEpoch}_$i';
          Reference ref = _storage.ref().child('images').child(fileName);

          TaskSnapshot uploadTask = await ref.putFile(image);
          String downloadUrl = await uploadTask.ref.getDownloadURL();
          downloadUrls.add(downloadUrl);
        }
      }
    } catch (e) {
      print('Error uploading image: $e');
    }

    return downloadUrls;
  }

  String? _validateProduct() {
    if (titleController.text.trim().isEmpty) {
      return 'Please enter a product title';
    }
    if (priceController.text.isEmpty ||
        double.tryParse(priceController.text) == null) {
      return 'Please enter a valid price';
    }
    if (stockController.text.isEmpty ||
        int.tryParse(stockController.text) == null) {
      return 'Please enter a valid stock quantity';
    }
    if (selectedBrand.value == null) {
      return 'Please select a brand';
    }
    if (categoryIdController.text.trim().isEmpty) {
      return 'Please select a category';
    }
    return null;
  }

  Future<String> _getNextProductId() async {
    try {
      final counterDoc = _firestore.collection('counters').doc('Products');
      final snapshot = await counterDoc.get();

      if (snapshot.exists) {
        final data = snapshot.data()!;
        final currentId = data['lastId'] as int;
        final newId = currentId + 1;

        await counterDoc.update({'lastId': newId});
        return newId
            .toString()
            .padLeft(3, '0'); // Pads the ID with zeros (e.g., 001, 002, etc.)
      } else {
        await counterDoc.set({'lastId': 1});
        return '001';
      }
    } catch (e) {
      print('Error getting next product ID: $e');
      return '001'; // Return a default ID in case of error
    }
  }

  Future<void> _updateBrandProductCount(String brandId) async {
    try {
      await _firestore.collection('Brands').doc(brandId).update({
        'ProductsCount': FieldValue.increment(1),
      });
    } catch (e) {
      print('Error updating brand product count: $e');
    }
  }

  void _clearForm() {
    titleController.clear();
    stockController.clear();
    skuController.clear();
    priceController.clear();
    salePriceController.clear();
    descriptionController.clear();
    categoryIdController.clear();
    thumbnailUrl.value = '';
    thumbnailUrlController.clear();
    selectedImages.clear();
    isFeatured.value = false;
    selectedBrand.value = null;
    selectedProductType.value = ProductType.single;
    thumbnailImage.value = null;
    productImages.clear();
    variationImages.clear();
    titleTranslations.clear();
    descriptionTranslations.clear();
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    titleController.dispose();
    stockController.dispose();
    skuController.dispose();
    priceController.dispose();
    salePriceController.dispose();
    descriptionController.dispose();
    categoryIdController.dispose();
    thumbnailUrlController.dispose();
    categoryIdController.dispose();

    super.dispose();
  }
}
