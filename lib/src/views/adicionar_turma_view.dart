import 'package:flutter/material.dart';
import 'package:profmate/src/controller/alunos_controller.dart';
import 'package:profmate/src/controller/turma_controller.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';
import 'package:profmate/src/widgets/custom_elevated_button.dart';

class AdicionarTurmaView extends StatefulWidget {
  const AdicionarTurmaView({super.key});

  @override
  State<AdicionarTurmaView> createState() => _AdicionarTurmaViewState();
}

class _AdicionarTurmaViewState extends State<AdicionarTurmaView> {
  final _formKey = GlobalKey();
  TurmaController controller = TurmaController();
  TextEditingController nomeTurmaController = TextEditingController();
  TextEditingController localTurmaController = TextEditingController();

  List<AlunosController> _filteredItems = [];

  /*  // Função para mostrar os alunos
  void _onSearchChanged() {
    if (_buscaAlunosController.text.isNotEmpty) {
      _buscarAlunos();
    } else {
      setState(() {
        _alunosEncontrados = [];
        _isSearching = false;
      });
    }
  } */

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
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                /*   Expanded(
                  child: ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.description),
                      );
                    },
                  ),
                ), */
                CustomElevatedButton(
                  onPressed: () => {},
                  tituloBotao: 'Criar',
                  key: _formKey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
