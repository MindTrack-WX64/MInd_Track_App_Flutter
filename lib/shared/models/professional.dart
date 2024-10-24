class Professional {
  final int id;
  final String name;
  final String specialty;
  final List<int> patientIds;
  final String plan;

  Professional({
    required this.id,
    required this.name,
    required this.specialty,
    required this.patientIds,
    required this.plan,
  });

  Professional copyWith({
    int? id,
    String? name,
    String? specialty,
    List<int>? patientIds,
    String? plan,
  }) {
    return Professional(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      patientIds: patientIds ?? this.patientIds,
      plan: plan ?? this.plan,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'patientIds': patientIds,
      'plan': plan,
    };
  }

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      id: json['id'] is int ? json['id'] : int.parse(json['id'] ?? '0'),
      name: json['name'] ?? '',
      specialty: json['specialty'] ?? '',
      patientIds: List<int>.from(json['patientIds'] ?? []),
      plan: json['plan'] ?? '',
    );
  }
}