


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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Clearance Requests'),
      )
    );
  }
}