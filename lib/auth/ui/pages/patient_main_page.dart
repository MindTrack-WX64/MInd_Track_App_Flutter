import 'package:flutter/material.dart';

class PatientMainPage extends StatelessWidget {
  final String role;

  const PatientMainPage({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Main Page')),
      body: Center(
        child: Text('Patient Role: $role'),
      ),
    );
  }
}