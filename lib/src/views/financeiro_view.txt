import 'package:flutter/material.dart';
import 'package:profmate/src/controller/financeiro_controlle.dart';
import 'package:profmate/src/widgets/aluno_tile.dart'; // A sua lista de alunos

class FinanceiroView extends StatefulWidget {
  const FinanceiroView({super.key});

  @override
  _FinanceiroViewState createState() => _FinanceiroViewState();
}

class _FinanceiroViewState extends State<FinanceiroView> {
  late Future<List<dynamic>> alunosPendentes;
  late Future<double> totalRecebido;
  late Future<int> totalPendentes;

  final controller = FinanceiroController();

  @override
  void initState() {
    super.initState();
    // Chamando os métodos para pegar os dados da API
    alunosPendentes = controller.getAlunosPendentes();
    totalRecebido = controller.getTotalRecebido();
    totalPendentes = controller.getTotalPendentes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([alunosPendentes, totalRecebido, totalPendentes]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }

        var alunos = snapshot.data?[0] ?? [];
        var totalRecebidoValue = snapshot.data?[1] ?? 0.0;
        var totalPendentesValue = snapshot.data?[2] ?? 0;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cards de status
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(8)),
                  _statusCard(
                    "Total recebidos",
                    "R\$ ${totalRecebidoValue.toStringAsFixed(2)}",
                    const Color.fromARGB(255, 53, 91, 140),
                  ),
                  const SizedBox(width: 16),
                  _statusCard(
                    "Pendentes",
                    "$totalPendentesValue alunos",
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
                child: ListView.builder(
                  itemCount: alunos.length,
                  itemBuilder: (context, index) {
                    return AlunoTile(aluno: alunos[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statusCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        height: 120, // altura aumentada
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
