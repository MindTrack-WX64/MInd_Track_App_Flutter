class User {
  final int id;
  final String username;
  final String password;
  final String role;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
  });

  User copyWith({
    int? id,
    String? username,
    String? password,
    String? role,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'role': role,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.tryParse(json['id'].toString()) ?? 0,
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
    );
  }
}