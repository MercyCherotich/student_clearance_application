import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:dropdown_button2/dropdown_button2.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);
  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 
  final _auth = FirebaseAuth.instance;
   late User loggedInUser;
   bool showSpinner = false;

   @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

   void getCurrentUser() async {
     try{
     final User? user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).toString() as User;
     if (user != null){
       loggedInUser;
       //print(loggedInUser.email);
     }}
     catch (e){
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
        title: const Text('Login page'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: ListView(children: <Widget>[
            //Container(
                  //alignment: Alignment.center,
                  //padding: const EdgeInsets.all(10),
                  //child: const Text(
                    //'Name',
                    //style: TextStyle(
                        ///color: Colors.blue,
                        //fontWeight: FontWeight.w500,
                        //fontSize: 30),
                  //)),
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
                    labelText:'Username',
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
                child: const Text('Forgot Password',),
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
                      try{
                       await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                        await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResidencyScreen()),
                      );
                      setState(() {
                        showSpinner = false;
                      });
                      }
                      
                      catch(e) {
                        print('Invalid email or password!');
                      }
                      
                    },
                  )
              ),
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
                          builder: (context) => const SignupPage()),
                    );
                    },
                  )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          
          ),
          ],
          )
        ),
      ),
    );
  }
  Future createUser({required String username}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');
    final json = {
      'username': username,
      'password': password,
    };
    await docUser.set(json);
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth  = FirebaseAuth.instance;
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
        title: const Text('Signup page'),
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
                )
                ),
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
                      try{
                       await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                        await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                       setState(() {
                         showSpinner = false;
                       }); 
                      } 
                      catch (e) {
                        print(e);
                      }
                      
                    }
                    )
                    ),
          ],
        )
        ),
      ),
    );
  }

}





class ResidencyScreen extends StatefulWidget {
  const ResidencyScreen({ Key? key }) : super(key: key);

  @override
  State<ResidencyScreen> createState() => _ResidencyScreenState();
}

class _ResidencyScreenState extends State<ResidencyScreen> {
  String? residence; 
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Clearance'),
      ),
      
      body: Container( 
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [       
                  const Text("Choose your residency. If you stay in the hostels, select resident. If not, select non-residents", style: TextStyle( 
                     fontSize: 18
                  ),),

                  const Divider(),

                  ListTile(
                     title: const Text("Resident"),
                     leading: Radio(
                       value: "resident", 
                       groupValue: residence, 
                       onChanged: (value){
                          setState(() {
                             residence= value.toString();
                          });
                       }),
                  ),
                  ListTile(
                     title: const Text("Non-resident"),
                     leading: Radio(
                       value: "non-resident", 
                       groupValue: residence, 
                       onChanged: (value){
                          setState(() {
                             residence = value.toString();
                          });
                       }),
                  ),
                  Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Continue'),
                  onPressed: () {
                    Navigator.push(
                      context,      
                      MaterialPageRoute(builder: (context) => const HostelScreen()),
                       );
                  },
                )
            ), 
              ]
            )
      )
    );
  }
}

class HostelScreen extends StatefulWidget {
  const HostelScreen({ Key? key }) : super(key: key);

  @override
  State<HostelScreen> createState() => _HostelScreenState();
}

class _HostelScreenState extends State<HostelScreen> {
  String? selectedValue;

List<String> items = [
  'Sote A',
  'Sote B',
  'Lena Moi',
  'Kaboi',
  'Central',
  'Baringo',
  'Turkana',
  'Bogoria',

];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Continue'),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          /*Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Please select your group',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: CustomDropdownButton2(
              hint: 'Group',
              dropdownItems: group,
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
               });
              },
             ),
            ),
            */
            
          Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Please select your hostel',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: CustomDropdownButton2(
              hint: 'Hostel',
              dropdownItems: items,
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
               });
              },
             ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Continue'),
                  onPressed: () {
                    Navigator.push(
                      context,      
                      MaterialPageRoute(builder: (context) => const SchoolScreen()),
                       );
                  },
                )

                
            ),
        ],
        )
      ),
    );
  }
}
 
 class SchoolScreen extends StatefulWidget {
   const SchoolScreen({ Key? key }) : super(key: key);
 
   @override
   State<SchoolScreen> createState() => _SchoolScreenState();
 }
 
 class _SchoolScreenState extends State<SchoolScreen> {
   String? selectedValue;

List<String> items = [
  'School of SSET',
  'School of Music and Theatre Arts',
  'School of Business and Economics',
  'School of Education',
  'School of Law',
  'School of Pharmacy',
  'School of Medicine and Health Sciences',
  'Institute of Postgraduate Studies',

];
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
        title: const Text('Continue'),
       ),
       body: Center(
         child: ListView(children: <Widget>[
           Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Please select your school',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: CustomDropdownButton2(
              hint: 'school',
              dropdownItems: items,
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
               });
              },
             ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Continue'),
                  onPressed: () {
                    Navigator.push(
                      context,      
                      MaterialPageRoute(builder: (context) => const DepartmentScreen()),
                       );
                  },
                )
            ),
         ],),
       ),
     );
   }
 }

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({ Key? key }) : super(key: key);

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
   String? selectedValue;

List<String> items = [
  'DEPARTMENT OF MATHEMATICS',
  'DEPARTMENT OF COMPUTER SCIENCE',
  'DEPARTMENT OF ENGINEEERING',
  'DEPARTMENT OF SCIENCE',

];

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
        title: const Text('Continue'),
       ),
       body: Center(
         child: ListView(children: <Widget>[
           Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Please choose your department',
                  style: TextStyle(fontSize: 20),
                )
                ),
            Container(
              padding: const EdgeInsets.all(10),
              //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: CustomDropdownButton2(
              hint: 'department',
              dropdownItems: items,
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
               });
              },
             ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Continue'),
                  onPressed: () {
                    Navigator.push(
                      context,      
                      MaterialPageRoute(builder: (context) => const SportScreen(text: '',)),
                       );
                  },
                )
            ),
         ],
         ),
       ),
     );
   }
 }

class SportScreen extends StatefulWidget {
  final String text;
  const SportScreen({ Key? key, required this.text }) : super(key: key);

  @override
  State<SportScreen> createState() => _SportScreenState();
}

class _SportScreenState extends State<SportScreen> {
  String? selectedValue;

List<String> items = [
  'SOCCER',
  'BASKETBALL',
  'CHESS',
  'KARATE',
  'HOCKEY',
  'RUGBY',
  'NONE OF THE ABOVE',

];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Continue'),
       ),
       body: Center(
         child: ListView(children: <Widget>[
           Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Which sport did you participate in?',
                  style: TextStyle(fontSize: 20,),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: CustomDropdownButton2(
              hint: 'sport',
              dropdownItems: items,
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
               });
              },
             ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('SUBMIT'),
                  onPressed: () {
                    Navigator.push(
                      context,      
                      MaterialPageRoute(builder: (context) => const StudentDetails()),
                       );
                  },
                )
            ),
         ],
         ),
       ),
    );
  }
}

class StudentDetails extends StatefulWidget {
  const StudentDetails({Key? key}) : super(key: key);

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final controller = TextEditingController();
  late String username;
   late String hostel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
      ),
      body: Center(
      child: ListView(children: <Widget>[
        Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: const Text('Student Details'),
                  onPressed: () {
                    
                  },
                )),
      ],
       
        ),
      ),
    );
  }

    
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
