import 'package:flutter/material.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/theme/app_colors.dart';
import '../controller/progress_controller.dart';
import '../widgets/ementa_tile.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  final controller = ProgressController();

  @override
  Widget build(BuildContext context) {
    final progresso = controller.calcularProgresso() * 100;

    return BaseLayout(
      title: 'Progresso',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Lista das Ementas com checkbox
            Expanded(
              child: controller.ementas.isEmpty
                  ? const Center(child: Text('Nenhuma ementa adicionada.'))
                  : ListView.builder(
                      itemCount: controller.ementas.length,
                      itemBuilder: (context, index) {
                        final ementa = controller.ementas[index];
                        return EmentaTile(
                          ementa: ementa,
                          onChanged: (value) {
                            setState(() {
                              ementa.concluida = value ?? false;
                            });
                          },
                        );
                      },
                    ),
            ),

            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: controller.calcularProgresso(),
              color: AppColors.azulEscuro,
            ),
            const SizedBox(height: 8),
            Text('${progresso.toStringAsFixed(0)}% concluído'),

            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () async {
                await Navigator.pushNamed(context, '/addEmenta');
                setState(() {}); // atualiza ao voltar
              },
              icon: const Icon(Icons.add),
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
