// lib/patient-management/ui/pages/patient_management.dart
import 'package:flutter/material.dart';
import 'package:mind_track_app/shared/services/patient_service.dart';
import 'package:mind_track_app/shared/models/patient.dart';
import 'package:mind_track_app/prescription_management/ui/pages/medication_page.dart';
import 'package:mind_track_app/clinical-history/ui/pages/clinical-history-page.dart';
import 'package:mind_track_app/appointments-management/ui/pages/appointments-page.dart';

class PatientManagementPage extends StatefulWidget {
  final int professionalId;

  const PatientManagementPage({Key? key, required this.professionalId}) : super(key: key);

  @override
  _PatientManagementPageState createState() => _PatientManagementPageState();
}

class _PatientManagementPageState extends State<PatientManagementPage> {
  late PatientService _patientService;
  List<Patient> _patients = [];
  bool _isLoading = true;
  Map<int, bool> _showOptions = {};

  @override
  void initState() {
    super.initState();
    _patientService = PatientService();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    try {
      List<Patient> patients = [
        Patient(
          id: 1,
          professionalId: 2,
          username: 'patient1',
          password: 'password',
          role: 'Patient',
          name: 'John',
          lastName: 'Doe',
          birthDay: '01/01/1990',
          phone: '1234567890',
          medicalHistoryId: 1,
          prescriptionId: 1,
          diagnosisId: 1,
        ),
        Patient(
          id: 2,
          professionalId: 2,
          username: 'patient2',
          password: 'password',
          role: 'Patient',
          name: 'Jane',
          lastName: 'Doe',
          birthDay: '01/01/1995',
          phone: '1234567890',
          medicalHistoryId: 2,
          prescriptionId: 2,
          diagnosisId: 2,
        ),
      ];
      setState(() {
        _patients = patients;
        _isLoading = false;
        _showOptions = {for (var patient in patients) patient.id: false};
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${patient.name} ${patient.lastName}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('ID: ${patient.id}'),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 16),
                              SizedBox(width: 4),
                              Text('Phone: ${patient.phone}'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.cake, size: 16),
                              SizedBox(width: 4),
                              Text('Birthday: ${patient.birthDay}'),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showOptions[patient.id] = !(_showOptions[patient.id] ?? false);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _showOptions[patient.id] ?? false ? Colors.white : Colors.blue,
                          foregroundColor: _showOptions[patient.id] ?? false ? Colors.blue : Colors.white,
                        ),
                        child: Text('Options'),
                      ),
                    ],
                  ),
                  if (_showOptions[patient.id] ?? false) ...[
                    SizedBox(height: 8.0), // Margin above the buttons
                    GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      children: [
                        _buildActionButton('Edit', Icons.edit, patient.id),
                        _buildActionButton('Prescription', Icons.receipt, patient.id),
                        _buildActionButton('Clinical History', Icons.history, patient.id, patient.name),
                        _buildActionButton('Diagnosis', Icons.assignment, patient.id),
                        _buildActionButton('Analytics', Icons.analytics, patient.id),
                        _buildActionButton('Appointments', Icons.calendar_today, patient.id),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, int patientId, [String? patientName]) {
    return ElevatedButton.icon(
      onPressed: () {
        if (text == 'Prescription') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MedicationPage(patientId: patientId),
            ),
          );
        } else if (text == 'Clinical History' && patientName != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClinicalHistoryPage(
                patientId: patientId,
                clinicalHistoryId: patientId,
                patientName: patientName,
              ),
            ),
          );
        } else if (text == 'Appointments') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentsPage(patientId: patientId),
            ),
          );
        } else {
          // Handle other button presses
        }
      },
      icon: Icon(icon, color: Colors.blue),
      label: Text(text, style: TextStyle(color: Colors.blue)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Button background color
      ),
    );
  }
}