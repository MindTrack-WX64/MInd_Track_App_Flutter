import 'package:flutter/material.dart';
import 'package:mind_track_app/shared/models/professional.dart';
import "package:mind_track_app/shared/services/professional_service.dart";

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
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _professional == null
            ? Text('Professional not found false state')
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Professional Name: ${_professional!.name}'),
            Text('Specialty: ${_professional!.specialty}'),
            Text('Plan: ${_professional!.plan}'),
            Text('Patient IDs: ${_professional!.patientIds.join(', ')}'),
          ],
        ),
      ),
    );
  }
}