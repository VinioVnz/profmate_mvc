import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/views/cadastro_aluno_view.dart';
import 'package:profmate/src/views/ver_aluno_view.dart';
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

  @override
  void initState() {
    super.initState();
    _carregarUsuarioId();
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar alunos: $e")),
      );
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        children: [
          SpeedDialChild(
            label: "Cadastrar aluno",
            backgroundColor: Colors.white,
            onTap: _abrirCadastro,
          ),
          SpeedDialChild(
            label: "Cadastrar turma",
            backgroundColor: Colors.white,
            onTap: () {
              // ação de cadastrar turma
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _alunos.isEmpty
                ? const Center(child: Text('Nenhum aluno cadastrado!'))
                : ListView.builder(
                    itemCount: _alunos.length,
                    itemBuilder: (_, i) {
                      final aluno = _alunos[i];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffE6E6E6), width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            tileColor: Colors.white,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VerAlunoView(aluno: aluno),
                                ),
                              );
                            },
                            title: Text(
                              aluno.nome,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
