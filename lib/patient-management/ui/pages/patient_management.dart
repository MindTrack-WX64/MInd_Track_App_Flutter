import 'package:flutter/material.dart';
import 'package:mind_track_app/shared/services/patient_service.dart';
import 'package:mind_track_app/shared/models/patient.dart';
import 'package:mind_track_app/prescription_management/ui/pages/medication_page.dart';
import 'package:mind_track_app/clinical-history/ui/pages/clinical-history-page.dart';
import 'package:mind_track_app/appointments-management/ui/pages/appointments-page.dart';
import 'package:mind_track_app/diagnosis-management/ui/pages/diagnosis-page.dart';

class PatientManagementPage extends StatefulWidget {
  final int professionalId;
  final String role; // Add role parameter

  const PatientManagementPage({Key? key, required this.professionalId, required this.role}) : super(key: key);

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
      List<Patient> patients = await _patientService.findByProfessionalId(widget.professionalId);
      setState(() {
        _patients = patients;
        _isLoading = false;
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
          return Container(
            padding: EdgeInsets.all(1.0),
            height: 350, // Adjust the height as needed
            child: ListTile(
              title: Text('${patient.name} ${patient.lastName}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${patient.id}'),
                  Text('Phone: ${patient.phone}'),
                  Text('Birthday: ${patient.birthDay}'),
                  SizedBox(height: 10), // Add space between information and buttons
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2, // Adjust the number of columns as needed
                      childAspectRatio: 3, // Adjust the aspect ratio as needed
                      children: [
                        _buildActionButton('Edit', Icons.edit, patient.id, widget.role),
                        _buildActionButton('Prescription', Icons.receipt, patient.id, widget.role),
                        _buildActionButton('Clinical History', Icons.history, patient.id, widget.role, patient.name),
                        _buildActionButton('Diagnosis', Icons.assignment, patient.id, widget.role),
                        _buildActionButton('Analytics', Icons.analytics, patient.id, widget.role),
                        _buildActionButton('Appointments', Icons.calendar_today, patient.id, widget.role),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, int patientId, String role, [String? patientName]) {
    return ElevatedButton.icon(
      onPressed: () {
        if (text == 'Prescription') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MedicationPage(
                patientId: patientId,
                role: role, // Pass the role here
              ),
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
                role: role, // Pass the role here
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
        } else if (text == 'Diagnosis') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiagnosisPage(
                patientId: patientId,
                role: role, // Pass the role here
              ),
            ),
          );
        } else {
          // Handle other button presses
        }
      },
      icon: Icon(icon),
      label: Text(text),
    );
  }
}