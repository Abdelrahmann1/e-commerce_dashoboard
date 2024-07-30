import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../screens/main/main_screen.dart';



class AppPages {
  static const HOME = '/';
  static const LOGIN = '/login';


  static final routes = [
    GetPage(
      name: HOME,
      fullscreenDialog: true,
      page: () => MainScreen()
    ),
    GetPage(
      name: LOGIN,
      page: () => AdminLoginScreen(),
    ),

  ];
}




class AdminLoginScreen extends StatelessWidget {
  final AdminController adminController = AdminController.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                suffixIcon: Icon(Icons.email),
              ),
            ),
            Obx(
                  () => TextField(
                controller: passwordController,
                obscureText: !adminController.isPasswordVisible.value,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(adminController.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: adminController.togglePasswordVisibility,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(
                  () => adminController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () {
                  adminController.login(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
                child: Text('Login'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                adminController.addAdmin(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },
              child: Text('Create Admin'),
            ),
          ],
        ),
      ),
    );
  }
}