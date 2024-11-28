class User {
  final int id;
  final String name;
  final String email;
  final int point;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.email,
    // required this.point,
    this.point = 0,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      point: map['point'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'point': point,
      'password': password,
    };
  }
}