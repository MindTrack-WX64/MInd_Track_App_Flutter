class Diagnosis {
  final int id;
  final int patientId;
  final String diagnosis;
  final String date;

  Diagnosis({
    required this.id,
    required this.patientId,
    required this.diagnosis,
    required this.date,
  });

  Diagnosis copyWith({
    int? id,
    int? patientId,
    String? diagnosis,
    String? date,
  }) {
    return Diagnosis(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      diagnosis: diagnosis ?? this.diagnosis,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'diagnosis': diagnosis,
      'date': date,
    };
  }

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      id: json['id'] ?? 0,
      patientId: json['patientId'] ?? 0,
      diagnosis: json['diagnosis'] ?? '',
      date: json['date'] ?? '',
    );
  }
}