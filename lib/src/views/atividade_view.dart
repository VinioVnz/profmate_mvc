import 'package:flutter/material.dart';
import 'package:profmate/src/controller/atividade_controller.dart';
import 'package:profmate/src/models/atividade_model.dart';

class AtividadesView extends StatelessWidget {
  final AtividadeController controller = AtividadeController();

  @override
  Widget build(BuildContext context) {
    List<AtividadeModel> atividades = controller.listarAtividades();

    return Scaffold(
      appBar: AppBar(
        title: Text('Atividades'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Implementar filtro futuramente
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: atividades.length,
        itemBuilder: (context, index) {
          final atividade = atividades[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      atividade.titulo,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      atividade.descricao,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(atividade.turma),
                        ),
                        Row(
                          children: [
                            Icon(Icons.person, size: 18),
                            SizedBox(width: 4),
                            Text('${atividade.entregues}/${atividade.total}'),
                          ],
                        ),
                        Text('Entrega: ${atividade.entrega}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação para adicionar nova atividade
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
