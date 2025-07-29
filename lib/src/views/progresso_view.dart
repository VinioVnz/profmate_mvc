import 'package:flutter/material.dart';
import 'package:profmate/src/controller/ementa_controller.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/theme/app_colors.dart';
import '../controller/progresso_controller.dart';
import '../widgets/aula_tile.dart';

class ProgressoView extends StatefulWidget {
  const ProgressoView({super.key});

  @override
  State<ProgressoView> createState() => _ProgressoViewState();
}

class _ProgressoViewState extends State<ProgressoView> {
  final controller = ProgressoController();
  final ementaController = EmentaController();

  @override
  Widget build(BuildContext context) {
    double progresso = controller.calcularProgresso() * 100;

    return BaseLayout(
      title: 'Progresso',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Módulo - Basico',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  // Aulas
                  ...controller.aulas.map(
                    (aula) => AulaTile(
                      aula: aula,
                      onChanged: (value) {
                        setState(() {
                          aula.concluida = value!;
                        });
                      },
                    ),
                  ),
                  const Divider(height: 32),
                  const SizedBox(height: 8),

                  // Ementas
                  ...ementaController.ementas.map(
                    (ementa) => ListTile(
                      title: Text(ementa.topico),
                      subtitle: Text(ementa.descricao),
                      leading: const Icon(Icons.book),
                    ),
                  ),
                ],
              ),
            ),
            LinearProgressIndicator(
              value: controller.calcularProgresso(),
              color: AppColors.azulEscuro,
            ),
            const SizedBox(height: 8),
            Text('${progresso.toStringAsFixed(0)}% concluído'),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () async {
                await Navigator.pushNamed(context, '/addEmenta');
                setState(() {});
              },
              label: const Text(
                'Adicionar ementa',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

