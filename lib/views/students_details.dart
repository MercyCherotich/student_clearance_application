import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';


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
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: 500,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: const Text('Download clearance certificate'),
                  onPressed: () {},
                )),
          ],
        ),
      ),
    );
  }
}
