import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:student_clearance_application/constants/app_constants.dart';
import 'package:student_clearance_application/views/admin_login.dart';

class AdminSignupPage extends StatefulWidget {
  const AdminSignupPage({Key? key}) : super(key: key);

  @override
  State<AdminSignupPage> createState() => _AdminSignupPageState();
}

class _AdminSignupPageState extends State<AdminSignupPage> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  late String email;
  late String password;
  late String username;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin-sign-up page'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
            child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Please enter your details',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                  username = value;
                },
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        FirebaseAuth.instance.signInWithEmailAndPassword(email: '', password: ''
                            //email: 'mn@gmail.com', password: '123456'
                            );
                        UserCredential userCredential =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        //save data to fb
                        CollectionReference users =
                            FirebaseFirestore.instance.collection(admin);
                        users
                            .add({
                              'username': username, // John Doe
                              'email': email, // Stokes and Sons // 42
                            })
                            .then((value) => print("User Added"))
                            .catchError(
                                (error) => print("Failed to add user: $error"));

                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminLogin()),
                        );
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    })),
          ],
        )),
      ),
    );
  }
}
