// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../constants/helpers.dart';
// class TFormatter {
//   static String formatDate(DateTime? date) {
//     date ??= DateTime.now();
//     return DateFormat('dd-MMM-yyyy')
//         .format(date); // Customize the date format as needed
//   }
//
//   static String formatCurrency(double amount) {
//     return NumberFormat.currency(locale: 'en_US', symbol: '\$')
//         .format(amount); // Customize the currency locale and symbol as need
//   }
//
//   static String formatPhoneNumber(String phoneNumber) {
// // Assuming a 10-digit US phone number format: (123) 456-7890
//     if (phoneNumber.length == 10) {
//       return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
//     } else if (phoneNumber.length == 11) {
//       return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
//     }
// // Add more custom phone number formatting logic for different formats if needed.
//     return phoneNumber;
//   }
//
//   static String formatEgyptPhoneNumber(String phoneNumber) {
//     // Remove any non-numeric characters
//     phoneNumber = phoneNumber.replaceAll("[^\\d+]", "");
//
//     if (phoneNumber.startsWith("+20")) {
//       return phoneNumber; // Already in +20 11 digits format
//     } else if (phoneNumber.length == 10) {
//       // Add country code and format (assuming mobile number)
//       return "+20${phoneNumber.substring(0, 2)} ${phoneNumber.substring(2, 5)} ${phoneNumber.substring(5)}";
//     } else if (phoneNumber.length == 9) {
//       // Prepend leading zero and format (assuming landline number)
//       return "0${phoneNumber.substring(0, 1)} ${phoneNumber.substring(1, 4)} ${phoneNumber.substring(4)}";
//     } else {
//       // Invalid Egyptian phone number format
//       return "Invalid Egyptian phone number";
//     }
//   }
//
//
//   // Not fully tested.
//   static String internationalFormatPhoneNumber(String phoneNumber) {
// // Remove any non-digit characters from the phone number
//     var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
// // Extract the country code from the digitsOnly
//     String countryCode = '+${digitsOnly.substring(0, 2)}';
//
// // Add the remaining digits with proper formatting
//     final formattedPhoneNumber = StringBuffer();
//     formattedPhoneNumber.write('($countryCode) ');
//
//     int i = 0;
//     while (i < digitsOnly.length) {
//       int groupLength = 2;
//       if (i == 0 && countryCode == '+1') {
//         groupLength = 3;
//       }
//       int end = i + groupLength;
//       formattedPhoneNumber.write(digitsOnly.substring(i, end));
//       if (end < digitsOnly.length) {
//         formattedPhoneNumber.write(' ');
//       }
//       i = end;
//     }
//     return formattedPhoneNumber.toString();
//   }
//
//
//
//
//
// }
// class AddressModel {
//   String id;
//   final String name;
//   final String phoneNumber;
//   final String street;
//   final String city;
//   final String state;
//   final String postalCode;
//   final String country;
//   final DateTime? dateTime;
//   bool selectedAddress;
//
//   AddressModel({
//     required this.id,
//     required this.name,
//     required this.phoneNumber,
//     required this.street,
//     required this.city,
//     required this.state,
//     required this.postalCode,
//     required this.country,
//     this.dateTime,
//     this.selectedAddress = true,
//   });
//
//   String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);
//
//   String get formattedPhoneNu => TFormatter.formatEgyptPhoneNumber(phoneNumber);
//
//   static AddressModel empty() => AddressModel(
//       id: '',
//       name: '',
//       phoneNumber: '',
//       city: '',
//       state: '',
//       country: '',
//       street: '',
//       postalCode: '');
//
//   Map<String, dynamic> toJson() {
//     return {
//       'Id': id,
//       'Name': name,
//       'PhoneNumber': phoneNumber,
//       'Street': street,
//       'City': city,
//       'State': state,
//       'PostalCode': postalCode,
//       'Country': country,
//       'DateTime': DateTime.now(),
//       'SelectedAddress': selectedAddress,
//     };
//   }
//
//   factory AddressModel.fromMap(Map<String, dynamic> data) {
//     return AddressModel(
//       id: data['Id'] as String,
//       name: data['Name'] as String,
//       phoneNumber: data['PhoneNumber'] as String,
//       city: data['City'] as String,
//       state: data['State'] as String,
//       country: data['Country'] as String,
//       street: data['Street'] as String,
//       postalCode: data['PostalCode'],
//       dateTime: (data['DateTime'] as Timestamp).toDate(),
//       selectedAddress: data['SelectedAddress'] as bool,
//     );
//   }
//
// // Factory constructor to create an AddressModel from a DocumentSnapshot
//   factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//
//     return AddressModel(
//       id: snapshot.id,
//       name: data['Name'] ?? '',
//       phoneNumber: data['PhoneNumber'] ?? '',
//       street: data['Street'] ?? '',
//       city: data['City'] ?? '',
//       state: data['State'] ?? '',
//       postalCode: data['PostalCode'] ?? '',
//       country: data['Country'] ?? '',
//       dateTime: (data['DateTime'] as Timestamp).toDate(),
//       selectedAddress: data['SelectedAddress'] as bool,
//     );
//   }
//   @override
//   String toString() {
//     return '$street, $city, $state $postalCode, $country';
//     //return 'AddressModel(id: $id, name: $name, phoneNumber: $phoneNumber, street: $street, city: $city, state: $state, postalCode: $postalCode, country: $country, dateTime: $dateTime, selectedAddress: $selectedAddress)';
//   }
// }
// class CartItemModel {
//   String productId;
//   String title;
//   double price;
//   String? image;
//   int quantity;
//   String variationId;
//   String? brandName;
//   Map<String, String>? selectedVariation;
//
//   /// Constructor
//   CartItemModel({
//     required this.productId,
//     required this.quantity,
//     this.variationId = '',
//     this.image,
//     this.price = 0.0,
//     this.title = '',
//     this.brandName,
//     this.selectedVariation,
//   });
//   /// Empty Cart
//   static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);
//
//   /// Convert a CartItem to a JSON Map
//   Map<String,dynamic> toJson(){
//     return {
//       'productId': productId,
//       'title': title,
//       'price': price,
//       'image': image,
//       'quantity': quantity,
//       'variationId': variationId,
//       'brandName': brandName,
//       'selectedVariation': selectedVariation,
//     };
//   }
//
//   /// Create a CartItem from a JSON Map
//   factory CartItemModel.fromJson(Map<String, dynamic> json){
//     return CartItemModel(
//       productId: json['productId'],
//       title: json['title'],
//       price: json['price']?.toDouble(),
//       image: json['image'],
//       quantity: json['quantity'],
//       variationId: json['variationId'],
//       brandName: json['brandName'],
//       selectedVariation: json['selectedVariation']!=null ? Map<String, String>.from(json['selectedVariation']): null,
//     );
//   }
// }
// class OrderModel
// {
//   final String id;
//   final String userId;
//   final OrderStatus status;
//   final double totalAmount;
//   final DateTime orderDate;
//   final String paymentMethod;
//   final AddressModel? address;
//   final DateTime? deliveryDate;
//   final List<CartItemModel> items;
//
//
//   OrderModel({
//     required this.id,
//     this.userId = '',
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
//   String get formattedDeliveryDate => deliveryDate != null ? THelperFunctions.getFormattedDate(deliveryDate!) :"";
//
//   String get orderStatusText => status == OrderStatus.delivered
//       ? 'Delivered'
//       : status == OrderStatus.shipped
//       ? 'Shipment on the way'
//       : 'Processing';
//
//   Map<String,dynamic> toJson(){
//     return {
//       'id': id,
//       'userId': userId,
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
//   factory OrderModel. fromSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//
//     return OrderModel(
//       id: data['id'] as String,
//       userId: data['userId'] as String,
//       status: OrderStatus.values.firstWhere((e) =>
//       e.toString() == data['status']),
//       totalAmount: data['totalAmount'] as double,
//       orderDate: (data['orderDate'] as Timestamp).toDate(),
//       paymentMethod: data['paymentMethod'] as String,
//       address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
//       deliveryDate: data['deliveryDate'] == null
//           ? null
//           : (data['deliveryDate'] as Timestamp).toDate(),
//       items: (data['items'] as List<dynamic>).map((itemData) =>
//           CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
//     ); // OrderModel
//   }
//
//   OrderModel copyWith({
//     String? id,
//     String? userId,
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
//
//   factory OrderModel.fromQuerySnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//     print('Order ID from Firestore: ${data['id']}'); // Debug log
//
//     return OrderModel(
//       id: data['id'] as String,
//       userId: data['userId'] as String,
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
//
//
// }
// enum OrderStatus { processing, shipped, delivered , pending}
//
// enum PaymentMethods { paypal, googlePay, applePay, visa, masterCard, creditCard, paystack, razorPay, paytm }
// class AdminOrderController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   var orders = <OrderModel>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;
//
//   // Helper method to convert the special order ID format to Firestore document ID
//   String _getFirestoreId(String orderId) {
//     return orderId.replaceAll(RegExp(r'[\[\]#]'), '');
//   }
//
//   // Helper method to convert Firestore document ID to the special order ID format
//   String _getSpecialOrderId(String firestoreId) {
//     return '[#$firestoreId]';
//   }
//
//   @override
//   void onInit() {
//     fetchOrders();
//     super.onInit();
//   }
//
//   void fetchOrders() async {
//     try {
//       isLoading(true);
//
//       QuerySnapshot userSnapshot = await _firestore.collection('Users').get();
//       List<QueryDocumentSnapshot> userDocs = userSnapshot.docs;
//
//       List<OrderModel> fetchedOrders = [];
//       for (var userDoc in userDocs) {
//         QuerySnapshot orderSnapshot =
//         await userDoc.reference.collection('Orders').get();
//         var userOrders = orderSnapshot.docs.map((doc) {
//           print('Order ID from Firestore: ${doc.id}');
//           // Convert Firestore ID to special format when creating OrderModel
//           return OrderModel.fromQuerySnapshot(doc)
//               .copyWith(id: _getSpecialOrderId(doc.id));
//         }).toList();
//         fetchedOrders.addAll(userOrders);
//       }
//
//       orders.assignAll(fetchedOrders);
//     } catch (e) {
//       errorMessage('Failed to load orders: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> updateOrderStatus(
//       String userId, String orderId, OrderStatus newStatus) async {
//     try {
//       print(
//           'Updating order status - User ID: $userId, Order ID: $orderId, New Status: $newStatus');
//
//       // Convert the special order ID to Firestore ID
//       String firestoreOrderId = _getFirestoreId(orderId);
//       print('Converted Firestore Order ID: $firestoreOrderId');
//
//       // Construct the path using the Firestore order ID
//       String path = 'Users/$userId/Orders/$firestoreOrderId';
//       print('Document path: $path');
//
//       // Check if the document exists before updating
//       DocumentSnapshot docSnapshot = await _firestore.doc(path).get();
//       if (!docSnapshot.exists) {
//         print('Document does not exist: $path');
//         throw Exception('Document does not exist: $path');
//       }
//
//       print('Current document data: ${docSnapshot.data()}');
//
//       // Update the order status
//       await _firestore.doc(path).update({
//         'status': newStatus.toString(),
//       });
//
//       print('Order status updated successfully');
//
//       // Update the local list of orders
//       int index = orders
//           .indexWhere((order) => order.id == orderId && order.userId == userId);
//       if (index != -1) {
//         orders[index] = orders[index].copyWith(status: newStatus);
//         print('Local order list updated');
//       } else {
//         print(
//             'Order not found in local list. User ID: $userId, Order ID: $orderId');
//       }
//     } catch (e) {
//       print('Error updating order status: $e');
//       Get.snackbar('Error', 'Failed to update order status: $e');
//     }
//   }
//
//   Future<void> deleteOrder(String userId, String orderId) async {
//     try {
//       // Convert the special order ID to Firestore ID
//       String firestoreOrderId = _getFirestoreId(orderId);
//       String path = 'Users/$userId/Orders/$firestoreOrderId';
//       await _firestore.doc(path).delete();
//       orders.removeWhere(
//               (order) => order.id == orderId && order.userId == userId);
//       print('Order deleted successfully. User ID: $userId, Order ID: $orderId');
//     } catch (e) {
//       print('Error deleting order: $e');
//       Get.snackbar('Error', 'Failed to delete order: $e');
//     }
//   }
// }