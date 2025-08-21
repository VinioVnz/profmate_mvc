import 'package:flutter/material.dart';
import 'package:profmate/src/controller/alunos_controller.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';

class AdicionarTurmaView extends StatefulWidget {
  const AdicionarTurmaView({super.key});

  @override
  State<AdicionarTurmaView> createState() => _AdicionarTurmaViewState();
}

class _AdicionarTurmaViewState extends State<AdicionarTurmaView> {
  AlunosController controller = AlunosController();
  TextEditingController nomeTurmaController = TextEditingController();
  TextEditingController localTurmaController = TextEditingController();
  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Criar turma',
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CampoFormulario(
                  controller: nomeTurmaController,
                  hintText: 'Ex: Turma de Inglês - Terça',
                  titulo: 'Nome da turma',
                ),
                CampoFormulario(
                  controller: localTurmaController,
                  hintText: 'Ex: online',
                  titulo: 'Local da turma',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
