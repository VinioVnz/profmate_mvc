class FinanceiroModel {
  final String? id;
  final DateTime vencimento;
  final String nomeAluno;
  final double custoAula;
  final String? fotoUrl;
  final bool estaPago;

  FinanceiroModel({ 
    required this.id,
    required this.vencimento,
    required this.nomeAluno,
    required this.custoAula,
    required this.fotoUrl,
    required this.estaPago,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vencimento': vencimento,
      'nomeAluno': nomeAluno,
      'custoAula': custoAula,
      'fotoUrl': fotoUrl,
      'estaPago': estaPago,
    };
  }

  factory FinanceiroModel.fromJson(Map<String, dynamic> json) {
    return FinanceiroModel(
      id: json['id'] as String,
      vencimento: json['vencimento'] as DateTime,
      nomeAluno: json['nomeAluno'] as String,
      custoAula: json['custoAula'] as double,
      fotoUrl: json['fotoUrl'] as String,
      estaPago: json['estaPago'] as bool,
    );
  }
}