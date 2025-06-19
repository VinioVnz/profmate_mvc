import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:profmate/src/views/financeiro_view.dart';
import 'package:profmate/src/controller/relatorio_controller.dart';

class RelatorioView extends StatelessWidget {
  const RelatorioView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RelatorioController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Relatório Financeiro', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Relatório Trimestral"),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                  LineChartData(
                    lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    spots: controller.getDadosGrafico(),
                    barWidth: 3,
                    color: Colors.blue,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
                      ),
                    ],
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                    return Text("M${value.toInt() + 1}");
                        },
                      ),
                    ),
                        leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: true),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            ElevatedButton(
              onPressed: () {
              _mostrarFiltro(context, controller);
              },
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
                child: const Text('Filtrar'),
          ),
                const SizedBox(width: 12),
                ElevatedButton(
                onPressed: () {
                _exportarRelatorio(context);
          },
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
                child: const Text('Exportar'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const FinanceiroView()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
        ],
      ),
    );
  }
}

void _mostrarFiltro(BuildContext context, RelatorioController controller) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("Trimestre"),
            onTap: () {
              controller.aplicarFiltro("Trimestre");
              Navigator.pop(context);
              (context as Element).markNeedsBuild(); // força rebuild
            },
          ),
          ListTile(
            title: const Text("Ano"),
            onTap: () {
              controller.aplicarFiltro("Ano");
              Navigator.pop(context);
              (context as Element).markNeedsBuild();
            },
          ),
          ListTile(
            title: const Text("Personalizado"),
            onTap: () {
              controller.aplicarFiltro("Personalizado");
              Navigator.pop(context);
              (context as Element).markNeedsBuild();
            },
          ),
        ],
      );
    },
  );
}

void _exportarRelatorio(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Relatório exportado com sucesso!")),
  );

  // Aqui você poderia usar:
  // - Share package para compartilhar
  // - pdf package para gerar um PDF
  // - path_provider para salvar localmente
}
