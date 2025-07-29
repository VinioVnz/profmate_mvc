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
            const Text('Módulo - Basico', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            const Text('Insira o Módulo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            CustomTextField(controller: modulo, label: 'Módulo'),
            const Text('Insira o Topico', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            CustomTextField(controller: topico, label: 'Topico'),
            const Text('Adicione uma descrição (Opcional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            CustomTextField(controller: descricao, label: 'Descrição', maxLines: 9,),
            
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
