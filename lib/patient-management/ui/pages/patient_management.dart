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

class _PatientManagementPageState extends State<PatientManagementPage> with SingleTickerProviderStateMixin {
  late PatientService _patientService;
  List<Patient> _patients = [];
  bool _isLoading = true;
  Map<int, bool> _showOptions = {};
  Map<int, AnimationController> _animationControllers = {};

  @override
  void initState() {
    super.initState();
    _patientService = PatientService();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    try {
      //List<Patient> patients = await _patientService.findByProfessionalId(widget.professionalId);
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
        _animationControllers = {
          for (var patient in patients)
            patient.id: AnimationController(
              vsync: this,
              duration: Duration(milliseconds: 300),
            )
        };
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  void dispose() {
    for (var controller in _animationControllers.values) {
      controller.dispose();
    }
    super.dispose();
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
            margin: EdgeInsets.all(8.0),
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
                          Text('Phone: ${patient.phone}'),
                          Text('Birthday: ${patient.birthDay}'),
                        ],
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showOptions[patient.id] = !(_showOptions[patient.id] ?? false);
                              if (_showOptions[patient.id]!) {
                                _animationControllers[patient.id]?.forward();
                              } else {
                                _animationControllers[patient.id]?.reverse();
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _showOptions[patient.id] ?? false ? Colors.white : Colors.blue,
                            foregroundColor: _showOptions[patient.id] ?? false ? Colors.blue : Colors.white,
                          ),
                          child: Text('Options'),
                        ),
                      ),
                    ],
                  ),
                  SizeTransition(
                    sizeFactor: _animationControllers[patient.id]?.drive(CurveTween(curve: Curves.easeInOut)) ?? AlwaysStoppedAnimation(0.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        _buildActionButton('Edit', Icons.edit, patient.id),
                        _buildActionButton('Prescription', Icons.receipt, patient.id),
                        _buildActionButton('Clinical History', Icons.history, patient.id, patient.name),
                        _buildActionButton('Diagnosis', Icons.assignment, patient.id),
                        _buildActionButton('Analytics', Icons.analytics, patient.id),
                        _buildActionButton('Appointments', Icons.calendar_today, patient.id),
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
      icon: Icon(icon),
      label: Text(text),
    );
  }
}