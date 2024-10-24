import 'package:flutter/material.dart';
import '../../model/diagnosis.dart';
import '../../services/diagnosis-service.dart';
import 'package:mind_track_app/diagnosis-management/ui/pages/diagnosis-new-page.dart';

class DiagnosisPage extends StatefulWidget {
  final int patientId;
  final String role; // Add role parameter

  const DiagnosisPage({Key? key, required this.patientId, required this.role}) : super(key: key);

  @override
  _DiagnosisPageState createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  late Future<List<Diagnosis>> _diagnosesFuture;
  final DiagnosisService _diagnosisService = DiagnosisService();

  @override
  void initState() {
    super.initState();
    _diagnosesFuture = _diagnosisService.getDiagnosesByPatientId(widget.patientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnoses for Patient ${widget.patientId}'),
        actions: [
          if (widget.role == 'professional') // Show button only for professionals
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiagnosisNewPage(patientId: widget.patientId),
                  ),
                );
                if (result == true) {
                  setState(() {
                    _diagnosesFuture = _diagnosisService.getDiagnosesByPatientId(widget.patientId);
                  });
                }
              },
            ),
        ],
      ),
      body: FutureBuilder<List<Diagnosis>>(
        future: _diagnosesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No diagnoses found.'));
          } else {
            final diagnoses = snapshot.data!;
            return ListView.builder(
              itemCount: diagnoses.length,
              itemBuilder: (context, index) {
                final diagnosis = diagnoses[index];
                return ListTile(
                  title: Text(diagnosis.diagnosis),
                  subtitle: Text('Date: ${diagnosis.date}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}