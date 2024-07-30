import 'package:admin/constants/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class TFirebaseException implements Exception {
  final String message;

  TFirebaseException(this.message);

  @override
  String toString() => 'TFirebaseException: $message';
}
class TFirebaseAuthException implements Exception {


  final String message;



  TFirebaseAuthException(this.message);

  @override
  String toString() => 'FirebaseAuthException: $message';
}


class TFormatException implements Exception {
  @override
  String toString() => 'TFormatException: Invalid data format encountered.';  // Replace with a real message
}

class TPlatformException implements Exception {
  final String message;

  TPlatformException(this.message);

  @override
  String toString() => 'TPlatformException: An error occurred on the platform. : $message';
}


// Loaders
class TLoaders {
  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: THelperFunctions.isDarkMode(Get.context!) ? TColors
                .darkGrey.withOpacity(0.9) : TColors.grey.withOpacity(0.9),
          ), // BoxDecoration
          child: Center(child: Text(message, style: Theme
              .of(Get.context!)
              .textTheme
              .labelLarge)),
        ), // Container
      ), // SnackBar
    );
  }

  static successSnackBar({required title, message = '', duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: TColors.primaryColor,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Icons.check, color: TColors.white),
    );
  }

  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: TColors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Icons.warning, color: TColors.white),
    );
  }
  static errorSnackBar({required title, message = ''}) {
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: TColors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Icons.warning, color: TColors.white)
    );
  }
}

class TFullScreenLoader {
  // This method doesn't do anything.
  /// Open a full-screen loading dialog with a given text and animation.
  /// This method doesn't return anything.

  /// Parameters:
  ///- text: The text to be displayed in the loading dialog.
  ///    . animation: The Lottie animation to be shown.
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context:
      Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible: false, // Dialog won't dismiss on tapping outside
      builder: (BuildContext context) {
        return PopScope(
          canPop: false, // Disable back button
          child: Container(
            color: THelperFunctions.isDarkMode(Get.context!)
                ? TColors.dark
                : TColors.white, // Background color with opacity
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 200),// Adjust the spacing as needed
                TAnimationLoaderWidget(text: text, animation: animation),
              ],
            ),
          ),
        );
      },
    );
  }
  /// Stop the currently open loading dialog.
  /// This method doesn't return anything.
  static stopLoading() {
    Navigator.of(Get.overlayContext!)
        .pop(); // Close the dialog using the Navigator
  }
}