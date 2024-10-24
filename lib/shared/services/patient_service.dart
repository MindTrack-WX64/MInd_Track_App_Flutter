import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/patient.dart';

class PatientService {
  final String baseUrl = '10.0.2.2:3000';

  Future<Patient?> findById(int id) async {
    print('Fetching all patients to find ID: $id');
    try {
      final response = await http.get(Uri.http(baseUrl, '/patients'));
      print('HTTP GET request to $baseUrl/patients completed with status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> patients = jsonDecode(response.body);
        for (var patient in patients) {
          if (patient['id'] == id) {
            print('Patient found with ID: $id');
            return Patient.fromJson(patient);
          }
        }
        print('No matching patient found with ID: $id');
        return null;
      } else {
        print('Failed to fetch patients. Status code: ${response.statusCode}');
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