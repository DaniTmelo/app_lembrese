class User {
  final int? id;
  final String name;
  final String email;
  final String password;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  /// Converte o objeto User em um Map para operações no banco de dados
  Map<String, dynamic> toMap() {
    final map = {
      'name': name,
      'email': email,
      'password': password,
    };
    if (id != null) {
      map['id'] = id as String;
    }
    return map;
  }

  /// Cria um objeto User a partir de um Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email}';
  }
}
