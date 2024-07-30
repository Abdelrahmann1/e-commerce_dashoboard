// // models/OrderModel.dart
//
// import 'enum.dart';
//
//
//
// class OrderModel {
//   String? sId; // Order ID
//   String? userID; // User ID (replace with actual user model)
//   String? trackingUrl;
//   Address? shippingAddress;
//   String? paymentMethod;
//   Coupon? couponCode;
//   OrderTotal? orderTotal;
//   List<OrderItem>? items;
//   OrderStatus? orderStatus;
//   String? orderDate;
//
//   OrderModel({
//     this.sId,
//     this.userID,
//     this.trackingUrl,
//     this.shippingAddress,
//     this.paymentMethod,
//     this.couponCode,
//     this.orderTotal,
//     this.items,
//     this.orderStatus,
//     this.orderDate,
//   });
//
//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     return OrderModel(
//       sId: json['sId'],
//       userID: json['userID'],
//       trackingUrl: json['trackingUrl'],
//       shippingAddress: json['shippingAddress'] != null
//           ? Address.fromJson(json['shippingAddress'])
//           : null,
//       paymentMethod: json['paymentMethod'],
//       couponCode: json['couponCode'] != null
//           ? Coupon.fromJson(json['couponCode'])
//           : null,
//       orderTotal: json['orderTotal'] != null
//           ? OrderTotal.fromJson(json['orderTotal'])
//           : null,
//       items: (json['items'] as List<dynamic>?)
//           ?.map((item) => OrderItem.fromJson(item))
//           .toList(),
//       orderStatus: OrderStatus.values
//           .firstWhere((e) => e.toString() == 'OrderStatus.${json['orderStatus']}'),
//       orderDate: json['orderDate'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'sId': sId,
//       'userID': userID,
//       'trackingUrl': trackingUrl,
//       'shippingAddress': shippingAddress?.toJson(),
//       'paymentMethod': paymentMethod,
//       'couponCode': couponCode?.toJson(),
//       'orderTotal': orderTotal?.toJson(),
//       'items': items?.map((item) => item.toJson()).toList(),
//       'orderStatus': orderStatus?.toString().split('.').last,
//       'orderDate': orderDate,
//     };
//   }
// }
//
// class Address {
//   String? phone;
//   String? street;
//   String? city;
//   String? postalCode;
//   String? country;
//
//   Address({this.phone, this.street, this.city, this.postalCode, this.country});
//
//   factory Address.fromJson(Map<String, dynamic> json) {
//     return Address(
//       phone: json['phone'],
//       street: json['street'],
//       city: json['city'],
//       postalCode: json['postalCode'],
//       country: json['country'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'phone': phone,
//       'street': street,
//       'city': city,
//       'postalCode': postalCode,
//       'country': country,
//     };
//   }
// }
//
// class Coupon {
//   String? couponCode;
//
//   Coupon({this.couponCode});
//
//   factory Coupon.fromJson(Map<String, dynamic> json) {
//     return Coupon(
//       couponCode: json['couponCode'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'couponCode': couponCode,
//     };
//   }
// }
//
// class OrderTotal {
//   double? subtotal;
//   double? discount;
//   double? total;
//
//   OrderTotal({this.subtotal, this.discount, this.total});
//
//   factory OrderTotal.fromJson(Map<String, dynamic> json) {
//     return OrderTotal(
//       subtotal: json['subtotal']?.toDouble(),
//       discount: json['discount']?.toDouble(),
//       total: json['total']?.toDouble(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'subtotal': subtotal,
//       'discount': discount,
//       'total': total,
//     };
//   }
// }
//
// class OrderItem {
//   String? productName;
//   int? quantity;
//   double? price;
//
//   OrderItem({this.productName, this.quantity, this.price});
//
//   factory OrderItem.fromJson(Map<String, dynamic> json) {
//     return OrderItem(
//       productName: json['productName'],
//       quantity: json['quantity'],
//       price: json['price']?.toDouble(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'productName': productName,
//       'quantity': quantity,
//       'price': price,
//     };
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../constants/helpers.dart';
import 'enum.dart';

// class OrderModel {
//   final String id;
//   final String userId;
//   final String? userName;
//   final OrderStatus status;
//   final double totalAmount;
//   final DateTime orderDate;
//   final String paymentMethod;
//   final AddressModel? address;
//   final DateTime? deliveryDate;
//   final List<CartItemModel> items;
//
//   OrderModel({
//     required this.id,
//     this.userId = '',
//     this.userName,
//     required this.status,
//     required this.items,
//     required this.totalAmount,
//     required this.orderDate,
//     this.paymentMethod = 'Paypal',
//     this.address,
//     this.deliveryDate,
//   });
//
//   String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);
//
//   String get formattedDeliveryDate => deliveryDate != null ? THelperFunctions.getFormattedDate(deliveryDate!) : "";
//
//   String get orderStatusText {
//     switch (status) {
//       case OrderStatus.processing:
//         return 'Processing';
//       case OrderStatus.shipped:
//         return 'Shipment on the way';
//       case OrderStatus.delivered:
//         return 'Delivered';
//       case OrderStatus.pending:
//         return 'Pending';
//       case OrderStatus.cancelled:
//         return 'Cancelled';
//       default:
//         return 'Unknown';
//     }
//   }
//
//   DateTime? getEffectiveDeliveryDate() {
//     if (status == OrderStatus.delivered) {
//       return deliveryDate ?? orderDate;
//     }
//     return deliveryDate;
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'userId': userId,
//       'userName': userName,
//       'status': status.toString(),
//       'totalAmount': totalAmount,
//       'orderDate': orderDate,
//       'paymentMethod': paymentMethod,
//       'address': address?.toJson(),
//       'deliveryDate': deliveryDate,
//       'items': items.map((item) => item.toJson()).toList(),
//     };
//   }
//
//   factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//
//     return OrderModel(
//       id: data['id'] as String,
//       userId: data['userId'] as String,
//       userName: data['userName'] as String?,
//       status: OrderStatus.values.firstWhere((e) => e.toString() == data['status']),
//       totalAmount: data['totalAmount'] as double,
//       orderDate: (data['orderDate'] as Timestamp).toDate(),
//       paymentMethod: data['paymentMethod'] as String,
//       address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
//       deliveryDate: data['deliveryDate'] == null ? null : (data['deliveryDate'] as Timestamp).toDate(),
//       items: (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
//     );
//   }
//
//   OrderModel copyWith({
//     String? id,
//     String? userId,
//     String? userName,
//     OrderStatus? status,
//     double? totalAmount,
//     DateTime? orderDate,
//     String? paymentMethod,
//     AddressModel? address,
//     DateTime? deliveryDate,
//     List<CartItemModel>? items,
//   }) {
//     return OrderModel(
//       id: id ?? this.id,
//       userId: userId ?? this.userId,
//       userName: userName ?? this.userName,
//       status: status ?? this.status,
//       totalAmount: totalAmount ?? this.totalAmount,
//       orderDate: orderDate ?? this.orderDate,
//       paymentMethod: paymentMethod ?? this.paymentMethod,
//       address: address ?? this.address,
//       deliveryDate: deliveryDate ?? this.deliveryDate,
//       items: items ?? this.items,
//     );
//   }
//
//   factory OrderModel.fromQuerySnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//     print('Order ID from Firestore: ${data['id']}');
//
//     return OrderModel(
//       id: data['id'] as String,
//       userId: data['userId'] as String,
//       userName: data['userName'] as String?,
//       status: OrderStatus.values.firstWhere((e) => e.toString() == data['status']),
//       totalAmount: data['totalAmount'] as double,
//       orderDate: (data['orderDate'] as Timestamp).toDate(),
//       paymentMethod: data['paymentMethod'] as String,
//       address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
//       deliveryDate: data['deliveryDate'] == null ? null : (data['deliveryDate'] as Timestamp).toDate(),
//       items: (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
//     );
//   }
// }

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final String? userName;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    this.userName,
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'Paypal',
    this.address,
    this.deliveryDate,
  });

  String get formattedOrderDate => _getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null ? _getFormattedDate(deliveryDate!) : "";

  String _getFormattedDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime); // Adjust format as needed
  }

  String get orderStatusText {
    switch (status) {
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipment on the way';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  DateTime? getEffectiveDeliveryDate() {
    if (status == OrderStatus.delivered) {
      return deliveryDate ?? orderDate;
    }
    return deliveryDate;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      userName: data['userName'] as String?,
      status: OrderStatus.values.firstWhere((e) => e.toString() == data['status']),
      totalAmount: data['totalAmount'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] as String,
      address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
      deliveryDate: data['deliveryDate'] == null ? null : (data['deliveryDate'] as Timestamp).toDate(),
      items: (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
    );
  }

  factory OrderModel.fromQuerySnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      userName: data['userName'] as String?,
      status: OrderStatus.values.firstWhere((e) => e.toString() == data['status']),
      totalAmount: data['totalAmount'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] as String,
      address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
      deliveryDate: data['deliveryDate'] == null ? null : (data['deliveryDate'] as Timestamp).toDate(),
      items: (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
    );
  }

  OrderModel copyWith({
    String? id,
    String? userId,
    String? userName,
    OrderStatus? status,
    double? totalAmount,
    DateTime? orderDate,
    String? paymentMethod,
    AddressModel? address,
    DateTime? deliveryDate,
    List<CartItemModel>? items,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      orderDate: orderDate ?? this.orderDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      address: address ?? this.address,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      items: items ?? this.items,
    );
  }
}





//
class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy')
        .format(date); // Customize the date format as needed
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$')
        .format(amount); // Customize the currency locale and symbol as need
  }

  static String formatPhoneNumber(String phoneNumber) {
// Assuming a 10-digit US phone number format: (123) 456-7890
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
// Add more custom phone number formatting logic for different formats if needed.
    return phoneNumber;
  }

  static String formatEgyptPhoneNumber(String phoneNumber) {
    // Remove any non-numeric characters
    phoneNumber = phoneNumber.replaceAll("[^\\d+]", "");

    if (phoneNumber.startsWith("+20")) {
      return phoneNumber; // Already in +20 11 digits format
    } else if (phoneNumber.length == 10) {
      // Add country code and format (assuming mobile number)
      return "+20${phoneNumber.substring(0, 2)} ${phoneNumber.substring(2, 5)} ${phoneNumber.substring(5)}";
    } else if (phoneNumber.length == 9) {
      // Prepend leading zero and format (assuming landline number)
      return "0${phoneNumber.substring(0, 1)} ${phoneNumber.substring(1, 4)} ${phoneNumber.substring(4)}";
    } else {
      // Invalid Egyptian phone number format
      return "Invalid Egyptian phone number";
    }
  }


  // Not fully tested.
  static String internationalFormatPhoneNumber(String phoneNumber) {
// Remove any non-digit characters from the phone number
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
// Extract the country code from the digitsOnly
    String countryCode = '+${digitsOnly.substring(0, 2)}';

// Add the remaining digits with proper formatting
    final formattedPhoneNumber = StringBuffer();
    formattedPhoneNumber.write('($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }
      int end = i + groupLength;
      formattedPhoneNumber.write(digitsOnly.substring(i, end));
      if (end < digitsOnly.length) {
        formattedPhoneNumber.write(' ');
      }
      i = end;
    }
    return formattedPhoneNumber.toString();
  }





}
class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  String get formattedPhoneNu => TFormatter.formatEgyptPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
      id: '',
      name: '',
      phoneNumber: '',
      city: '',
      state: '',
      country: '',
      street: '',
      postalCode: '');

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
      'DateTime': DateTime.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      phoneNumber: data['PhoneNumber'] as String,
      city: data['City'] as String,
      state: data['State'] as String,
      country: data['Country'] as String,
      street: data['Street'] as String,
      postalCode: data['PostalCode'],
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }

// Factory constructor to create an AddressModel from a DocumentSnapshot
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }
  @override
  String toString() {
    return '$street, $city, $state $postalCode, $country';
    //return 'AddressModel(id: $id, name: $name, phoneNumber: $phoneNumber, street: $street, city: $city, state: $state, postalCode: $postalCode, country: $country, dateTime: $dateTime, selectedAddress: $selectedAddress)';
  }
}


//

class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  /// Constructor
  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = '',
    this.image,
    this.price = 0.0,
    this.title = '',
    this.brandName,
    this.selectedVariation,
  });
  /// Empty Cart
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  /// Convert a CartItem to a JSON Map
  Map<String,dynamic> toJson(){
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  /// Create a CartItem from a JSON Map
  factory CartItemModel.fromJson(Map<String, dynamic> json){
    return CartItemModel(
      productId: json['productId'],
      title: json['title'],
      price: json['price']?.toDouble(),
      image: json['image'],
      quantity: json['quantity'],
      variationId: json['variationId'],
      brandName: json['brandName'],
      selectedVariation: json['selectedVariation']!=null ? Map<String, String>.from(json['selectedVariation']): null,
    );
  }
}