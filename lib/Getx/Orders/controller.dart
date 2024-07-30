//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
//
// import 'enum.dart';
// import 'model.dart';
//
// class AdminOrderController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   var orders = <OrderModel>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;
//
//   String _getFirestoreId(String orderId) {
//     return orderId.replaceAll(RegExp(r'[\[\]#]'), '');
//   }
//
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
//         var userData = userDoc.data() as Map<String, dynamic>;
//         var userName = userData['userName'] as String?;
//         QuerySnapshot orderSnapshot =
//         await userDoc.reference.collection('Orders').get();
//         var userOrders = orderSnapshot.docs.map((doc) async {
//           print('Order ID from Firestore: ${doc.id}');
//           return OrderModel.fromQuerySnapshot(doc).copyWith(
//             id: _getSpecialOrderId(doc.id),
//             userName: userName,
//           );
//         }).toList();
//         fetchedOrders.addAll(await Future.wait(userOrders));
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
//       String firestoreOrderId = _getFirestoreId(orderId);
//       print('Converted Firestore Order ID: $firestoreOrderId');
//
//       String path = 'Users/$userId/Orders/$firestoreOrderId';
//       print('Document path: $path');
//
//       DocumentSnapshot docSnapshot = await _firestore.doc(path).get();
//       if (!docSnapshot.exists) {
//         print('Document does not exist: $path');
//         throw Exception('Document does not exist: $path');
//       }
//
//       print('Current document data: ${docSnapshot.data()}');
//
//       await _firestore.doc(path).update({
//         'status': newStatus.toString(),
//         'deliveryDate': newStatus == OrderStatus.delivered ? Timestamp.now() : FieldValue.delete(),
//       });
//
//       print('Order status updated successfully');
//
//       int index = orders.indexWhere(
//               (order) => order.id == orderId && order.userId == userId);
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
//       String firestoreOrderId = _getFirestoreId(orderId);
//       String path = 'Users/$userId/Orders/$firestoreOrderId';
//       await _firestore.doc(path).delete();
//       orders.removeWhere(
//               (order) => order.id == orderId && order.userId == userId);
//       print(
//           'Order deleted successfully. User ID: $userId, Order ID: $orderId');
//     } catch (e) {
//       print('Error deleting order: $e');
//       Get.snackbar('Error', 'Failed to delete order: $e');
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'enum.dart';
import 'model.dart';

// very Good Working
// class AdminOrderController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   var allOrders = <OrderModel>[].obs;
//   var filteredOrders = <OrderModel>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;
//   var selectedFilter = Rx<OrderStatus?>(null);
//   var selectedFilters = OrderStatus.all.obs;
//
//
//   @override
//   void onInit() {
//     fetchOrders();
//     ever(selectedFilter, (_) => _filterOrders());
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
//         var userData = userDoc.data() as Map<String, dynamic>;
//         var userName = userData['userName'] as String?;
//         QuerySnapshot orderSnapshot = await userDoc.reference.collection('Orders').get();
//         var userOrders = orderSnapshot.docs.map((doc) async {
//           return OrderModel.fromQuerySnapshot(doc).copyWith(
//             id: _getSpecialOrderId(doc.id),
//             userName: userName,
//           );
//         }).toList();
//         fetchedOrders.addAll(await Future.wait(userOrders));
//       }
//
//       allOrders.assignAll(fetchedOrders);
//       _filterOrders();
//     } catch (e) {
//       errorMessage('Failed to load orders: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void _filterOrders() {
//     if (selectedFilter.value == null) {
//       filteredOrders.assignAll(allOrders);
//     } else {
//       filteredOrders.assignAll(allOrders.where((order) => order.status == selectedFilter.value));
//     }
//   }
//
//   void setFilter(OrderStatus? status) {
//
//     selectedFilter.value = status ?? OrderStatus.all;
//     if(status == OrderStatus.all) _filterOrders();
//   }
//
//   Future<void> updateOrderStatus(String userId, String orderId, OrderStatus newStatus) async {
//     try {
//       String firestoreOrderId = _getFirestoreId(orderId);
//       String path = 'Users/$userId/Orders/$firestoreOrderId';
//
//       await _firestore.doc(path).update({
//         'status': newStatus.toString(),
//         'deliveryDate': newStatus == OrderStatus.delivered ? Timestamp.now() : FieldValue.delete(),
//       });
//
//       int index = allOrders.indexWhere((order) => order.id == orderId && order.userId == userId);
//       if (index != -1) {
//         allOrders[index] = allOrders[index].copyWith(status: newStatus);
//         _filterOrders();
//       }
//     } catch (e) {
//       print('Error updating order status: $e');
//       Get.snackbar('Error', 'Failed to update order status: $e');
//     }
//   }
//
//   Future<void> deleteOrder(String userId, String orderId) async {
//     try {
//       String firestoreOrderId = _getFirestoreId(orderId);
//       String path = 'Users/$userId/Orders/$firestoreOrderId';
//       await _firestore.doc(path).delete();
//       allOrders.removeWhere((order) => order.id == orderId && order.userId == userId);
//       _filterOrders();
//       print('Order deleted successfully. User ID: $userId, Order ID: $orderId');
//     } catch (e) {
//       print('Error deleting order: $e');
//       Get.snackbar('Error', 'Failed to delete order: $e');
//     }
//   }
//
//   String _getFirestoreId(String orderId) {
//     return orderId.replaceAll(RegExp(r'[\[\]#]'), '');
//   }
//
//   String _getSpecialOrderId(String firestoreId) {
//     return '[#$firestoreId]';
//   }
// }




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminOrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var allOrders = <OrderModel>[].obs;
  var filteredOrders = <OrderModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var selectedFilter = Rx<OrderStatus>(OrderStatus.all);

  @override
  void onInit() {
    fetchOrders();
    ever(selectedFilter, (_) => filterOrders());
    super.onInit();
  }

  Map<OrderStatus, int> calculateOrdersWithStatus() {
    Map<OrderStatus, int> counts = {
      for (var status in OrderStatus.values) status: 0,
    };
    counts[OrderStatus.all] = allOrders.length;

    for (var order in allOrders) {
      if (counts.containsKey(order.status)) {
        counts[order.status] = (counts[order.status] ?? 0) + 1;
      }
    }

    return counts;
  }

  // Alternative method (more concise but potentially less efficient for large datasets)
  Map<OrderStatus, int> getOrderCounts() {
    return {
      for (var status in OrderStatus.values)
        status: allOrders.where((order) => order.status == status).length
    };
  }
  void fetchOrders() async {
    try {
      isLoading(true);
      errorMessage('');

      QuerySnapshot userSnapshot = await _firestore.collection('Users').get();
      List<QueryDocumentSnapshot> userDocs = userSnapshot.docs;

      List<OrderModel> fetchedOrders = [];
      for (var userDoc in userDocs) {
        var userData = userDoc.data() as Map<String, dynamic>;
        var userName = userData['userName'] as String?;
        QuerySnapshot orderSnapshot = await userDoc.reference.collection('Orders').get();
        var userOrders = orderSnapshot.docs.map((doc) async {
          return OrderModel.fromQuerySnapshot(doc).copyWith(
            id: _getSpecialOrderId(doc.id),
            userName: userName,
          );
        }).toList();
        fetchedOrders.addAll(await Future.wait(userOrders));
      }

      allOrders.assignAll(fetchedOrders);
      filterOrders();
    } catch (e) {
      errorMessage('Failed to load orders: $e');
    } finally {
      isLoading(false);
    }
  }

  void filterOrders() {
    if (selectedFilter.value == OrderStatus.all) {
      filteredOrders.assignAll(allOrders);
    } else {
      filteredOrders.assignAll(allOrders.where((order) => order.status == selectedFilter.value));
    }
  }

  void setFilter(OrderStatus status) {
    selectedFilter.value = status;
    filterOrders();
  }

  Future<void> updateOrderStatus(String userId, String orderId, OrderStatus newStatus) async {
    try {
      String firestoreOrderId = _getFirestoreId(orderId);
      String path = 'Users/$userId/Orders/$firestoreOrderId';

      await _firestore.doc(path).update({
        'status': newStatus.toString(),
        'deliveryDate': newStatus == OrderStatus.delivered ? Timestamp.now() : FieldValue.delete(),
      });

      int index = allOrders.indexWhere((order) => order.id == orderId && order.userId == userId);
      if (index != -1) {
        allOrders[index] = allOrders[index].copyWith(status: newStatus);
        filterOrders();
      }
    } catch (e) {
      print('Error updating order status: $e');
      Get.snackbar('Error', 'Failed to update order status: $e');
    }
  }

  Future<void> deleteOrder(String userId, String orderId) async {
    try {
      String firestoreOrderId = _getFirestoreId(orderId);
      String path = 'Users/$userId/Orders/$firestoreOrderId';
      await _firestore.doc(path).delete();
      allOrders.removeWhere((order) => order.id == orderId && order.userId == userId);
      filterOrders();
      print('Order deleted successfully. User ID: $userId, Order ID: $orderId');
    } catch (e) {
      print('Error deleting order: $e');
      Get.snackbar('Error', 'Failed to delete order: $e');
    }
  }

  String _getFirestoreId(String orderId) {
    return orderId.replaceAll(RegExp(r'[\[\]#]'), '');
  }

  String _getSpecialOrderId(String firestoreId) {
    return '[#$firestoreId]';
  }

  void refreshOrders() {
    fetchOrders();
  }
}