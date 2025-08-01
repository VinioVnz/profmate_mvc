class PagamentoApiModel {
  final int? id;
  final double valorAula;
  final String vencimento;
  final String formaPagamento;
  final String frequenciaPagamento;
  
  PagamentoApiModel(
    {
    this.id,
    required this.valorAula,
    required this.vencimento,
    required this.formaPagamento,
    required this.frequenciaPagamento,
    });

  factory PagamentoApiModel.fromJson(Map<String, dynamic> json){
    return PagamentoApiModel(
      id: json['id'],
      valorAula: json['valorAula'], 
      vencimento: json['vencimento'], 
      formaPagamento: json['formaPagamento'], 
      frequenciaPagamento: json['frequenciaPagamento'], 
      );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'valorAula': valorAula,
      'vencimento': vencimento,
      'formaPagamento': formaPagamento,
      'frequenciaPagamento': frequenciaPagamento,
    };
  }
}