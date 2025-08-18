import 'package:flutter/material.dart';
import 'package:profmate/src/controller/alunos_controller.dart';
import 'package:profmate/src/controller/aula_api_controller.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/models/aula_api_model.dart';
import 'package:profmate/src/utils/date_converter_util.dart';
import 'package:profmate/src/widgets/agenda_widget.dart';
import 'package:profmate/src/widgets/campo_calendario.dart';
import 'package:profmate/src/widgets/campo_horario.dart';
import 'package:profmate/src/widgets/custom_dropdown.dart';
import 'package:profmate/src/widgets/custom_dropdown_api.dart';

//Codigo por: Vinícius Bornhofen e Vitor Henkels
//Ultima atualização: 07/07/2025
class AgendaView extends StatefulWidget {
  const AgendaView({super.key});

  @override
  State<AgendaView> createState() => _AgendaViewState();
}

class _AgendaViewState extends State<AgendaView> {
  @override
  void initState() {
    super.initState();
    loadAlunos();
  }

  DateTime _diaSelecionado = DateTime.now();

  Map<DateTime, List<Map<String, String>>> _aulasPorDia = {};

  final AulaApiController _aulaController = AulaApiController();
  final CadastroAlunoController _alunoController = CadastroAlunoController();
  AlunoApiModel? selectedAluno;
  List<AlunoApiModel> alunos = [];

  Future<void> loadAlunos() async {
    final lista = await _alunoController.listarAluno(context);
    setState(() {
      alunos = lista;
    });
  }

  TimeOfDay stringToTimeOfDay(String time) {
    final partes = time.split(":");
    return TimeOfDay(hour: int.parse(partes[0]), minute: int.parse(partes[1]));
  }

  String timeOfDayToString(TimeOfDay time) {
    final horas = time.hour.toString().padLeft(2, '0');
    final minutos = time.minute.toString().padLeft(2, '0');
    return "$horas:$minutos";
  }

  void _salvarAula() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Cria os controllers fora do showDialog
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
                      CampoCalendario(
                        controller: dataController,
                        initialDate: _diaSelecionado,
                      ),
                      const SizedBox(height: 16),
                      CampoHorario(controller: horarioController),
                      const SizedBox(height: 16),
                      alunos.isEmpty
                          ? Text(
                              'Sem alunos cadastrados! Cadastre um primeiro!',
                            )
                          : CustomDropdownApi<AlunoApiModel>(
                              value: selectedAluno,
                              titulo: 'Aluno',
                              hintText: 'Escolha um Aluno',
                              items: alunos,
                              onChanged: (novo) {
                                setState(() {
                                  selectedAluno = novo;
                                });
                              },
                              itemLabel: (aluno) => aluno.nome,
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
                    onPressed: () async {
                      if (selectedAluno == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Selecione um aluno antes de salvar.",
                            ),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return; // não continua
                      }
                      final dataTexto = dataController.text;
                      final horario = horarioController.text;

                      try {
                        // Converte string "dd/MM/yyyy" para DateTime
                        final partes = dataTexto.split('/');
                        final data = DateTime(
                          int.parse(partes[2]), // ano
                          int.parse(partes[1]), // mês
                          int.parse(partes[0]), // dia
                        );
                        
                        final aula = AulaApiModel(
                          data:
                              "${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}",
                          idAluno: selectedAluno!.id!,
                          horario: horario,
                        );
                        print('HORARIO:  $horario');

                        await _aulaController.criarAula(aula);
                        // Salva a aula na lista de aulas daquele dia
                        setState(() {
                          _aulasPorDia[data] ??= [];
                          _aulasPorDia[data]!.add({
                            'nome': selectedAluno!.nome,
                            'horario': horario,
                          });

                          // Atualiza o dia selecionado para o novo, caso deseje
                          _diaSelecionado = data;
                        });

                        Navigator.of(context).pop(); // fecha o dialog

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Aula salva com sucesso!"),
                            backgroundColor: Colors.greenAccent,
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Erro ao salvar aula. Verifique os dados.",
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );

                        print('ERRO: $e');
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
