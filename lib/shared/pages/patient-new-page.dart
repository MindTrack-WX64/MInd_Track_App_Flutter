import 'package:flutter/material.dart';
import 'package:mind_track_app/shared/services/user-service.dart';
import 'package:mind_track_app/shared/services/patient_service.dart';
import 'package:mind_track_app/shared/services/professional_service.dart';
import 'package:mind_track_app/shared/models/user.dart';
import 'package:mind_track_app/shared/models/patient.dart';

class AddPatientPage extends StatefulWidget {
  final int professionalId;

  const AddPatientPage({Key? key, required this.professionalId}) : super(key: key);

  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _lastName = '';
  String _birthDay = '';
  String _phone = '';
  String _username = '';
  String _password = '';

  final UserService _userService = UserService();
  final PatientService _patientService = PatientService();
  final ProfessionalService _professionalService = ProfessionalService();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Create User
        User newUser = User(
          id: 1505,
          username: _username,
          password: _password,
          role: 'Patient',
        );
        await _userService.addUser(newUser);

        // Create Patient
        Patient newPatient = Patient(
          id: 1505,
          username: _username,
          password: _password,
          role: 'Patient',
          name: _name,
          lastName: _lastName,
          birthDay: _birthDay,
          phone: _phone,
          medicalHistoryId: newUser.id,
          prescriptionId: newUser.id,
          diagnosisId: newUser.id,
          professionalId: widget.professionalId,
        );
        await _patientService.addPatient(newPatient);

        // Fetch the professional
        final professional = await _professionalService.findById(widget.professionalId);
        if (professional != null) {
          // Add the new patient's ID to the professional's patientIds list
          professional.patientIds.add(newPatient.id);

          // Update the professional on the server
          await _professionalService.updateProfessional(professional);
        }

        // Navigate back after successful addition
        Navigator.pop(context);
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Patient')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                onSaved: (value) => _lastName = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a last name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Birth Day'),
                onSaved: (value) => _birthDay = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a birth day' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                onSaved: (value) => _phone = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a phone number' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                onSaved: (value) => _username = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a username' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                onSaved: (value) => _password = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Patient'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}