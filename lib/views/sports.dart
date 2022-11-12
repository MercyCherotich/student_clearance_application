import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:student_clearance_application/constants/app_constants.dart';
import 'package:student_clearance_application/views/students_details.dart';

class SportScreen extends StatefulWidget {
  final String text;
  const SportScreen({Key? key, required this.text}) : super(key: key);

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
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Which sport did you participate in?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
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
                 //store to local storage
                sharedPrefs.write('sports', selectedValue);
                 //store data to firestore
                 DocumentReference<Map<String, dynamic>> reference = firebaseFirestore
                  .collection(students).doc(currentUserUID);
                  reference.set(studentDetails).then((value) => print('uploaded'));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StudentDetails()),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
