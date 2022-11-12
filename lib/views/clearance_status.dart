import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pdf/widgets.dart' as pw;

import '../constants/app_constants.dart';

class ClearanceStatus extends StatefulWidget {
  const ClearanceStatus({Key? key}) : super(key: key);

  @override
  State<ClearanceStatus> createState() => _ClearanceStatusState();
}

class _ClearanceStatusState extends State<ClearanceStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: true,
      title: const Text('Clearance Status'),
      actions: [
          IconButton(onPressed: () async{
            final pdf = pw.Document();
            pdf.addPage(
              pw.Page(
                build: (pw.Context context) => pw.Center(
                  child: pw.Column(children: [
                    pw.Center(child: pw.Text('Kabarak University',)),
                    pw.Center(child: pw.Text('Student Clearance Form',))

                  ]),
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
          }, icon: const Icon(Icons.save_alt_outlined))
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
                  const Center(child: Text('Kabarak University',)),
                  const Center(child: Text('Student Clearance Certificate',)),
                  Center(child: Text(querySnapshot.get('school'))),

                  DataTable(
                      columns: const [
                        DataColumn(label: Text('')),
                      ],
                      rows: [
                        DataRow(cells: [
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
}
