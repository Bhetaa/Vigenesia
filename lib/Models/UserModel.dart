class User {
  final String name;
  final String profession;
  final String email;
  final String password;

  User({
    required this.name,
    required this.profession,
    required this.email,
    required this.password,
  });

  // Method to convert User to a Map for JSON encoding
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profesi': profession,
      'email': email,
      'password': password,
    };
  }
}
