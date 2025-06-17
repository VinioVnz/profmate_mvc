import 'package:flutter/material.dart';
import 'package:profmate/src/controller/add_atividade_controller.dart';

class AddAtividade extends StatefulWidget {
  @override
  _AddAtividadeViewState createState() => _AddAtividadeViewState();
}

class _AddAtividadeViewState extends State<AddAtividade> {
  final _formKey = GlobalKey<FormState>();
  final AddAtividadeController _controller = AddAtividadeController();

  String titulo = '';
  String descricao = '';
  String turmaOuAlunos = '';
  String dataEntrega = '';
  bool valeNota = false;
  String? arquivo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Atividade'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Título da atividade',
                  hintText: 'Escreva:',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => titulo = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descrição da tarefa',
                  hintText: 'Digite sobre a atividade',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                onChanged: (value) => descricao = value,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Turmas/Alunos',
                  border: OutlineInputBorder(),
                ),
                items: ['Turma 301', 'Turma 305', 'Aluno João', 'Aluno Maria']
                    .map(
                      (turma) =>
                          DropdownMenuItem(value: turma, child: Text(turma)),
                    )
                    .toList(),
                onChanged: (value) => turmaOuAlunos = value ?? '',
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Data de entrega',
                  hintText: 'dd/mm/aaaa',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => dataEntrega = value,
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    arquivo = 'Arquivo selecionado.pdf'; // Exemplo mock
                  });
                },
                icon: Icon(Icons.attach_file),
                label: Text('Adicionar arquivo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                ),
              ),
              if (arquivo != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Arquivo: $arquivo'),
                ),
              CheckboxListTile(
                title: Text('Vale nota'),
                value: valeNota,
                onChanged: (value) {
                  setState(() {
                    valeNota = value ?? false;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final novaAtividade = _controller.criarAtividade(
                    titulo: titulo,
                    descricao: descricao,
                    turmaOuAlunos: turmaOuAlunos,
                    dataEntrega: dataEntrega,
                    valeNota: valeNota,
                    arquivo: arquivo,
                  );

                  print('Atividade criada: ${novaAtividade.titulo}');
                  Navigator.pop(context);
                },
                child: Text('Criar atividade'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
