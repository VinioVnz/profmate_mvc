import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/views/cadastro_aluno_view.dart';

class AlunosView extends StatefulWidget {
  final CadastroAlunoController cadastroAlunoController;
  const AlunosView({required this.cadastroAlunoController, super.key});

  @override
  State<AlunosView> createState() => _AlunosViewState();
}

class _AlunosViewState extends State<AlunosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: SpeedDial(
        backgroundColor: Color(0xFFBDD9FF),
        icon: (Icons.add),
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
                    cadastroAlunoController: widget.cadastroAlunoController,
                  ),
                ),
              );
            },
          ),
          SpeedDialChild(
            label: "Cadastrar turma",
            backgroundColor: Colors.white,
            onTap: () {
              //colocar aqui ação de cadastrar nova turma
            },
          ),
        ],
      ),
      body: Padding(padding: EdgeInsets.all(16), child: Column()),
    );
  }
}
