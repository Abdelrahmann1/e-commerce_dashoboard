import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Getx/Categories/model.dart';
import '../../../Getx/Coupons/controller.dart';
import '../../../Getx/Coupons/model.dart';
import '../../../Getx/Products/models.dart';
import '../../../Getx/Sub Categories/model.dart';
import '../../../models/product.dart';
import '../../../models/sub_category.dart';
import '../provider/coupon_code_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../models/category.dart';
import '../../../models/coupon.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';

//
// class CouponSubmitForm extends StatelessWidget {
//   final Coupon? coupon;
//
//   const CouponSubmitForm({Key? key, this.coupon}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     context.couponCodeProvider.setDataForUpdateCoupon(coupon);
//     return SingleChildScrollView(
//       child: Form(
//         key: context.couponCodeProvider.addCouponFormKey,
//         child: Container(
//           width: size.width * 0.7,
//           padding: EdgeInsets.all(defaultPadding),
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Gap(defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       controller: context.couponCodeProvider.couponCodeCtrl,
//                       labelText: 'Coupon Code',
//                       onSave: (val) {},
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter coupon code';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomDropdown(
//                       key: GlobalKey(),
//                       hintText: 'Discount Type',
//                       items: ['fixed', 'percentage'],
//                       initialValue: context.couponCodeProvider.selectedDiscountType,
//                       onChanged: (newValue) {
//                         context.couponCodeProvider.selectedDiscountType = newValue ?? 'fixed';
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select a discount type';
//                         }
//                         return null;
//                       }, displayItem: (val ) => val,
//                     ),
//                   ),
//                 ],
//               ),
//               Gap(defaultPadding),
//
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       controller: context.couponCodeProvider.discountAmountCtrl,
//                       labelText: 'Discount Amount',
//                       inputType: TextInputType.number,
//                       onSave: (val) {},
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter discount amount';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomTextField(
//                       controller: context.couponCodeProvider.minimumPurchaseAmountCtrl,
//                       labelText: 'Minimum Purchase Amount',
//                       inputType: TextInputType.number,
//                       onSave: (val) {},
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select status';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//
//               Gap(defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomDatePicker(
//                       labelText: 'Select Date',
//                       controller: context.couponCodeProvider.endDateCtrl,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2100),
//                       onDateSelected: (DateTime date) {
//                         print('Selected Date: $date');
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomDropdown(
//                       key: GlobalKey(),
//                       hintText: 'Status',
//                       initialValue: context.couponCodeProvider.selectedCouponStatus,
//                       items: ['active', 'inactive'],
//                       displayItem: (val ) => val,
//                       onChanged: (newValue) {
//                         context.couponCodeProvider.selectedCouponStatus = newValue ?? 'active';
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select status';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Consumer<CouponCodeProvider>(
//                       builder: (context, couponProvider, child) {
//                         return CustomDropdown(
//                           initialValue: couponProvider.selectedCategory,
//                           hintText: couponProvider.selectedCategory?.name ?? 'Select category',
//                           items: context.dataProvider.categories,
//                           displayItem: (Category? category) => category?.name ?? '',
//                           onChanged: (newValue) {
//                             if (newValue != null) {
//                               couponProvider.selectedSubCategory = null;
//                               couponProvider.selectedProduct = null;
//                               couponProvider.selectedCategory = newValue;
//                               couponProvider.updateUi();
//                             }
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: Consumer<CouponCodeProvider>(
//                       builder: (context, couponProvider, child) {
//                         return CustomDropdown(
//                           initialValue: couponProvider.selectedSubCategory,
//                           hintText: couponProvider.selectedSubCategory?.name ?? 'Select sub category',
//                           items: context.dataProvider.subCategories,
//                           displayItem: (SubCategory? subCategory) => subCategory?.name ?? '',
//                           onChanged: (newValue) {
//                             if (newValue != null) {
//                               couponProvider.selectedCategory = null;
//                               couponProvider.selectedProduct = null;
//                               couponProvider.selectedSubCategory = newValue;
//                               couponProvider.updateUi();
//                             }
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: Consumer<CouponCodeProvider>(
//                       builder: (context, couponProvider, child) {
//                         return CustomDropdown(
//                           initialValue: couponProvider.selectedProduct,
//                           hintText: couponProvider.selectedProduct?.name ?? 'Select product',
//                           items: context.dataProvider.products,
//                           displayItem: (Product? product) => product?.name ?? '',
//                           onChanged: (newValue) {
//                             if (newValue != null) {
//                               couponProvider.selectedCategory = null;
//                               couponProvider.selectedSubCategory = null;
//                               couponProvider.selectedProduct = newValue;
//                               couponProvider.updateUi();
//                             }
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Gap(defaultPadding),
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
//                   SizedBox(width: defaultPadding),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: primaryColor,
//                     ),
//                     onPressed: () {
//                       // Validate and save the form
//                       if (context.couponCodeProvider.addCouponFormKey.currentState!.validate()) {
//                         context.couponCodeProvider.addCouponFormKey.currentState!.save();
//                         //TODO: should complete call  submitCoupon
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
// // CouponSubmitForm UI
// class CouponSubmitForm extends StatelessWidget {
//   final CouponModel? coupon;
//
//   const CouponSubmitForm({Key? key, this.coupon}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final CouponController couponController = Get.put(CouponController());
//     couponController.setDataForUpdateCoupon(coupon);
//     var size = MediaQuery.of(context).size;
//
//     return SingleChildScrollView(
//       child: Form(
//         key: couponController.formKey,
//         child: Container(
//           width: size.width * 0.7,
//           padding: EdgeInsets.all(defaultPadding),
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(height: defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       controller: couponController.codeController,
//                       labelText: 'Coupon Code',
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter coupon code';
//                         }
//                         return null;
//                       }, onSave: (String?d ) {  },
//                     ),
//                   ),
//                   Expanded(
//                     child:CustomDropdown<String>(
//                       hintText: 'Discount Type',
//                       items: ['fixed', 'percentage'],
//                       initialValue: couponController.discountTypeController.text.isEmpty
//                           ? 'fixed' // Default value if the controller is empty
//                           : couponController.discountTypeController.text,
//                       onChanged: (newValue) {
//                         couponController.discountTypeController.text = newValue ?? 'fixed';
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select a discount type';
//                         }
//                         return null;
//                       },
//                       displayItem: (val) => val,
//                     ),
//
//                   ),
//                 ],
//               ),
//               SizedBox(height: defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       controller: couponController.discountAmountController,
//                       labelText: 'Discount Amount',
//                       inputType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter discount amount';
//                         }
//                         return null;
//                       }, onSave: (String? d) {  },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomTextField(
//                       controller: couponController.minimumPurchaseAmountController,
//                       labelText: 'Minimum Purchase Amount',
//                       inputType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter minimum purchase amount';
//                         }
//                         return null;
//                       }, onSave: (String? d) {  },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomDatePicker(
//                       labelText: 'Expiry Date',
//                       controller: couponController.expiryDateController,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2100),
//                       onDateSelected: (date) {
//                         couponController.expiryDateController.text = DateFormat('yyyy-MM-dd').format(date);
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child:CustomDropdown<String>(
//                       hintText: 'Status',
//                       items: ['active', 'inactive'],
//                       initialValue: couponController.statusController.text.isEmpty
//                           ? 'active' // Default value if empty
//                           : couponController.statusController.text,
//                       onChanged: (newValue) {
//                         couponController.statusController.text = newValue ?? 'active';
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select status';
//                         }
//                         return null;
//                       },
//                       displayItem: (val) => val,
//                     ),
//
//                   ),
//                 ],
//               ),
//               SizedBox(height: defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       children: [
//                         CustomTextField(
//                           controller: couponController.applicableCategoryIdController,
//                           labelText: 'Applicable Category ID',
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter applicable category ID';
//                             }
//                             return null;
//                           }, onSave: (String?d ) {  },
//                         ),
//
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomTextField(
//                       controller: couponController.applicableSubCategoryIdController,
//                       labelText: 'Applicable Sub Category ID',
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter applicable sub category ID';
//                         }
//                         return null;
//                       }, onSave: (String? d) {  },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomTextField(
//                       controller: couponController.applicableProductIdController,
//                       labelText: 'Applicable Product ID',
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter applicable product ID';
//                         }
//                         return null;
//                       }, onSave: (String? d ) {  },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: defaultPadding),
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
//                   SizedBox(width: defaultPadding),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: primaryColor,
//                     ),
//                     onPressed: () {
//                       if (couponController.formKey.currentState!.validate()) {
//                         couponController.formKey.currentState!.save();
//                         couponController.submitCoupon();
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
// // Function to show the form
// void showAddCouponForm(BuildContext context, CouponModel? coupon) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: secondaryColor,
//         title: Center(child: Text('Add Coupon'.toUpperCase(), style: TextStyle(color: Colors.blue))),
//         content: CouponSubmitForm(coupon: coupon),
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CouponSubmitForm extends StatelessWidget {
  final CouponModel? coupon;

  const CouponSubmitForm({Key? key, this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CouponController couponController = Get.put(CouponController());
    couponController.setDataForUpdateCoupon(coupon);
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: couponController.formKey,
        child: Container(
          width: size.width * 0.7,
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: couponController.codeController,
                      labelText: 'Coupon Code',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter coupon code';
                        }
                        return null;
                      },
                      onSave: (String? d) {},
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: CustomDropdown<String>(
                      hintText: 'Discount Type',
                      items: ['fixed', 'percentage'],
                      initialValue: couponController.discountTypeController.text.isEmpty
                          ? 'fixed'
                          : couponController.discountTypeController.text,
                      onChanged: (newValue) {
                        couponController.discountTypeController.text = newValue ?? 'fixed';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a discount type';
                        }
                        return null;
                      },
                      displayItem: (val) => val,
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: couponController.discountAmountController,
                      labelText: 'Discount Amount',
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter discount amount';
                        }
                        return null;
                      },
                      onSave: (String? d) {},
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: CustomTextField(
                      controller: couponController.minimumPurchaseAmountController,
                      labelText: 'Minimum Purchase Amount',
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter minimum purchase amount';
                        }
                        return null;
                      },
                      onSave: (String? d) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomDatePicker(
                      labelText: 'Expiry Date',
                      controller: couponController.expiryDateController,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onDateSelected: (date) {
                        couponController.expiryDateController.text = DateFormat('yyyy-MM-dd').format(date);
                      },
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: CustomDropdown<String>(
                      hintText: 'Status',
                      items: ['active', 'inactive'],
                      initialValue: couponController.statusController.text.isEmpty
                          ? 'active'
                          : couponController.statusController.text,
                      onChanged: (newValue) {
                        couponController.statusController.text = newValue ?? 'active';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select status';
                        }
                        return null;
                      },
                      displayItem: (val) => val,
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              //old

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      if (couponController.formKey.currentState!.validate()) {
                        couponController.formKey.currentState!.save();
                        couponController.submitCoupon();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      if (couponController.formKey.currentState!.validate()) {
                        couponController.formKey.currentState!.save();
                        couponController.submitCoupon();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit'),
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     foregroundColor: Colors.white,
                  //     backgroundColor: primaryColor,
                  //   ),
                  //   onPressed: () {
                  //     Get.to(CheckoutScreen());
                  //   },
                  //   child: Text('CheckoutScreen'),
                  // ),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}




// Function to show the form
void showAddCouponForm(BuildContext context, CouponModel? coupon) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: secondaryColor,
        title: Center(child: Text('Add Coupon'.toUpperCase(), style: TextStyle(color: Colors.blue))),
        content: CouponSubmitForm(coupon: coupon),
      );
    },
  );
}
