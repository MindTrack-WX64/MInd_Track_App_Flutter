
import 'package:flutter/material.dart';
import 'package:mind_track_app/prescription_management/services/medication_service.dart';
import 'package:mind_track_app/prescription_management/model/medication.dart';

class MedicationFormPage extends StatefulWidget {
  final int patientId;

  const MedicationFormPage({Key? key, required this.patientId}) : super(key: key);

  @override
  _MedicationFormPageState createState() => _MedicationFormPageState();
}

class _MedicationFormPageState extends State<MedicationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _frequencyController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  late MedicationService _medicationService;

  @override
  void initState() {
    super.initState();
    _medicationService = MedicationService();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _frequencyController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _addMedication() async {
    if (_formKey.currentState!.validate()) {
      final newMedication = Medication(
        patientId: widget.patientId,
        title: _titleController.text,
        description: _descriptionController.text,
        quantity: int.parse(_quantityController.text),
        frequency: _frequencyController.text,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
      );

      try {
        await _medicationService.addMedication(newMedication);
        Navigator.pop(context);
      } catch (e) {
        print('Error adding medication: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Medication')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _frequencyController,
                decoration: InputDecoration(labelText: 'Frequency'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a frequency';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(labelText: 'Start Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a start date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(labelText: 'End Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an end date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addMedication,
                child: Text('Add Medication'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}