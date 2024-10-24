import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  final String baseUrl = '10.0.2.2:3000';

  Future<void> addUser(User user) async {
    try {
      final response = await http.post(
        Uri.http(baseUrl, '/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to add user');
      }
    } catch (e) {
      print('Error adding user: $e');
    }
  }
}