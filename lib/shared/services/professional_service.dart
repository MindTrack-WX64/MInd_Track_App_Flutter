import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/professional.dart';

class ProfessionalService {
  final String baseUrl = '10.0.2.2:3000';

  Future<Professional?> findById(int id) async {
    try {
      final response = await http.get(Uri.http(baseUrl, '/professionals/$id'));
      if (response.statusCode == 200) {
        return Professional.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load professional');
      }
    } catch (e) {
      print('Error fetching professional: $e');
      return null;
    }
  }

  Future<void> addProfessional(Professional professional) async {
    try {
      final response = await http.post(
        Uri.http(baseUrl, '/professionals'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(professional.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to add professional');
      }
    } catch (e) {
      print('Error adding professional: $e');
    }
  }
}