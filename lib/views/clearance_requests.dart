import 'package:flutter/material.dart';
// main method that runs the runApp.

void main() => runApp(SimpleDataTable());

class SimpleDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // MaterialApp with debugShowCheckedModeBanner false and home
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        // Scaffold with appbar ans body.
        appBar: AppBar(
          title: Text('Simple Data Table'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
              // Datatable widget that have the property columns and rows.
              columns: [
                // Set the name of the column
                DataColumn(
                  label: Text('ID'),
                ),
                DataColumn(
                  label: Text('Name'),
                ),
                DataColumn(
                  label: Text('LastName'),
                ),
                DataColumn(
                  label: Text('Age'),
                ),
              ], rows: [
            // Set the values to the columns
            DataRow(cells: [
              DataCell(Text("1")),
              DataCell(Text("Alex")),
              DataCell(Text("Anderson")),
              DataCell(Text("18")),
            ]),
            DataRow(cells: [
              DataCell(Text("2")),
              DataCell(Text("John")),
              DataCell(Text("Anderson")),
              DataCell(Text("24")),
            ]),
          ]),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClearanceRequests extends StatefulWidget {
  const ClearanceRequests({Key? key}) : super(key: key);

  @override
  State<ClearanceRequests> createState() => _ClearanceRequestsState();
}

class _ClearanceRequestsState extends State<ClearanceRequests> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Name',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Age',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Role',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William')),
            DataCell(Text('27')),
            DataCell(Text('Associate Professor')),
          ],
        ),
      ],
    );
  }
}
*/
