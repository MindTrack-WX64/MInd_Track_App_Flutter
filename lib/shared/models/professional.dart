class Professional {
  final int id;
  final String name;
  final String specialty;

  Professional({
    required this.id,
    required this.name,
    required this.specialty,
  });

  Professional copyWith({
    int? id,
    String? name,
    String? specialty,
  }) {
    return Professional(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
    };
  }

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      specialty: json['specialty'] ?? '',
    );
  }
}