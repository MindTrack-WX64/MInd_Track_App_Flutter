import 'package:flutter/material.dart';
import '../../../shared/services/auth_service.dart';
import '../../../shared/models/user.dart';
import 'professional_main_page.dart';
import 'patient_main_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    try {
      //final User user = await _authService.signIn(
      //  _usernameController.text,
      //  _passwordController.text,
      //);
//
      //print('Login successful: ${user.username}');
      //print('User role: ${user.role}');
      var role = 'Professional';
      if (role == 'Professional') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfessionalMainPage(professionalId: 2),
          ),
        );
      } else if (role == 'Patient') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientMainPage(role: role),
          ),
        );
      } else {
        print('Unknown role: ${role}');
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: Incorrect credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}