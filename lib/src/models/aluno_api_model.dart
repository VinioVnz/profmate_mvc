class AlunoApiModel {
  final int? id;
  final String nome;
  final String cpf;
  final String email;
  final String endereco;
  final String telefone;
  final String dataNascimento;
  final String? nomeResponsavel;
  final String? cpfResponsavel;

  AlunoApiModel(
    {
    this.id,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.endereco,
    required this.telefone,
    required this.dataNascimento,
    this.nomeResponsavel,
    this.cpfResponsavel,
  });

  factory AlunoApiModel.fromJson(Map<String, dynamic> json){
    return AlunoApiModel(
      id: json['id'],
      nome: json['nome'], 
      cpf: json['cpf'], 
      email: json['email'], 
      endereco: json['endereco'], 
      telefone: json['telefone'], 
      dataNascimento: json['dataNascimento'],
      nomeResponsavel: json['nomeResponsavel'],
      cpfResponsavel: json['cpfResponsavel']
      );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'endereco': endereco,
      'telefone': telefone,
      'dataNascimento': dataNascimento,
      'nomeResponsavel': nomeResponsavel,
      'cpfResponsavel': cpfResponsavel,
    };
  }
}
