import 'package:flutter/material.dart';
import 'package:profmate/src/controller/ementa_controller.dart';
import 'package:profmate/src/models/ementa_api_model.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/progresso_controller.dart';
import '../widgets/ementa_tile.dart';
import 'package:profmate/src/widgets/custom_elevated_button.dart';

class ProgressoView extends StatefulWidget {
  const ProgressoView({super.key});

  @override
  State<ProgressoView> createState() => _ProgressoViewState();
}

class _ProgressoViewState extends State<ProgressoView> {
  late Future<List<EmentaApiModel>> _ementas;
  final controller = ProgressoController();
  final ementaController = EmentaController();
  @override
  void initState() {
    super.initState();
    _ementas = _loadEmenta();
  }

  Future<List<EmentaApiModel>> _loadEmenta() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final idAluno = prefs.getInt('aluno_id');

    final todasEmentas = await ementaController.listarEmenta(context);
    return todasEmentas.where((e) => e.idAluno == idAluno).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Progresso',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Lista e progresso ficam dentro do Expanded
            Expanded(
              child: FutureBuilder<List<EmentaApiModel>>(
                future: _ementas,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Erro ao carregar ementas: ${snapshot.error}',
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('Nenhuma ementa adicionada.'),
                    );
                  }

                  final ementas = snapshot.data!;
                  final progresso = controller.calcularProgresso(ementas);

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: ementas.length,
                          itemBuilder: (context, index) {
                            final ementa = ementas[index];
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
                        value: progresso,
                        color: AppColors.azulEscuro,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(progresso * 100).toStringAsFixed(0)}% concluído',
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Botão sempre visível
            SafeArea(
              child: CustomElevatedButton(
                tituloBotao: 'Adicionar ementa',
                onPressed: () async {
                  await Navigator.pushNamed(context, '/addEmenta');
                  setState(() {
                    _ementas = _loadEmenta(); // aqui recarrega a lista filtrada
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
