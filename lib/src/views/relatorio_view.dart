import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:profmate/src/widgets/base_layout.dart';

class RelatorioView extends StatelessWidget {
  const RelatorioView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout (
      title: 'Relatório Financeiro',
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
                            spots: [
                              FlSpot(0, 30),
                              FlSpot(1, 35),
                              FlSpot(2, 40),
                              FlSpot(3, 38),
                              FlSpot(4, 44),
                              FlSpot(5, 43),
                              FlSpot(6, 50),
                            ],
                            isCurved: true,
                            barWidth: 3,
                            color: Colors.blue,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
                          )
                        ],
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, _) {
                                const labels = ["Nov 23", "24", "25", "26", "27", "28", "30"];
                                if (value.toInt() < labels.length) {
                                  return Text(labels[value.toInt()]);
                                }
                                return const Text('');
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Filtrar por período", style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 16),
                              ListTile(
                                leading: const Icon(Icons.calendar_today),
                                title: const Text("Últimos 7 dias"),
                                onTap: () {
                                  Navigator.pop(context);
                                  // Aplique o filtro aqui
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.calendar_view_month),
                                title: const Text("Este mês"),
                                onTap: () {
                                  Navigator.pop(context);
                                  // Aplique o filtro aqui
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.calendar_today_outlined),
                                title: const Text("Personalizado"),
                                onTap: () {
                                  Navigator.pop(context);
                                  // Pode abrir um DatePicker
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text("Filtrar"),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    final pdf = pw.Document();
                    pdf.addPage(
                      pw.Page(
                        build: (pw.Context context) => pw.Center(
                          child: pw.Text(
                            "Relatório Trimestral\n\nTotal Recebido: R\$ 1234.56\nPendentes: 5 alunos",
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      ),
                    );
                    await Printing.layoutPdf(
                      onLayout: (PdfPageFormat format) async => pdf.save(),
                    );
                  },
                  child: const Text("Exportar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
