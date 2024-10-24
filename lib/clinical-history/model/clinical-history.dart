
class ClinicalHistory {
  final int id;
  final int patientId;
  final String background;
  final String consultationReason;
  final String createdAt;
  final String updatedAt;

  ClinicalHistory({
    required this.id,
    required this.patientId,
    required this.background,
    required this.consultationReason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClinicalHistory.fromJson(Map<String, dynamic> json) {
    return ClinicalHistory(
      id: json['id'],
      patientId: json['patientId'],
      background: json['background'],
      consultationReason: json['consultationReason'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'background': background,
      'consultationReason': consultationReason,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}