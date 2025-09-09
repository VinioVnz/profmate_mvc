class PagamentoApiModel {
  final int? id;
  final double valorAula;
  final String vencimento;
  final String formaPagamento;
  final String frequenciaPagamento;
  final int idAluno;
  
  PagamentoApiModel(
    {
    this.id,
    required this.valorAula,
    required this.vencimento,
    required this.formaPagamento,
    required this.frequenciaPagamento,
    required this.idAluno, 
    });

  factory PagamentoApiModel.fromJson(Map<String, dynamic> json){
    return PagamentoApiModel(
      id: json['id'],
      valorAula: (json['valorAula'] as num).toDouble(),
      vencimento: json['vencimento'], 
      formaPagamento: json['formaPagamento'], 
      frequenciaPagamento: json['frequenciaPagamento'], 
      idAluno: json['aluno']?['id'] ?? 0
      );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'valorAula': valorAula,
      'vencimento': vencimento,
      'formaPagamento': formaPagamento,
      'frequenciaPagamento': frequenciaPagamento,
      'aluno_id' : idAluno
    };
  }
}