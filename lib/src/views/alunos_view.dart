import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/controller/progresso_controller.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/views/cadastro_aluno_view.dart';
import 'package:profmate/src/views/progresso_view.dart';
import 'package:profmate/src/views/ver_aluno_view.dart';
import 'package:profmate/src/widgets/barra_pesquisa.dart';
import 'package:profmate/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlunosView extends StatefulWidget {
  const AlunosView({super.key});

  @override
  State<AlunosView> createState() => _AlunosViewState();
}

class _AlunosViewState extends State<AlunosView> {
  final _controller = CadastroAlunoController();
  List<AlunoApiModel> _alunos = [];
  int? _usuarioId;
  bool _loading = true;
  String _textoPesquisa = "";
  @override
  void initState() {
    super.initState();
    _carregarUsuarioId();
  }

  Future<List<AlunoApiModel>> _getAlunosFuture() async {
    //serve pra transformar o _alunos em Future, pra ser aceito no future Builder
    if (_alunos.isEmpty) {
      await _loadAlunos();
    }
    return _alunos;
  }

  Future<void> _carregarUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');

    if (id != null) {
      setState(() => _usuarioId = id);
      await _loadAlunos();
    } else {
      // caso não tenha usuário logado
      setState(() => _loading = false);
    }
  }

  Future<void> _loadAlunos() async {
    print("Id do user $_usuarioId");
    if (_usuarioId == null) return;

    setState(() => _loading = true);

    try {
      final lista = await _controller.listarAluno(context);
      setState(() {
        _alunos = lista;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao carregar alunos: $e")));
    }
  }

  void _abrirCadastro() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CadastroAlunoView()),
    );

    if (resultado == true) {
      await _loadAlunos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: SpeedDial(
        backgroundColor: const Color(0xFFBDD9FF),
        icon: Icons.add,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
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
          /* SpeedDialChild(
            label: "Cadastrar turma",
            backgroundColor: Colors.white,
            onTap: () {
              // colocar aqui ação de cadastrar nova turma
            },
          ), */
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // barra de pesquisa sempre visível, não dentro do FutureBuilder
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
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _alunos.isEmpty
                  ? const Center(child: Text('Nenhum aluno cadastrado!'))
                  : ListView.builder(
                      itemCount: _alunos
                          .where(
                            (aluno) => aluno.nome.toLowerCase().contains(
                              _textoPesquisa.toLowerCase(),
                            ),
                          )
                          .length,
                      itemBuilder: (_, i) {
                        final alunosFiltrados = _alunos
                            .where(
                              (aluno) => aluno.nome.toLowerCase().contains(
                                _textoPesquisa.toLowerCase(),
                              ),
                            )
                            .toList();
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
                                  ),
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
                                        /* 
                                        const SizedBox(height: 6),
                                        Text(
                                          "Turma: ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700],
                                          ),
                                        ),
 */
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
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
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

                                              child: const Text(
                                                "Mais detalhes",
                                              ),
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
        ),
      ),
    );
  }
}
