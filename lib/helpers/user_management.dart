
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_clearance_application/views/dashboard.dart';
import 'package:student_clearance_application/views/department.dart';
import 'package:student_clearance_application/views/login.dart';
import 'package:student_clearance_application/views/residency.dart';
import 'package:student_clearance_application/views/schools.dart';
import 'package:student_clearance_application/views/adminonly.dart';
import 'package:student_clearance_application/views/students_details.dart';


import '../constants/app_constants.dart';

class UserManagement{

  Widget handleAuth(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (BuildContext context, snapshot){
        //if(snapshot.hasData){
          if (!snapshot.hasData || snapshot.data.toString().isEmpty) {
          //return DashboardPage();
           String? uid = FirebaseAuth.instance.currentUser?.uid;
           FirebaseFirestore.instance.collection(students)
           .where('uid', isEqualTo: uid)
           .get()
           .then((docSnapshot) async {
            String? role = await docSnapshot.docs[0].get('role');
              if(role == 'student')
              {
                 print(role);
                // if the user role is not admin then the screen in directed to the department screen
                return DepartmentScreen();
              }else {
                //if user is admin, the screen is directed to the school screen
                return SchoolScreen();
              }
            
           }
           );
        }
         return ResidencyScreen();
        
      }
      );
  }
  //authorize access, minute 17:59
  /*
  authorizeAccess(BuildContext context){
    FirebaseAuth.instance.currentUser().then((user){
      FirebaseFirestore.instance
      .collection('/users')
      .where('uid',isEqualTo: user.uid)
      .getDocuments()
      .then((docs)){
        if(docs.documents[0].exists) {
          if(docs.documents[0].data['role'] == 'admin'){
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new AdminPage()
              )
            );
          }
          else{
            print('Not Authorized');
          }
        }
      };
    }
    );
  }
  */
  signOut(){
    FirebaseAuth.instance.signOut();
  }

authorizeUser(){
  String? uid = FirebaseAuth.instance.currentUser?.uid;

}
}