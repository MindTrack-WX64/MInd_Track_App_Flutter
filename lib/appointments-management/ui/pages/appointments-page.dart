import 'package:flutter/material.dart';
import '../../services/appointment-service.dart';
import 'package:mind_track_app/appointments-management/model/appointment.dart';
import 'package:mind_track_app/appointments-management/ui/pages/appointments-new-page.dart';

class AppointmentsPage extends StatefulWidget {
  final int patientId;

  const AppointmentsPage({Key? key, required this.patientId}) : super(key: key);

  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  late AppointmentService _appointmentService;
  List<Appointment> _appointments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _appointmentService = AppointmentService();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    try {
      List<Appointment> appointments = await _appointmentService.findByPatientId(widget.patientId);
      setState(() {
        _appointments = appointments;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _navigateToNewAppointmentPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentNewPage(patientId: widget.patientId),
      ),
    );
    if (result == true) {
      _fetchAppointments();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToNewAppointmentPage,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _appointments.length,
        itemBuilder: (context, index) {
          final appointment = _appointments[index];
          return ListTile(
            title: Text(appointment.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description: ${appointment.description}'),
                Text('Date: ${appointment.date}'),
                Text('Duration: ${appointment.duration.inMinutes} minutes'),
              ],
            ),
          );
        },
      ),
    );
  }
}