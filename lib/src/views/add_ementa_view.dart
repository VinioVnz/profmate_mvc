import 'package:flutter/material.dart';
import 'package:profmate/src/models/emente_model.dart';
import 'package:profmate/theme/app_colors.dart';
import '../controller/ementa_controller.dart';
import '../widgets/custom_text_field.dart';

class AddEmentaView extends StatelessWidget {
  const AddEmentaView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EmentaController();

    final titulo = TextEditingController();
    final descricao = TextEditingController();
    final email = TextEditingController();
    final telefone = TextEditingController();
    final cpf = TextEditingController();
    final valor = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Ementa'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.azulEscuro,
        iconTheme: const IconThemeData(color: AppColors.azulEscuro),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Flutter - Professor Gilmar', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            CustomTextField(controller: titulo, label: 'Tópico'),
            CustomTextField(controller: descricao, label: 'Descrição'),
            CustomTextField(controller: email, label: 'Email'),
            CustomTextField(controller: telefone, label: 'Telefone'),
            CustomTextField(controller: cpf, label: 'CPF'),
            CustomTextField(controller: valor, label: 'Valor mensalidade/ hora aula'),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                final ementa = EmentaModel(
                  titulo: titulo.text,
                  descricao: descricao.text,
                  email: email.text,
                  telefone: telefone.text,
                  cpf: cpf.text,
                  valor: valor.text,
                );
                controller.salvarEmenta(ementa);
                Navigator.pop(context);
              },
              child: const Text(
                'Concluído',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
