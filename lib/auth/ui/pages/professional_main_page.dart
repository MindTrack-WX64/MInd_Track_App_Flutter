import 'package:flutter/material.dart';

class ProfessionalMainPage extends StatelessWidget {
  final String role;

  const ProfessionalMainPage({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Professional Main Page')),
      body: Center(
        child: Text('Professional Role: $role'),
      ),
    );
  }
}