import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:profmate/src/controller/alunos_controller.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/models/cadastro_aluno_model.dart';
import 'package:profmate/src/views/cadastro_aluno_view.dart';
import 'package:profmate/src/views/ver_aluno_view.dart';

class AlunosView extends StatefulWidget {
  const AlunosView({super.key});

  @override
  State<AlunosView> createState() => _AlunosViewState();
}

class _AlunosViewState extends State<AlunosView> {
  final _controller = CadastroAlunoController();
  late Future<List<AlunoApiModel>> _alunos;
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
              return Center(child: Text('Nenhum aluno cadastrado!'));
            }

            final alunos = snapshot.data!;
            return ListView.builder(
              itemCount: alunos.length,
              itemBuilder: (_, i) {
                final a = alunos[i];

                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE6E6E6), width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: ListTile(
                      tileColor: Colors.white,
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerAlunoView(aluno: a),
                          ),
                        );
                      },
                      title: Text(
                        a.nome,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
