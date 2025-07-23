class CadastroAlunoModel {
  final String nome;
  final String cpf;
  final String email;
  final String endereco;
  final String telefone;
  final DateTime dataNascimento;
  final double valorAula;
  final DateTime vencimento;
  final String formaPagamento;
  final String frequenciaPagamento;
  final String? nomeResponsavel;
  final String? cpfResponsavel;

  CadastroAlunoModel({
    required this.nome,
    required this.cpf,
    required this.email,
    required this.endereco,
    required this.telefone,
    required this.dataNascimento,
    required this.valorAula,
    required this.vencimento,
    required this.formaPagamento,
    required this.frequenciaPagamento,
    this.nomeResponsavel,
    this.cpfResponsavel,

  });
}