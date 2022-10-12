import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:student_clearance_application/constants/app_constants.dart';
import 'package:student_clearance_application/views/department.dart';


class SchoolScreen extends StatefulWidget {
  const SchoolScreen({Key? key}) : super(key: key);

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
        child: ListView(
          children: <Widget>[
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
                    //store selected value to local storage
                    sharedPrefs.write('school', selectedValue);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DepartmentScreen()),
                    );
                  },
                ),
                ),
          ],
        ),
      ),
    );
  }
}
