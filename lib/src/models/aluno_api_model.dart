import 'package:profmate/src/models/pagamento_api_model.dart';
import 'package:profmate/src/models/user_api_model.dart';

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
  int? usuarioId;
  final List<PagamentoApiModel>? pagamentos;
  final UserApiModel? usuario;
  AlunoApiModel({
    this.id,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.endereco,
    required this.telefone,
    required this.dataNascimento,
    required this.usuarioId,
    this.nomeResponsavel,
    this.cpfResponsavel,
    this.pagamentos,
    this.usuario,
  });

  factory AlunoApiModel.fromJson(Map<String, dynamic> json) {
    return AlunoApiModel(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      email: json['email'],
      endereco: json['endereco'],
      telefone: json['telefone'],
      dataNascimento: json['dataNascimento'],
      nomeResponsavel: json['nomeResponsavel'],
      cpfResponsavel: json['cpfResponsavel'],
      pagamentos: json['pagamentos'] != null
          ? (json['pagamentos'] as List)
                .map((e) => PagamentoApiModel.fromJson(e))
                .toList()
          : [],
      usuarioId: json['usuario']?['id'],
      usuario: json['usuario'] != null
          ? UserApiModel.fromJson(json['usuario'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
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
      'usuarioId': usuarioId,
      'usuario': usuario?.toJson(),
    };
  }
}