import 'package:flutter/material.dart';
import 'package:profmate/src/controller/cadastro_turma.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';

class CadastroTurmaView extends StatefulWidget {
  const CadastroTurmaView({super.key});

  @override
  State<CadastroTurmaView> createState() => _CadastroTurmaState();
}

class _CadastroTurmaState extends State<CadastroTurmaView> {
  CadastroTurma cadastroTurma = CadastroTurma();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: "Criar turma",
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinhamento à esquerda
          children: [
            // Legenda em cima do primeiro campo
            Text(
              "aaaaaaa",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8), // Espaço entre legenda e campo
            // Primeiro CampoFormulario
            CampoFormulario(
              controller: TextEditingController(),
              label: "Nome da turma",
            ),
            SizedBox(height: 16), // Espaço entre campos
            // Segundo CampoFormulario
            CampoFormulario(
              controller: TextEditingController(),
              label: "Local",
            ),
          ],
        ),
      ),
    );
  }
}
