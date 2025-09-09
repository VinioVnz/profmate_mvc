import 'package:flutter/material.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/controller/pagamento_controller.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/models/pagamento_api_model.dart';
import 'package:profmate/src/widgets/aluno_tile.dart';
import 'package:profmate/src/views/relatorio_view.dart';

class FinanceiroView extends StatefulWidget {
  const FinanceiroView({super.key});

  @override
  State<FinanceiroView> createState() => _FinanceiroViewState();
}

class _FinanceiroViewState extends State<FinanceiroView> {
  final alunoController = CadastroAlunoController();
  final pagamentoController = PagamentoController();

  List<AlunoApiModel> alunos = [];
  List<PagamentoApiModel> pagamentos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() {
      isLoading = true;
    });

    final alunosList = await alunoController.listarAluno(context);
    final pagamentosList = await pagamentoController.listarPagamento(context);

    setState(() {
      alunos = alunosList;
      pagamentos = pagamentosList;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    alunoController.dispose();
    pagamentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalRecebido = pagamentos.fold(
        0.0, (sum, p) => sum + p.valorAula); // total de todos os pagamentos
    int totalPendentes = pagamentos.length; // exemplo simples

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Botão "Relatório"
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => const RelatorioView()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: const Text(
                    "Relatório",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // CARDS: Total Recebidos / Pendentes
          Row(
            children: [
              const Padding(padding: EdgeInsets.all(8)),
              _statusCard(
                "Total recebidos",
                "R\$ ${totalRecebido.toStringAsFixed(2)}",
                const Color.fromARGB(255, 53, 91, 140),
              ),
              const SizedBox(width: 16),
              _statusCard(
                "Pendentes",
                "$totalPendentes alunos",
                const Color.fromARGB(255, 167, 17, 6),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Campo de busca
          const TextField(
            decoration: InputDecoration(
              hintText: "Pesquisar aluno",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Lista de alunos
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : alunos.isEmpty
                    ? const Center(child: Text('Nenhum aluno encontrado'))
                    : ListView.builder(
                        itemCount: alunos.length,
                        itemBuilder: (context, index) {
                          final aluno = alunos[index];
                          // busca pagamento correspondente
                          
                          final pagamento = pagamentos.firstWhere(
                            
                              (p) => p.idAluno == aluno.id,
                              orElse: () => PagamentoApiModel(
                                  id: null,
                                  valorAula: 0,
                                  vencimento: '',
                                  formaPagamento: '',
                                  frequenciaPagamento: '',
                                  idAluno: aluno.id ?? 0));
                                  
                                  
                          return AlunoTile(
                            aluno: aluno,
                            pagamento: pagamento,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}