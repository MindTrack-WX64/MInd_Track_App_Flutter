class Medication {
  final int patientId;
  final String title;
  final String description;
  final int quantity;
  final String frequency;
  final String startDate;
  final String endDate;

  Medication({
    required this.patientId,
    required this.title,
    required this.description,
    required this.quantity,
    required this.frequency,
    required this.startDate,
    required this.endDate,
  });

  // Convert a Medication object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'title': title,
      'description': description,
      'quantity': quantity,
      'frequency': frequency,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  // Create a Medication object from a JSON map
  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      patientId: json['patientId'],
      title: json['title'],
      description: json['description'],
      quantity: json['quantity'],
      frequency: json['frequency'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }
}