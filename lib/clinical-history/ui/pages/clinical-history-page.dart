import 'package:flutter/material.dart';
import 'package:mind_track_app/clinical-history/model/clinical-history.dart';
import 'package:mind_track_app/clinical-history/services/clinical-history-service.dart';
import 'package:mind_track_app/clinical-history/ui/pages/clinical-history-edit-page.dart';

class ClinicalHistoryPage extends StatefulWidget {
  final int patientId;
  final int clinicalHistoryId;
  final String patientName;

  const ClinicalHistoryPage({
    Key? key,
    required this.patientId,
    required this.clinicalHistoryId,
    required this.patientName,
  }) : super(key: key);

  @override
  _ClinicalHistoryPageState createState() => _ClinicalHistoryPageState();
}

class _ClinicalHistoryPageState extends State<ClinicalHistoryPage> {
  late ClinicalHistoryService _clinicalHistoryService;
  ClinicalHistory? _clinicalHistory;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _clinicalHistoryService = ClinicalHistoryService();
    _fetchClinicalHistory();
  }

  Future<void> _fetchClinicalHistory() async {
    try {
      final clinicalHistory = await _clinicalHistoryService.fetchClinicalHistoryById(widget.clinicalHistoryId);
      setState(() {
        _clinicalHistory = clinicalHistory;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching clinical history: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clinical History')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _clinicalHistory == null
          ? Center(child: Text('No clinical history found'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient Name: ${widget.patientName}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Background: ${_clinicalHistory!.background}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Consultation Reason: ${_clinicalHistory!.consultationReason}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Created At: ${_clinicalHistory!.createdAt}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Updated At: ${_clinicalHistory!.updatedAt}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClinicalHistoryEditPage(
                        clinicalHistory: _clinicalHistory!,
                      ),
                    ),
                  );
                },
                child: Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}