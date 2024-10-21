import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthService {
  final String baseUrl = '10.0.2.2:3000';

  Future<User> signIn(String username, String password) async {
    print('Attempting to sign in with Username: $username, Password: $password');
    try {
      final response = await http.get(Uri.http(baseUrl, '/users'));
      print('HTTP GET request to $baseUrl/users completed with status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> users = jsonDecode(response.body);
        for (var user in users) {
          if (user['username'] == username && user['password'] == password) {
            print('User found: ${user['username']}');
            return User.fromJson(user);
          }
        }
        print('No matching user found');
        throw Exception('Incorrect credentials');
      } else {
        print('Failed to fetch users. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in');
      }
    } catch (e) {
      print('Error during sign in: $e');
      throw Exception('Failed to sign in');
    }
  }
}