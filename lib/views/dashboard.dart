

import 'package:flutter/material.dart';
import 'package:student_clearance_application/views/adminonly.dart';
import 'package:student_clearance_application/views/allusers.dart';
import 'package:student_clearance_application/helpers/user_management.dart';
import 'package:student_clearance_application/views/login.dart';



class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(children: <Widget>[
          new UserAccountsDrawerHeader(accountName:Text(''), accountEmail: Text('')
          ),
          new ListTile(
            title: new Text('Allusers Page'),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(context, 
              new MaterialPageRoute(builder: (BuildContext context) => new AllusersPage())
              );
            },
          ),
          new ListTile(
              title: new Text('Admin Page'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AdminPage()));
              },
            ),
          new ListTile(
              title: new Text('Logout'),
              onTap: () {
                UserManagement().signOut();
              },
            ),
        ],
        ),
      ),
      body: Center(
        child: Center(
          child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
                height: 50,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    child: const Text('admin'),
                    onPressed: () {
                      
                    }
                )
            )
            
          ] 
          )
      ),
      )
    );
    
  }
}