// lib/prescription_management/services/medication_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mind_track_app/prescription_management/model/medication.dart';

class MedicationService {
  final String baseUrl = '10.0.2.2:3000';

  Future<List<Medication>> fetchMedicationsByPatientId(int patientId) async {
    try {
      final response = await http.get(Uri.http(baseUrl, '/medications', {'patientId': '$patientId'}));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Medication.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load medications');
      }
    } catch (e) {
      print('Error fetching medications: $e');
      return [];
    }
  }

  Future<void> addMedication(Medication medication) async {
    try {
      final response = await http.post(
        Uri.http(baseUrl, '/medications'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(medication.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to add medication');
      }
    } catch (e) {
      print('Error adding medication: $e');
    }
  }
}