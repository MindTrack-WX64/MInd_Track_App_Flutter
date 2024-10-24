import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/appointment.dart';

class AppointmentService {
  static const String baseUrl = '10.0.2.2:3000';

  Future<List<Appointment>> findByProfessionalId(int professionalId) async {
    final response = await http.get(Uri.http(baseUrl,'/appointments',{'patientId': '$professionalId'}));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Appointment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  Future<List<Appointment>> findByPatientId(int patientId) async {
    final response = await http.get(Uri.http(baseUrl,'/appointments',{'patientId': '$patientId'}));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Appointment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load appointments');
    }
  }
}