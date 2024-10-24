import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/patient.dart';

class PatientService {
  final String baseUrl = '10.0.2.2:3000';

  Future<Patient?> findById(int id) async {
    try {
      final response = await http.get(Uri.http(baseUrl, '/patients'));
      if (response.statusCode == 200) {
        final List<dynamic> patients = jsonDecode(response.body);
        for (var patient in patients) {
          if (patient['id'] == id) {
            return Patient.fromJson(patient);
          }
        }
        return null;
      } else {
        throw Exception('Failed to load patient');
      }
    } catch (e) {
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

  Future<List<Patient>> findByProfessionalId(int professionalId) async {
    try {
      final response = await http.get(Uri.http(baseUrl, '/patients'));
      if (response.statusCode == 200) {
        final List<dynamic> patients = jsonDecode(response.body);
        List<Patient> filteredPatients = patients
            .where((patient) => patient['professionalId'] == professionalId)
            .map((patient) => Patient.fromJson(patient))
            .toList();
        return filteredPatients;
      } else {
        throw Exception('Failed to load patients');
      }
    } catch (e) {
      print('Error fetching patients: $e');
      return [];
    }
  }

}