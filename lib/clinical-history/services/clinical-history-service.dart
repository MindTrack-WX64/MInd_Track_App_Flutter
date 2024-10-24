import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mind_track_app/clinical-history/model/clinical-history.dart';

class ClinicalHistoryService {
  final String baseUrl = '10.0.2.2:3000';

  Future<ClinicalHistory?> fetchClinicalHistoryById(int id) async {
    try {
      print("Fetching Clinical History for ID: $id");
      final response = await http.get(Uri.http(baseUrl, '/clinicalHistories', {'id': '$id'}));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.isNotEmpty) {
          return ClinicalHistory.fromJson(jsonResponse[0]);
        } else {
          throw Exception('No clinical history found');
        }
      } else {
        throw Exception('Failed to load clinical history');
      }
    } catch (e) {
      print('Error fetching clinical history: $e');
      return null;
    }
  }

  Future<void> updateClinicalHistory(ClinicalHistory clinicalHistory) async {
    try {
      print("Updating Clinical History for ID: ${clinicalHistory.id}");
      final response = await http.put(
        Uri.http(baseUrl, '/clinicalHistories/${clinicalHistory.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(clinicalHistory.toJson()),
      );
      if (response.statusCode != 200) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update clinical history');
      }
    } catch (e) {
      print('Error updating clinical history: $e');
    }
  }
}