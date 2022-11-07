import 'package:flutter/material.dart';

class AllusersPage extends StatefulWidget {
  const AllusersPage({Key? key}) : super(key: key);

  @override
  State<AllusersPage> createState() => _AllusersPageState();
}

class _AllusersPageState extends State<AllusersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('All users allowed'),
      centerTitle: true,
    ),
    );
    
  }
}