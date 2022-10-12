import 'package:flutter/material.dart';
import 'package:student_clearance_application/constants/app_constants.dart';
import 'package:student_clearance_application/views/hostels.dart';

class ResidencyScreen extends StatefulWidget {
  const ResidencyScreen({Key? key}) : super(key: key);

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
            child: Column(children: [
              const Text(
                "Choose your residency. If you stay in the hostels, select resident. If not, select non-residents",
                style: TextStyle(fontSize: 18),
              ),
              const Divider(),
              ListTile(
                title: const Text("Resident"),
                leading: Radio(
                    value: "resident",
                    groupValue: residence,
                    onChanged: (value) {
                      setState(() {
                        residence = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text("Non-resident"),
                leading: Radio(
                    value: "non-resident",
                    groupValue: residence,
                    onChanged: (value) {
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

                      //save selected on local storage
                      sharedPrefs.write('residence', residence);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HostelScreen()),
                      );
                    },
                  )),
            ])));
  }
}
