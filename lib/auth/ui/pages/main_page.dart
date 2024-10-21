import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final String role;

  MainPage({required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Page')),
      body: Center(
        child: Text('User Role: $role'),
      ),
    );
  }
}