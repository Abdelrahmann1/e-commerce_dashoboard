import 'package:admin/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'colors.dart';

class THelperFunctions {
  static Color? getColor(String value) {
    switch (value) {
      case "Green":
        return Colors.green;
      case "Red":
        return Colors.red;
      case "Blue":
        return Colors.blue;
      case "Pink":
        return Colors.pink;
      case "Grey":
        return Colors.grey;
      case "Purple":
        return Colors.purple;
      case "Black":
        return Colors.black;
      case "White":
        return Colors.white;
      default:
        return null;
    }
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  static void showAlert(String title, String message) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                )
              ]);
        });
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(Get.context!).size.width;
  }

  // static String getFormattedDate(DateTime date,
  //     {String format = 'dd-MMM-yyyy'}) {
  //   return DateFormat(format).format(date);
  // }
  static String getFormattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm').format(date); // Adjust format as needed
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(
        children: rowChildren,
      ));
    }
    return wrappedList;
  }
}


///
class TAnimationLoaderWidget extends StatelessWidget {
  /// Default constructor for the TAnimationLoaderWidget.

  /// Parameters:
  ///- text: The text to be displayed below the animation.
  /// - animation: The path to the Lottie animation file.
  /// - showAction: Whether to show on action button below the text.
  ///    . actionText: The text to be displayed on the action button.
  ///    . onActionPressed: Callback function to be executed when the action button is pressed.
  const TAnimationLoaderWidget(
      {super.key,
        required this.text,
        required this.animation,
        this.showAction = false,
        this.actionText,
        this.onActionPressed});
  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,
              width: MediaQuery.of(context).size.width *
                  0.8), // Display Lottie animation
          const SizedBox(height: TSizes.defaultSpace),
          Text(text,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center),
          const SizedBox(height: TSizes.defaultSpace),
          showAction
              ? SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              style:
              OutlinedButton.styleFrom(backgroundColor: TColors.dark),
              child: Text(actionText!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: TColors.white)),
            ),
          )
              : const SizedBox(),
        ],
      ),
    );
  }
}