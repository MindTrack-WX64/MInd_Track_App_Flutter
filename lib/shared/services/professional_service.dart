import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/professional.dart';

class ProfessionalService {
  final String baseUrl = '10.0.2.2:3000';

  Future<Professional?> findById(int id) async {
    print('Fetching all professionals to find ID: $id');
    try {
      final response = await http.get(Uri.http(baseUrl, '/professionals'));
      print('HTTP GET request to $baseUrl/professionals completed with status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> professionals = jsonDecode(response.body);
        for (var professional in professionals) {
          if (professional['id'] == id) {
            print('Professional found with ID: $id');
            return Professional.fromJson(professional);
          }
        }
        print('No matching professional found with ID: $id');
        return null;
      } else {
        print('Failed to fetch professionals. Status code: ${response.statusCode}');
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