import 'package:admin/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/network.dart';
import 'core/data/data_provider.dart';
import 'core/routes/app_pages.dart';
import 'screens/brands/provider/brand_provider.dart';
import 'screens/category/provider/category_provider.dart';
import 'screens/coupon_code/provider/coupon_code_provider.dart';
import 'screens/dashboard/provider/dash_board_provider.dart';
import 'screens/main/main_screen.dart';
import 'screens/main/provider/main_screen_provider.dart';
import 'screens/notification/provider/notification_provider.dart';
import 'screens/order/provider/order_provider.dart';
import 'screens/posters/provider/poster_provider.dart';
import 'screens/sub_category/provider/sub_category_provider.dart';
import 'screens/variants/provider/variant_provider.dart';
import 'screens/variants_type/provider/variant_type_provider.dart';
import 'utility/constants.dart';
import 'utility/extensions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //  // Add default admins if they don't exist
  // AdminController adminController = Get.put(AdminController());
  // await adminController.addAdmin('admin@ecommerce.com');
  final AdminController adminController = Get.put(AdminController());
  await adminController.checkLoggedInStatus();


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DataProvider()),
    ChangeNotifierProvider(create: (context) => MainScreenProvider()),
    ChangeNotifierProvider(
        create: (context) => CategoryProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => SubCategoryProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => BrandProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => VariantsTypeProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => VariantsProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => DashBoardProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => CouponCodeProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => PosterProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => OrderProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => NotificationProvider(context.dataProvider)),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AdminController adminController = Get.put(AdminController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      initialRoute:adminController.isLoggedIn.value ? AppPages.HOME : AppPages.LOGIN, // AppPages.LOGIN, // AppPages.HOME,
      unknownRoute: GetPage(name: '/notFount', page: () => MainScreen()),
      defaultTransition: Transition.cupertino,
      initialBinding: GeneralBindings(),
      getPages: AppPages.routes,
    );
  }
}


// Bindings
class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());

  }
}
/// Admin Auth
class Admin {
  String id;
  String email;
  String role;

  Admin({
    required this.id,
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'role': role,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'],
      email: map['email'],
      role: map['role'],
    );
  }
}



class AdminAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        DocumentSnapshot docSnapshot = await _firestore.collection('Admins').doc(email).get();
        if (docSnapshot.exists) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('adminEmail', email);
          return true;
        }
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print('Error logging in admin: ${e.message}');
      return false;
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('adminEmail');
  }

  Future<bool> adminExists(String email) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('Admins').doc(email).get();
    return docSnapshot.exists;
  }

  Future<void> addAdmin(Admin admin, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: admin.email,
        password: password,
      );

      admin.id = userCredential.user!.uid;

      await _firestore.collection('Admins').doc(admin.email).set(admin.toMap());
    } on FirebaseAuthException catch (e) {
      print('Error adding admin: ${e.message}');
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('adminEmail');
    return email != null;
  }

  Future<String?> getLoggedInAdminEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('adminEmail');
  }
}




class AdminController extends GetxController {
  static AdminController get instance => Get.find();
  final AdminAuthRepository _authRepository = AdminAuthRepository();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    checkLoggedInStatus();
  }

  Future<void> login(String email, String password) async {
    if (!_validateEmail(email) || password.isEmpty) {
      Get.snackbar('Invalid Input', 'Please provide valid email and password');
      return;
    }

    isLoading.value = true;
    bool success = await _authRepository.login(email, password);
    isLoading.value = false;

    if (success) {
      isLoggedIn.value = true;
      Get.offAllNamed(AppPages.HOME);
    } else {
      Get.snackbar('Login Failed', 'Invalid credentials or not an admin');
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    isLoggedIn.value = false;
    Get.offAllNamed(AppPages.LOGIN);
  }

  Future<void> addAdmin(String email, String password) async {
    if (!_validateEmail(email) || password.isEmpty) {
      Get.snackbar('Invalid Input', 'Please provide valid email and password');
      return;
    }

    if (await _authRepository.adminExists(email)) {
      Get.snackbar('Admin Exists', 'This admin already exists');
    } else {
      Admin newAdmin = Admin(id: '', email: email, role: 'admin');
      await _authRepository.addAdmin(newAdmin, password);
      Get.snackbar('Success', 'Admin added successfully');
    }
  }

  Future<void> checkLoggedInStatus() async {
    try {
      bool isLoggedInStatus = await _authRepository.isLoggedIn();
      isLoggedIn.value = isLoggedInStatus;
      if (isLoggedInStatus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAllNamed(AppPages.HOME);
        });
      }
    } catch (e) {
      print('Navigation error: $e');
      // Handle the error appropriately
    }
  }

  bool _validateEmail(String email) {
    final emailPattern = r'^[a-zA-Z0-9._%+-]+@ecommerce\.com$';
    final regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }
}

// mnf@ecommerce.com 123456