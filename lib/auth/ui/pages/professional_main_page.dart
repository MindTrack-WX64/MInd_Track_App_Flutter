import 'package:flutter/material.dart';
import 'package:mind_track_app/shared/models/professional.dart';
import 'package:mind_track_app/shared/services/professional_service.dart';
import 'package:mind_track_app/patient-management/ui/pages/patient_management.dart';
import 'package:mind_track_app/shared/pages/patient-new-page.dart'; // Import the AddPatientPage

class ProfessionalMainPage extends StatefulWidget {
  final int professionalId;

  const ProfessionalMainPage({Key? key, required this.professionalId}) : super(key: key);

  @override
  _ProfessionalMainPageState createState() => _ProfessionalMainPageState();
}

class _ProfessionalMainPageState extends State<ProfessionalMainPage> {
  late ProfessionalService _professionalService;
  Professional? _professional;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _professionalService = ProfessionalService();
    _fetchProfessional();
  }

  Future<void> _fetchProfessional() async {
    try {
      //final professional = await _professionalService.findById(widget.professionalId);
      final professional = Professional(
        id: 2,
        name: "Dr. Smith",
        specialty: "therapist",
        patientIds: [1, 22],
        plan: "Premium",
      );
      setState(() {
        _professional = professional;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching professional: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Professional Main Page')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _professional == null
          ? Center(child: Text('Professional not found'))
          : Column(
        children: [
          ProfessionalInfo(professional: _professional!),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                _buildGridButton('Patients', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientManagementPage(professionalId: widget.professionalId),
                    ),
                  );
                }),
                _buildGridButton('Add Patient', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPatientPage(professionalId: widget.professionalId),
                    ),
                  );
                }),
                _buildGridButton('Profile', () {}),
                _buildGridButton('Log Out', () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

class ProfessionalInfo extends StatelessWidget {
  final Professional professional;

  const ProfessionalInfo({Key? key, required this.professional}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Professional Name: ${professional.name}', style: TextStyle(fontSize: 18)),
          Text('Specialty: ${professional.specialty}', style: TextStyle(fontSize: 18)),
          Text('Plan: ${professional.plan}', style: TextStyle(fontSize: 18)),
          Text('Patient IDs: ${professional.patientIds.join(', ')}', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}