import 'package:flutter/material.dart';
import 'package:profmate/src/models/emente_model.dart';
import 'package:profmate/theme/app_colors.dart';
import '../controller/ementa_controller.dart';
import '../widgets/custom_text_field.dart';

class AddEmentaView extends StatelessWidget {
  const AddEmentaView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EmentaController(); // ← isso está certo, MAS...


    final modulo = TextEditingController();
    final topico = TextEditingController();
    final descricao = TextEditingController();

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
            const SizedBox(height: 16),

            const Text(
              'Módulo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            CustomTextField(controller: modulo, label: 'Digite o módulo'),

            const SizedBox(height: 16),
            const Text(
              'Tópico',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            CustomTextField(controller: topico, label: 'Digite o tópico'),

            const SizedBox(height: 16),
            const Text(
              'Descrição',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            CustomTextField(
              controller: descricao,
              label: 'Digite a descrição',
              maxLines: 10, // ← altura grande
            ),

            const SizedBox(height: 24),
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
                  modulo: modulo.text,
                  topico: topico.text,
                  descricao: descricao.text,
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
