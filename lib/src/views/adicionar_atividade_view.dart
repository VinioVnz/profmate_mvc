import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../controller/atividade_controller.dart';
import '../widgets/campo_formulario.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';

class AdicionarAtividadeView extends StatefulWidget {
  const AdicionarAtividadeView({super.key});

  @override
  State<AdicionarAtividadeView> createState() => _AdicionarAtividadeViewState();
}

class _AdicionarAtividadeViewState extends State<AdicionarAtividadeView> {
  bool _loading = false;
  String? _erro;
  final _formKey = GlobalKey<FormState>();
  final AtividadeController _controller = AtividadeController();

  final formatarData = MaskTextInputFormatter(
    mask: "##/##/####",
    filter: {"#": RegExp(r'[0-9]')},
  );

  void _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
        _erro = null;
      });

      await _controller.criarAtividade(
        _controller.tituloController.text,
        _controller.descricaoController.text,
        _controller.turmaOuAlunosController.text,
        _controller.dtEntregaController.text,
        _controller.valeNotaController.text,
        _controller.arquivoController.text.isEmpty
            ? null
            : _controller.arquivoController.text,
      );

      setState(() {
        _loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Atividade criada com sucesso')),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Criar Atividade'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_erro != null)
                Text(_erro!, style: const TextStyle(color: Colors.red)),
              CampoFormulario(
                controller: _controller.tituloController,
                titulo: 'Título',
                hintText: 'Ex: Trabalho de Matemática',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              CampoFormulario(
                controller: _controller.descricaoController,
                titulo: 'Descrição',
                hintText: 'Descreva a atividade',
              ),
              CampoFormulario(
                controller: _controller.turmaOuAlunosController,
                titulo: 'Turma ou Alunos',
                hintText: 'Ex: Turma A ou João, Maria',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              CampoFormulario(
                controller: _controller.dtEntregaController,
                titulo: 'Data de Entrega',
                hintText: 'Ex: 25/08/2025',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
                formatar: [formatarData],
              ),
              CampoFormulario(
                controller: _controller.valeNotaController,
                titulo: 'Vale Nota?',
                hintText: 'Digite: sim ou não',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              CampoFormulario(
                controller: _controller.arquivoController,
                titulo: 'Arquivo (opcional)',
                hintText: 'Caminho do arquivo ou URL',
              ),
              const SizedBox(height: 16),
              _loading
                  ? const CircularProgressIndicator()
                  : CustomElevatedButton(
                      tituloBotao: 'Criar Atividade',
                      onPressed: _cadastrar,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
