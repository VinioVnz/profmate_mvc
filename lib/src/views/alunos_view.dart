import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/models/cadastro_aluno_model.dart';
import 'package:profmate/src/views/cadastro_aluno_view.dart';

class AlunosView extends StatefulWidget {
  final CadastroAlunoController cadastroAlunoController;

  const AlunosView({
    required this.cadastroAlunoController,
    super.key,
  });

  @override
  State<AlunosView> createState() => _AlunosViewState();
}

class _AlunosViewState extends State<AlunosView> {
  late CadastroAlunoController cadastroAlunoController;

  @override
  void initState() {
    super.initState();
    cadastroAlunoController = widget.cadastroAlunoController;
  }

  @override
  Widget build(BuildContext context) {
    final alunos = cadastroAlunoController.listaAlunos;

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CadastroAlunoView(
                    cadastroAlunoController: cadastroAlunoController,
                    aluno: null,
                    modoEdicao: false,
                  ),
                ),
              ).then((_) => setState(() {}));
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
        child: alunos.isEmpty
            ? const Center(
                child: Text(
                  "Nenhum aluno cadastrado ainda.",
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: alunos.length,
                itemBuilder: (context, index) {
                  final aluno = alunos[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(aluno.nome),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CadastroAlunoView(
                              cadastroAlunoController: cadastroAlunoController,
                              aluno: aluno,
                              modoEdicao: true, // para edição ou visualização
                            ),
                          ),
                        ).then((_) => setState(() {}));
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}