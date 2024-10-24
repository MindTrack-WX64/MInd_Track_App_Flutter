import 'package:flutter/material.dart';
import 'package:mind_track_app/shared/services/user-service.dart';
import 'package:mind_track_app/shared/services/patient_service.dart';
import 'package:mind_track_app/shared/services/professional_service.dart';
import 'package:mind_track_app/shared/models/user.dart';
import 'package:mind_track_app/shared/models/patient.dart';

class AddPatientPage extends StatefulWidget {
  final int professionalId;

  const AddPatientPage({Key? key, required this.professionalId});

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
            professionalId: widget.professionalId,
            username: _username,
            password: _password,
            role: 'Patient',
            name: _name,
            lastName: _lastName,
            birthDay: _birthDay,
            phone: _phone,
            medicalHistoryId: newUser.id,
            prescriptionId: newUser.id,
            diagnosisId: newUser.id
        );
        await _patientService.addPatient(newPatient);

        // Fetch the professional
        final professional = await _professionalService.findById(
            widget.professionalId);
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
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Add Patient')),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/bgAddPatient.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Centered icon
                Center(
                  child: Image.asset(
                    'assets/icAddPatient.png',
                    height: screenHeight * 0.20, // 20% of the screen height
                  ),
                ),
                SizedBox(height: 20),
                Card(
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
                          'Register Patient', // Updated text
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 25),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue),
                                          borderRadius: BorderRadius.circular(25.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue),
                                          borderRadius: BorderRadius.circular(25.0),
                                        ),
                                      ),
                                      onSaved: (value) => _name = value!,
                                      validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Last Name',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue),
                                          borderRadius: BorderRadius.circular(25.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue),
                                          borderRadius: BorderRadius.circular(25.0),
                                        ),
                                      ),
                                      onSaved: (value) => _lastName = value!,
                                      validator: (value) => value!.isEmpty ? 'Please enter a last name' : null,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Birth Day',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                onSaved: (value) => _birthDay = value!,
                                validator: (value) => value!.isEmpty ? 'Please enter a birth day' : null,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                onSaved: (value) => _phone = value!,
                                validator: (value) => value!.isEmpty ? 'Please enter a phone number' : null,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                onSaved: (value) => _username = value!,
                                validator: (value) => value!.isEmpty ? 'Please enter a username' : null,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                onSaved: (value) => _password = value!,
                                validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                                obscureText: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Background color
                        foregroundColor: Colors.white, // Text color
                        textStyle: TextStyle(fontSize: 24), // Button text size
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0), // Button padding
                      ),
                      child: Text('Add Patient'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}