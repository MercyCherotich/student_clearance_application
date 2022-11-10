import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:student_clearance_application/views/dashboard.dart';
import 'package:student_clearance_application/views/login.dart';

import 'helpers/user_management.dart';
import 'firebase_options.dart';
//import 'package:student_clearance_application/views/user_authentication.dart';

//import 'package:dropdown_button2/dropdown_button2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('This line printed');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await GetStorage.init();

  runApp( GetMaterialApp(
    debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    //home: UserManagement().handleAuth(),
  ));
}

class AddUser extends StatelessWidget {
  final String username;
  final String email;
  

  AddUser(this.username, this.email);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'username': username, // John Doe
            'email': email, // Stokes and Sons // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: const Text(
        "Add User",
      ),
    );
  }
}

  class AddAdmin extends StatelessWidget {
  final String username;
  final String email;

  AddAdmin(this.username, this.email);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called admin that references the firestore collection
    CollectionReference admin = FirebaseFirestore.instance.collection('admin');

    Future<void> addAdmin() {
      // Call the user's CollectionReference to add a new user
      return admin
          .add({
            'username': username, // John Doe
            'email': email, // Stokes and Sons // 42
          })
          .then((value) => print("Admin Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addAdmin,
      child: const Text(
        "Add Admin",
      ),
    );
  }
}

