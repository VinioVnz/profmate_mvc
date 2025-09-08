import 'package:flutter/material.dart';
import 'package:profmate/src/controller/financeiro_controller.dart';
import 'package:profmate/src/models/financeiro_model.dart';
import 'package:profmate/src/widgets/aluno_tile.dart';
import 'package:profmate/src/views/relatorio_view.dart'; // importe sua tela de relatório se existir

class FinanceiroView extends StatefulWidget {
  const FinanceiroView({super.key});

  @override
  State<FinanceiroView> createState() => _FinanceiroViewState();
}

class _FinanceiroViewState extends State<FinanceiroView> {
  final controller = FinanceiroController();

  @override
  void initState() {
    super.initState();
    // carrega pagamentos ao abrir a tela
    controller.listarPagamento(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          ValueListenableBuilder<List<FinanceiroModel>>(
            valueListenable: controller.pagamentos,
            builder: (context, pagamentos, _) {
              return Row(
                children: [
                  const Padding(padding: EdgeInsets.all(8)),
                  _statusCard(
                    "Total recebidos",
                    "R\$ ${controller.getTotalRecebido().toStringAsFixed(2)}",
                    const Color.fromARGB(255, 53, 91, 140),
                  ),
                  const SizedBox(width: 16),
                  _statusCard(
                    "Pendentes",
                    "${controller.getTotalPendentes()} alunos",
                    const Color.fromARGB(255, 167, 17, 6),
                  ),
                ],
              );
            },
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
            child: ValueListenableBuilder<List<FinanceiroModel>>(
              valueListenable: controller.pagamentos,
              builder: (context, pagamentos, _) {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (pagamentos.isEmpty) {
                  return const Center(child: Text('Nenhum aluno encontrado'));
                }

                return ListView.builder(
                  itemCount: pagamentos.length,
                  itemBuilder: (context, index) {
                    return AlunoTile(aluno: pagamentos[index]);
                  },
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