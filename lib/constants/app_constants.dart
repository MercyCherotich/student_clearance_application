import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

String? signUp = 'Create Account';


//firebaseFirestoreInstance
final firebaseFirestore = FirebaseFirestore.instance;

//getCurrentUser UID
var currentUserUID =FirebaseAuth.instance.currentUser!.uid;

//collections
String students = 'Students';

//local storage instance
final sharedPrefs = GetStorage();


final Map<String, dynamic> studentDetails ={
'residence' : sharedPrefs.read('residence'),
'hostel' : sharedPrefs.read('hostel'),
'school' : sharedPrefs.read('school'),
'department' : sharedPrefs.read('department'),
'sports' : sharedPrefs.read('sports'),
};

