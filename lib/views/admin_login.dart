
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:student_clearance_application/constants/app_constants.dart';
import 'package:student_clearance_application/views/admin_registration.dart';
import 'package:student_clearance_application/views/clearance_requests.dart';
import 'package:student_clearance_application/views/register.dart';
import 'package:student_clearance_application/views/residency.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .toString() as User;
      if (user != null) {
        //loggedInUser;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  late String email;
  late String username;
  late String password;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Login page'),
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
                  'Please login',
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      // UserManagement().handleAuth();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            //builder: (context) => UserManagement().handleAuth()),
                            builder: (context) => ClearanceRequests()),
                      );
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print('Invalid email or password!');
                    }
                  },
                )),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminSignupPage()),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            /*Row(
              children: <Widget>[
                const Text('Admin Registration:'),
                TextButton(
                  child: const Text(
                    'Register as Admin',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResidencyScreen()),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            */
          ],
        )),
      ),
    );
  }

  Future createUser({required String username}) async {
    final docAdmin = firebaseFirestore.collection('admin').doc('my-id');
    final json = {
      'username': username,
      'password': password,
    };
    await docAdmin.set(json);
  }
}


