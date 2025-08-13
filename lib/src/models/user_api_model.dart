class UserApiModel {
  final int? id;
  final String uid;
  final String nome;
  final String cpf;
  final String email;
  final String password;
  final DateTime dataNascimento;
  UserApiModel({
    this.id,
    required this.uid,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.dataNascimento,
    required this.password,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) {
    return UserApiModel(
      id: json['id'],
      uid: json['uid'] ?? '',
      nome: json['nome'],
      cpf: json['cpf'] ?? '',
      email: json['email'] ?? '',
      dataNascimento: json['dataNascimento'] != null
          ? DateTime.parse(json['dataNascimento'])
          : DateTime(2000, 1, 1), //so valor padrao pra o vscode parar de encher o saco
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
      'password': password,
      'dataNascimento': dataNascimento.toIso8601String(),//passar pra string pq por algm motivo n aceitava com o datetime
    };
  }
}
