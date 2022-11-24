import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pdf/widgets.dart' as pw;

import '../constants/app_constants.dart';

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
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async{
            final pdf = pw.Document();
            pdf.addPage(
              pw.Page(
                build: (pw.Context context) => pw.Center(
                  child: pw.Column(children: [
                    pw.Center(child: pw.Text('Kabarak University',)),
                    pw.Center(child: pw.Text('Student Clearance Form',))

                  ]
                  ),
      ),
              )
            );
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: 500,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: const Text('Download clearance certificate'),
                  onPressed: () {
                    firebaseGetData(documentID) {
                      firebaseFirestore
                          .collection('students')
                          .doc(currentUserUID)
                          .get()
                          .then((value) {
                        print(value.data());
                      });
                    }
                  },
                )
                ),
               ]
              ),
            );

            final file = File('clearance.pdf');
            await file.writeAsBytes(await pdf.save());
          },
           icon: const Icon(Icons.save_alt_outlined))
        ],
      ),
      
      body: StreamBuilder(
        stream: firebaseFirestore
            .collection(students)
            .doc(currentUserUID)
            .snapshots(),
        builder: (ctx, AsyncSnapshot streamSnapshot) {

          if(streamSnapshot.hasData){
            DocumentSnapshot<Object?> querySnapshot =
            streamSnapshot.data as DocumentSnapshot;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  /*
                  const Center(child: Text('Kabarak University',)),
                  const Center(child: Text('Student Clearance Certificate',)),
                  Center(child: Text(querySnapshot.get('school'))),
                   */
                  const Center(
                      child: Text(
                    'Kabarak University',
                  )),
                  const Center(
                      child: Text(
                    'Mercy Cherotich',
                  )),
                  DataTable(
                     columns: const <DataColumn>[
                        DataColumn(
                        label: Text(
                        'Details',
                          ),
                         ),
                      
                  /*
                      columns: const [
                        DataColumn(label: Text('Clearance')),*/
                      ],
                      rows: [
                        DataRow(cells: <DataCell>[
                          DataCell(Text(querySnapshot.get('department')),),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(querySnapshot.get('hostel')),),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(querySnapshot.get('school')),),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(querySnapshot.get('sports')),),
                        ]),
                        ]
                  ),
                ],
              ),
            ); 
          } else{
           return const CircularProgressIndicator();
          }

        },
      ),
      
    );
  }

  

  List _buildList(BuildContext context, List snapshot) {
    return  snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {

    return DataRow(cells: [
      DataCell(Text(data[''])),
      DataCell(Text(data[''])),
      DataCell(Text(data[''])),
    ]
    );
  }
}
