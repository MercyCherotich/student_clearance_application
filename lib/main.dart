import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:student_clearance_application/views/login.dart';

//import 'package:dropdown_button2/dropdown_button2.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await GetStorage.init();

  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
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
      child: Text(
        "Add User",
      ),
    );
  }
}
