import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/patient.dart';

class PatientService {
  final String baseUrl = '10.0.2.2:3000';

  Future<Patient?> findById(int id) async {
    try {
      final response = await http.get(Uri.http(baseUrl, '/patients/$id'));
      if (response.statusCode == 200) {
        return Patient.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load patient');
      }
    } catch (e) {
      print('Error fetching patient: $e');
      return null;
    }
  }

  Future<void> addPatient(Patient patient) async {
    try {
      final response = await http.post(
        Uri.http(baseUrl, '/patients'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(patient.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to add patient');
      }
    } catch (e) {
      print('Error adding patient: $e');
    }
  }
}