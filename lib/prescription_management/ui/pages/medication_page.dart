// lib/prescription_management/ui/pages/medication_page.dart
import 'package:flutter/material.dart';
import 'package:mind_track_app/prescription_management/services/medication_service.dart';
import 'package:mind_track_app/prescription_management/model/medication.dart';
import 'package:mind_track_app/prescription_management/ui/pages/medication_form.dart';

class MedicationPage extends StatefulWidget {
  final int patientId;
  final String role; // Add role parameter

  const MedicationPage({Key? key, required this.patientId, required this.role}) : super(key: key);

  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  late MedicationService _medicationService;
  List<Medication> _medications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _medicationService = MedicationService();
    _fetchMedications();
  }

  Future<void> _fetchMedications() async {
    try {
      final medications = await _medicationService.fetchMedicationsByPatientId(widget.patientId);
      setState(() {
        _medications = medications;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching medications: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription'),
        actions: [
          if (widget.role == 'professional') // Show button only for professionals
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicationFormPage(patientId: widget.patientId),
                  ),
                );
              },
            ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _medications.length,
        itemBuilder: (context, index) {
          final medication = _medications[index];
          return _buildMedicationCard(medication);
        },
      ),
    );
  }

  Widget _buildMedicationCard(Medication medication) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${medication.title}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('Description: ${medication.description}'),
            SizedBox(height: 5),
            Text('Quantity: ${medication.quantity}'),
            SizedBox(height: 5),
            Text('Frequency: ${medication.frequency}'),
            SizedBox(height: 5),
            Text('Start Date: ${medication.startDate}'),
            SizedBox(height: 5),
            Text('End Date: ${medication.endDate}'),
          ],
        ),
      ),
    );
  }
}