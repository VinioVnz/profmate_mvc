import 'package:flutter/material.dart';
import 'package:profmate/src/widgets/agenda_widget.dart';
import 'package:profmate/src/widgets/campo_calendario.dart';
import 'package:profmate/src/widgets/campo_horario.dart';

class AgendaView extends StatefulWidget {
  const AgendaView({super.key});

  @override
  State<AgendaView> createState() => _AgendaViewState();
}

class _AgendaViewState extends State<AgendaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [AgendaWidget()]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final dataController = TextEditingController();
              final horarioController = TextEditingController();
              final nomeController = TextEditingController();

              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Text("Adicionar aula"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CampoCalendario(),
                      SizedBox(height: 16),
                      CampoHorario(),
                      SizedBox(height: 16),
                      TextField(
                        controller: nomeController,
                        decoration: InputDecoration(
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
                    child: Text("cancelar"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final data = dataController.text;
                      final horario = horarioController.text;
                      final nome = nomeController.text;

                      print(
                        'Data : $data, horário: $horario, aluno(a): $nome '
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text("Salvar"),
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
