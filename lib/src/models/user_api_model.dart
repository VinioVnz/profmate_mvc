class UserApiModel {
  final int? id;
  final String uid;
  final String nome;
  final String cpf;
  final String email;
  final String telefone;
  final String password;

  UserApiModel({
    this.id,
    required this.telefone,
    required this.uid,
    required this.nome,
    required this.cpf,
    required this.email,

    required this.password,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) {
    return UserApiModel(
      id: json['id'],
      uid: json['uid'] ?? '',
      nome: json['nome'],
      cpf: json['cpf'] ?? '',
      email: json['email'] ?? '',
      telefone: json['telefone'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'telefone': telefone,
      'password': password,
    };
  }
}
