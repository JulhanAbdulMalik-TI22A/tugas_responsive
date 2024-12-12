class Student {
  final String id;
  final String name;
  final String prodi;
  final String email;
  final String avatar;
  final DateTime createdAt;

  Student({
    required this.id,
    required this.name,
    required this.prodi,
    required this.email,
    required this.avatar,
    required this.createdAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      prodi: json['prodi'],
      email: json['email'],
      avatar: json['avatar'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'prodi': prodi,
      'email': email,
      'avatar': avatar,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
