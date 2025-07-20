import 'package:flutter/material.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/theme/app_colors.dart';
import '../controller/progress_controller.dart';
import '../widgets/aula_tile.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  final controller = ProgressController();

  @override
  Widget build(BuildContext context) {
    double progresso = controller.calcularProgresso() * 100;

    return BaseLayout(
        title:'Progresso',
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Flutter - Professor Gilmar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.aulas.length,
                  itemBuilder: (context, index) {
                    final aula = controller.aulas[index];
                    return AulaTile(
                      aula: aula,
                      onChanged: (value) {
                        setState(() {
                          aula.concluida = value!;
                        });
                      },
                    );
                  },
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
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, '/addEmenta'),
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
