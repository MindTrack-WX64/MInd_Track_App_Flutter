import 'package:flutter/material.dart';
import '../../services/appointment-service.dart';
import 'package:mind_track_app/appointments-management/model/appointment.dart';

class AppointmentNewPage extends StatefulWidget {
  final int patientId;

  const AppointmentNewPage({Key? key, required this.patientId}) : super(key: key);

  @override
  _AppointmentNewPageState createState() => _AppointmentNewPageState();
}

class _AppointmentNewPageState extends State<AppointmentNewPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();
  final AppointmentService _appointmentService = AppointmentService();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _saveAppointment() async {
    if (_formKey.currentState!.validate()) {
      final newAppointment = Appointment(
        id: 0, // ID will be assigned automatically
        patientId: widget.patientId,
        professionalId: 0, // Assign the appropriate professional ID
        title: _titleController.text,
        description: _descriptionController.text,
        date: DateTime.now(), // Date will be assigned automatically
        duration: Duration(minutes: int.parse(_durationController.text)),
      );

      await _appointmentService.createAppointment(newAppointment);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
                controller: _durationController,
                decoration: InputDecoration(labelText: 'Duration (minutes)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAppointment,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}