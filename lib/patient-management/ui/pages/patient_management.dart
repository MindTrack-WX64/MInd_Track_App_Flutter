import 'package:flutter/material.dart';
import 'package:mind_track_app/shared/services/patient_service.dart';
import 'package:mind_track_app/shared/models/patient.dart';

class PatientManagementPage extends StatefulWidget {
  final List<int> patientIds;

  const PatientManagementPage({Key? key, required this.patientIds}) : super(key: key);

  @override
  _PatientManagementPageState createState() => _PatientManagementPageState();
}

class _PatientManagementPageState extends State<PatientManagementPage> {
  late PatientService _patientService;
  List<Patient> _patients = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _patientService = PatientService();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    try {
      List<Patient> patients = [];
      for (int id in widget.patientIds) {
        final patient = await _patientService.findById(id);
        if (patient != null) {
          patients.add(patient);
        }
      }
      setState(() {
        _patients = patients;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching patients: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Management')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _patients.length,
        itemBuilder: (context, index) {
          final patient = _patients[index];
          return ListTile(
            title: Text('${patient.name} ${patient.lastName}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${patient.id}'),
                Text('Phone: ${patient.phone}'),
                Text('Birthday: ${patient.birthDay.toLocal().toIso8601String().split('T').first}'),
              ],
            ),
          );
        },
      ),
    );
  }
}