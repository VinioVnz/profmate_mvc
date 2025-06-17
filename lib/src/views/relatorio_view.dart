import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:profmate/src/views/financeiro_view.dart';

class RelatorioView extends StatelessWidget {
  const RelatorioView({super.key});

  @override
  Widget build(BuildContext context) {
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
                ElevatedButton(onPressed: () {}, child: const Text("Filtrar")),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: () {}, child: const Text("Exportar")),
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
