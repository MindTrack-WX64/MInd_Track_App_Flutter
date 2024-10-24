import 'package:flutter/material.dart';
import 'package:mind_track_app/prescription_management/ui/pages/medication_page.dart';
import 'package:mind_track_app/clinical-history/ui/pages/clinical-history-page.dart';
import 'package:mind_track_app/appointments-management/ui/pages/appointments-page.dart';
import 'package:mind_track_app/diagnosis-management/ui/pages/diagnosis-page.dart';

class PatientMainPage extends StatelessWidget {
  final String role;
  final String patientName;
  final int patientId;

  const PatientMainPage({
    Key? key,
    required this.role,
    required this.patientName,
    required this.patientId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Main Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient: $patientName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Role: $role',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Patient ID: $patientId',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildGridButton(context, 'Prescription', role, patientId),
                  _buildGridButton(context, 'Clinical History', role, patientId),
                  _buildGridButton(context, 'Diagnosis', role, patientId),
                  _buildGridButton(context, 'Appointments', role, patientId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridButton(BuildContext context, String text, String role, int patientId) {
    if (role == 'patient' && text == 'Prescription') {
      return SizedBox.shrink(); // Hide the button for patients
    }

    return ElevatedButton(
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
        } else if (text == 'Clinical History') {
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
              builder: (context) => AppointmentsPage(
                patientId: patientId
              ),
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
      child: Text(text),
    );
  }
}