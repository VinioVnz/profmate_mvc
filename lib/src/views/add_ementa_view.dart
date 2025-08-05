import 'package:flutter/material.dart';
import 'package:profmate/src/models/ementa_api_model.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';
import 'package:profmate/theme/app_colors.dart';
import '../controller/ementa_controller.dart';

class AddEmentaView extends StatefulWidget {
  const AddEmentaView({super.key});

  @override
  State<AddEmentaView> createState() => _AddEmentaViewState();
}

class _AddEmentaViewState extends State<AddEmentaView> {
  final _chaveDoFormulario = GlobalKey<FormState>();
  final EmentaController controller = EmentaController();

  void _salvarEmenta()async{
    final ementa = EmentaApiModel(
      modulo: controller.moduloController.text, 
      topico: controller.topicoController.text, 
      descricao: controller.descricaoController.text, 
      concluida: false,
      );

      try{
        await controller.criarEmenta(ementa);
        Navigator.pop(context, true);
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar o ementa, Erro: $e"))
        );
      }
  }
  
  @override
  Widget build(BuildContext context) {

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

            CampoFormulario(
              controller: controller.moduloController,
              titulo: "Módulo",
              hintText: "Ex: Módulo básico",
            ),

            CampoFormulario(
              controller: controller.moduloController,
              titulo: "Tópico",
              hintText: "Ex: Verbo To be",
            ),

            CampoFormulario(
              controller: controller.moduloController,
              titulo: "Descrição",
              hintText: "Escreva a descrição do tópico.",
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
                _salvarEmenta();
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
