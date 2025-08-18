class UserFirebaseModel {
  int? id;
  final String uid;
  final String nome;
  final String email;
  final String cpf;
  final DateTime dataNascimento;

  UserFirebaseModel({
    this.id,
    required this.uid,
    required this.nome,
    required this.email,
    required this.cpf,
    required this.dataNascimento,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'nome': nome,
      'email': email,
      'cpf': cpf,
      'dataNascimento': dataNascimento.toIso8601String(),
    };
  }

  factory UserFirebaseModel.fromMap(Map<String, dynamic> map) {
    return UserFirebaseModel(
      id: map['id'],
      uid: map['uid'] ?? '',
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      cpf: map['cpf'] ?? '',
      dataNascimento: map['dataNascimento'] != null
          ? DateTime.parse(map['dataNascimento'])
          : DateTime(2000, 1, 1),
    );
  }
}
