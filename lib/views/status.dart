import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MyStatusPage extends StatefulWidget {
  /// Creates the home page.
  MyStatusPage({Key? key}) : super(key: key);

  @override
  _MyStatusPageState createState() => _MyStatusPageState();
}

class _MyStatusPageState extends State<MyStatusPage> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clearance status'),
      ),
      body: SfDataGrid(
        source: employeeDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'approvalLevel',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text('Approval level'))),
          GridColumn(
              columnName: 'status',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Status',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'action',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text('Action'))),
        ],
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee('School', 'pending', 'view Comments'),
      Employee('Department',  'pending','view Comments'),
      Employee('Sport', 'pending', 'view Comments'),
      Employee('Hostel', 'pending','view comments'),
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.approvalLevel, this.status, this.action);

  /// Id of an employee.
  final String approvalLevel;

  /// Name of an employee.
  final String status;

  /// Designation of an employee.
  final String action;


}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: e.approvalLevel),
              DataGridCell<String>(
                  columnName: 'department', value: e.status),
                  DataGridCell<String>(columnName: 'action', value: e.action),
             
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
