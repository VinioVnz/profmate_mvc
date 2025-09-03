class FinanceiroModel {
  final String vencimento;
  final String nomeAluno;
  final double custoAula;
  final bool estaPago;

  FinanceiroModel({ 
    required this.vencimento,
    required this.nomeAluno,
    required this.custoAula,
    required this.estaPago,
  });

  Map<String, dynamic> toJson() {
    return {
      'vencimento': vencimento,
      'nomeAluno': nomeAluno,
      'custoAula': custoAula,
      'estaPago': estaPago,
    };
  }

  factory FinanceiroModel.fromJson(Map<String, dynamic> json) {
    return FinanceiroModel(
      vencimento: json['vencimento'] as String,
      nomeAluno: json['nomeAluno'] as String,
      custoAula: json['custoAula'] as double,
      estaPago: json['estaPago'] as bool,
    );
  }
}