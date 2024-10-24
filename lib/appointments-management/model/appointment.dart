
class Appointment {
  final int id;
  final int patientId;
  final int professionalId;
  final String title;
  final String description;
  final DateTime date;
  final Duration duration;

  Appointment({
    required this.id,
    required this.patientId,
    required this.professionalId,
    required this.title,
    required this.description,
    required this.date,
    required this.duration,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patientId: json['patientId'],
      professionalId: json['professionalId'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      duration: Duration(minutes: json['duration']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'professionalId': professionalId,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'duration': duration.inMinutes,
    };
  }
}