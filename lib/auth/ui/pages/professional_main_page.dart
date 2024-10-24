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
      final professional = await _professionalService.findById(widget.professionalId);
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
          : Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bgAddPatient.png',
              fit: BoxFit.cover,
            ),
          ),
          // Mostrar la información del profesional
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 25),
                // Mostrar datos de la API en una Card adicional
                if (_professional != null)
                  ProfessionalInfo(professional: _professional!),
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
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Background color
          foregroundColor: Colors.white, // Botón azul
          textStyle: TextStyle(fontSize: 24), // Button text size
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0), // Padding interno
        ),
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
    return Card(
      color: Colors.white, // Card color set to white
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0), // Border radius 30
      ),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Professional Data', // Updated text
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Center(
              child: Image.asset(
                'assets/icAddPatient.png',
                height: 150,
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Professional name:', style: TextStyle(fontSize: 22)),
                Text('${professional.name}', style: TextStyle(fontSize: 22)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Specialty:', style: TextStyle(fontSize: 22)),
                Text('${professional.specialty}', style: TextStyle(fontSize: 22)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Plan:', style: TextStyle(fontSize: 22)),
                Text('${professional.plan}', style: TextStyle(fontSize: 22)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Patients IDs:', style: TextStyle(fontSize: 22)),
                Text('${professional.patientIds.join(', ')}', style: TextStyle(fontSize: 22)),
              ],
            )
          ],
        ),
      ),
    );
  }
}