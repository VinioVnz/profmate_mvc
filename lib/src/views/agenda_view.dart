import 'package:flutter/material.dart';
import 'package:profmate/src/widgets/agenda_widget.dart';
import 'package:profmate/src/widgets/campo_calendario.dart';
import 'package:profmate/src/widgets/campo_horario.dart';

//Codigo por: Vinícius Bornhofen e Vitor Henkels
//Ultima atualização: 07/07/2025
class AgendaView extends StatefulWidget {
  const AgendaView({super.key});

  @override
  State<AgendaView> createState() => _AgendaViewState();
}
class _AgendaViewState extends State<AgendaView> {
  DateTime _diaSelecionado = DateTime.now();

  Map<DateTime, List<Map<String, String>>> _aulasPorDia = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AgendaWidget(
              diaSelecionado: _diaSelecionado,
              aulasPorDia: _aulasPorDia,
              onDiaSelecionado: (dia) {
                setState(() {
                  _diaSelecionado = dia;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
  // Cria os controllers fora do showDialog
  final nomeController = TextEditingController();
  final dataController = TextEditingController();
  final horarioController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text("Adicionar aula"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CampoCalendario(controller: dataController),
              const SizedBox(height: 16),
              CampoHorario(controller: horarioController),
              const SizedBox(height: 16),
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome do aluno",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final dataTexto = dataController.text;
              final horario = horarioController.text;
              final nome = nomeController.text;

              try {
                // Converte string "dd/MM/yyyy" para DateTime
                final partes = dataTexto.split('/');
                final data = DateTime(
                  int.parse(partes[2]), // ano
                  int.parse(partes[1]), // mês
                  int.parse(partes[0]), // dia
                );

                // Salva a aula na lista de aulas daquele dia
                setState(() {
                  _aulasPorDia[data] ??= [];
                  _aulasPorDia[data]!.add({
                    'nome': nome,
                    'horario': horario,
                  });

                  // Atualiza o dia selecionado para o novo, caso deseje
                  _diaSelecionado = data;
                });

                Navigator.of(context).pop(); // fecha o dialog
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Erro ao salvar aula. Verifique os dados."),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text("Salvar"),
          ),
        ],
      );
    },
  );
},

        backgroundColor: Color(0xFFBDD9FF),
        child: Icon(Icons.add),
      ),
    );
  }
}