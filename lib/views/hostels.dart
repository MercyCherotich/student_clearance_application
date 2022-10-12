import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:student_clearance_application/constants/app_constants.dart';
import 'package:student_clearance_application/views/schools.dart';



class HostelScreen extends StatefulWidget {
  const HostelScreen({Key? key}) : super(key: key);

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
          child: ListView(
        children: <Widget>[
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
                  //store selected value to local storage
                  sharedPrefs.write('hostel', selectedValue);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SchoolScreen()),
                  );
                },
              )),
        ],
      )),
    );
  }
}
