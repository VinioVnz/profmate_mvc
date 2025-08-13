class UserFirebaseModel {
  int? id;
  final String uid; //no firebase o id é um hash, n sequencial
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
      'uid': uid,
      'id': id,
      'nome': nome,
      'email': email,
      'cpf': cpf,
      'dataNasciento': dataNascimento,
    };
  }

  factory UserFirebaseModel.fromMap(Map<String, dynamic> map) {
    return UserFirebaseModel(
      uid: map['uid'],
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      cpf: map['cpf'],
      dataNascimento: map['dataNascimento'],
    );
  }
}
