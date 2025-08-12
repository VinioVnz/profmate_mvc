class UserFirebaseModel {
 final String uid; //no firebase o id é um hash, n sequencial
  final String nome;
  final String email;

  UserFirebaseModel({required this.uid, required this.nome, required this.email});

  Map<String, dynamic> toMap() {
    return {
     'uid': uid,
     'nome': nome,
     'email': email
    };
  }

  factory UserFirebaseModel.fromMap(Map<String, dynamic> map){
    return UserFirebaseModel(
      uid: map['uid'],
      nome: map['nome'],
      email: map['email']
    );
  }
}