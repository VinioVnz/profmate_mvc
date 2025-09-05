class UserFirebaseModel {
  int? id;
  final String uid;
  final String nome;
  final String email;
  final String cpf;
  final String telefone;

  UserFirebaseModel({
    this.id,
    required this.uid,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.cpf,

  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'cpf': cpf,
    };
  }

  factory UserFirebaseModel.fromMap(Map<String, dynamic> map) {
    return UserFirebaseModel(
      id: map['id'],
      uid: map['uid'] ?? '',
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      telefone: map['telefone'] ?? '',
      cpf: map['cpf'] ?? '',
    );
  }
}
