import 'package:flutter/material.dart';
import 'package:mind_track_app/clinical-history/model/clinical-history.dart';
import 'package:mind_track_app/clinical-history/services/clinical-history-service.dart';

class ClinicalHistoryEditPage extends StatefulWidget {
  final ClinicalHistory clinicalHistory;

  const ClinicalHistoryEditPage({Key? key, required this.clinicalHistory}) : super(key: key);

  @override
  _ClinicalHistoryEditPageState createState() => _ClinicalHistoryEditPageState();
}

class _ClinicalHistoryEditPageState extends State<ClinicalHistoryEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _backgroundController;
  late TextEditingController _consultationReasonController;
  late ClinicalHistoryService _clinicalHistoryService;

  @override
  void initState() {
    super.initState();
    _backgroundController = TextEditingController(text: widget.clinicalHistory.background);
    _consultationReasonController = TextEditingController(text: widget.clinicalHistory.consultationReason);
    _clinicalHistoryService = ClinicalHistoryService();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _consultationReasonController.dispose();
    super.dispose();
  }

  Future<void> _updateClinicalHistory() async {
    if (_formKey.currentState!.validate()) {
      final updatedClinicalHistory = ClinicalHistory(
        id: widget.clinicalHistory.id,
        patientId: widget.clinicalHistory.patientId,
        background: _backgroundController.text,
        consultationReason: _consultationReasonController.text,
        createdAt: widget.clinicalHistory.createdAt,
        updatedAt: DateTime.now().toIso8601String(),
      );

      await _clinicalHistoryService.updateClinicalHistory(updatedClinicalHistory);
      Navigator.pop(context, updatedClinicalHistory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Clinical History')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _backgroundController,
                decoration: InputDecoration(labelText: 'Background'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter background';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _consultationReasonController,
                decoration: InputDecoration(labelText: 'Consultation Reason'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter consultation reason';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateClinicalHistory,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}