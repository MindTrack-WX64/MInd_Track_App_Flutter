import 'user.dart';

class Patient extends User {
  final int medicalHistoryId;
  final int prescriptionId;
  final int diagnosisId;
  final String name;
  final String lastName;
  final DateTime birthDay;
  final String phone;

  Patient({
    required int id,
    required String username,
    required String password,
    required String role,
    required this.medicalHistoryId,
    required this.prescriptionId,
    required this.diagnosisId,
    required this.name,
    required this.lastName,
    required this.birthDay,
    required this.phone,
  }) : super(id: id, username: username, password: password, role: role);

  @override
  Patient copyWith({
    int? id,
    String? username,
    String? password,
    String? role,
    int? medicalHistoryId,
    int? prescriptionId,
    int? diagnosisId,
    String? name,
    String? lastName,
    DateTime? birthDay,
    String? phone,
  }) {
    return Patient(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      medicalHistoryId: medicalHistoryId ?? this.medicalHistoryId,
      prescriptionId: prescriptionId ?? this.prescriptionId,
      diagnosisId: diagnosisId ?? this.diagnosisId,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birthDay: birthDay ?? this.birthDay,
      phone: phone ?? this.phone,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['medicalHistoryId'] = medicalHistoryId;
    json['prescriptionId'] = prescriptionId;
    json['diagnosisId'] = diagnosisId;
    json['name'] = name;
    json['lastName'] = lastName;
    json['birthDay'] = birthDay.toIso8601String();
    json['phone'] = phone;
    return json;
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      medicalHistoryId: json['medicalHistoryId'] ?? 0,
      prescriptionId: json['prescriptionId'] ?? 0,
      diagnosisId: json['diagnosisId'] ?? 0,
      name: json['name'] ?? '',
      lastName: json['lastName'] ?? '',
      birthDay: DateTime.parse(json['birthDay'] ?? '1970-01-01'),
      phone: json['phone'] ?? '',
    );
  }
}