import 'user.dart';

class Patient extends User {
  final int medicalHistoryId;
  final int prescriptionId;
  final int diagnosisId;
  final String name;
  final String lastName;
  final String birthDay;
  final String phone;
  final int professionalId;

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
    required this.professionalId,
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
    String? birthDay,
    String? phone,
    int? professionalId,
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
      professionalId: professionalId ?? this.professionalId,
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
    json['birthDay'] = birthDay;
    json['phone'] = phone;
    json['professionalId'] = professionalId;
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
      birthDay: json['birthDay'] ?? '',
      phone: json['phone'] ?? '',
      professionalId: json['professionalId'] ?? 0,
    );
  }
}