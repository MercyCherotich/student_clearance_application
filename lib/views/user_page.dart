

import 'package:flutter/material.dart';
import 'package:student_clearance_application/views/clearance_status.dart';
import 'package:student_clearance_application/views/students_details.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controllerUsername = TextEditingController();
  final controllerFaculty = TextEditingController();
  final controllerSport = TextEditingController();
  final controllerHostel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clearance Request page'),
      ),
     body: Padding(  
            padding:  EdgeInsets.all(15),  
            child: Column(  
              children: <Widget>[  
                Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: controllerUsername,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Username',
                ),
              ),
            ),   
                 
                Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: controllerFaculty,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Faculty',
                  hintText: 'Faculty',
                ),
                  ),
            ),   
                 Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: controllerSport,
                
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sport',
                  hintText: 'Sport',
                ),
              ),
            ),  
             Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: controllerHostel,
                
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Hostel',
                  hintText: 'Hostel',
                ),
              ),
            ),  
                ElevatedButton(    
                  child: const Text('Request to clear'),  
                  onPressed: (){
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ClearanceStatus()),
                );
                  },  
                )  
      ] 
        )
      ),
     );
  }
}

