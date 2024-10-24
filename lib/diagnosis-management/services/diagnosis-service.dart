import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/diagnosis.dart';

class DiagnosisService {
  final String baseUrl = '10.0.2.2:3000';

  Future<List<Diagnosis>> getDiagnosesByPatientId(int patientId) async {
    try {
      final response = await http.get(Uri.http(baseUrl, '/diagnosis', {'patientId': patientId.toString()}));
      if (response.statusCode == 200) {
        final List<dynamic> diagnosesJson = jsonDecode(response.body);
        return diagnosesJson.map((json) => Diagnosis.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load diagnoses');
      }
    } catch (e) {
      throw Exception('Failed to load diagnoses: $e');
    }
  }
  Future<Diagnosis> addDiagnosis(Diagnosis diagnosis) async {
    try {
      final response = await http.post(
        Uri.http(baseUrl, '/diagnosis'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(diagnosis.toJson()),
      );
      if (response.statusCode == 201) {
        return Diagnosis.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add diagnosis');
      }
    } catch (e) {
      throw Exception('Failed to add diagnosis: $e');
    }
  }
}