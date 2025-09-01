class PagamentoModel {
  final int id;
  final String nome;
  final double valor;
  final String status;

  PagamentoModel({
    required this.id,
    required this.nome,
    required this.valor,
    required this.status,
  });

  // Construtor para criar um Pagamento a partir de um Map
  factory PagamentoModel.fromMap(Map<String, dynamic> map) {
    return PagamentoModel(
      id: map['id'],
      nome: map['nome'],
      valor: map['valor'],
      status: map['status'],
    );
  }
}
