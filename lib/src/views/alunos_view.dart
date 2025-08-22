import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:profmate/src/controller/alunos_controller.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/controller/progresso_controller.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/models/cadastro_aluno_model.dart';
import 'package:profmate/src/views/cadastro_aluno_view.dart';
import 'package:profmate/src/views/progresso_view.dart';
import 'package:profmate/src/views/ver_aluno_view.dart';
import 'package:profmate/src/widgets/barra_pesquisa.dart';
import 'package:profmate/src/widgets/custom_elevated_button.dart';
import 'package:profmate/theme/app_colors.dart';

class AlunosView extends StatefulWidget {
  const AlunosView({super.key});

  @override
  State<AlunosView> createState() => _AlunosViewState();
}

class _AlunosViewState extends State<AlunosView> {
  final _controller = CadastroAlunoController();
  late Future<List<AlunoApiModel>> _alunos;

  // NOVO: texto da pesquisa
  String _textoPesquisa = "";

  @override
  void initState() {
    super.initState();
    _loadAlunos();
  }

  void _loadAlunos() {
    setState(() {
      _alunos = _controller.listarAluno(context);
    });
  }

  ProgressoController progressoController = ProgressoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: SpeedDial(
        backgroundColor: const Color(0xFFBDD9FF),
        icon: Icons.add,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        children: [
          SpeedDialChild(
            label: "Cadastrar aluno",
            backgroundColor: Colors.white,
            onTap: () async {
              final resultado = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CadastroAlunoView()),
              );

              if (resultado == true) {
                _loadAlunos();
              }
            },
          ),
          SpeedDialChild(
            label: "Cadastrar turma",
            backgroundColor: Colors.white,
            onTap: () {
              // colocar aqui ação de cadastrar nova turma
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<AlunoApiModel>>(
          future: _alunos,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Erro: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum aluno cadastrado!'));
            }

            final alunos = snapshot.data!;

            //adicionei filtragem dos alunos (Vanessa) - está filtrando apenas no app, deveria filtrar com getOne?
            final alunosFiltrados = alunos.where((aluno) {
              return aluno.nome.toLowerCase().contains(
                _textoPesquisa.toLowerCase(),
              );
            }).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: BarraPesquisa(
                    textoBarra: "Pesquisar aluno",
                    onChanged: (valor) {
                      setState(() {
                        _textoPesquisa = valor;
                      });
                    },
                  ),
                ),

                // lista de alunos já filtrada:
                Expanded(
                  child: ListView.builder(
                    itemCount: alunosFiltrados.length,
                    itemBuilder: (_, i) {
                      final a = alunosFiltrados[i];

                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.azulEscuro,
                                  radius: 35,
                                  child: const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ), //substituir este avatar depois pela foto real do aluno
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        a.nome,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),

                                      Text(
                                        "Turma: ", //substituir pela turma cadastrada depois
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700],
                                        ),
                                      ),

                                      const SizedBox(height: 6),
                                      Text(
                                        "Progresso do aluno:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      LinearProgressIndicator(
                                        value:
                                            0.6, // substituir pelo progresso real depois
                                        minHeight: 6,
                                        borderRadius: BorderRadius.circular(8),
                                        backgroundColor: Colors.grey[300],
                                        color: AppColors.azulEscuro,
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadiusGeometry.circular(
                                                      25,
                                                    ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      VerAlunoView(aluno: a),
                                                ),
                                              );
                                            },
                                            child: const Text("Mais detalhes"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
