import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FinanceiroView extends StatelessWidget {
  const FinanceiroView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RelatorioFinanceiroPage(),
    );
  }
}

class RelatorioFinanceiroPage extends StatelessWidget {
  const RelatorioFinanceiroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          'Relatório Financeiro',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Relatório Trimestral"),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            spots: [
                              FlSpot(0, 30),
                              FlSpot(1, 32),
                              FlSpot(2, 36),
                              FlSpot(3, 40),
                              FlSpot(4, 38),
                              FlSpot(5, 42),
                              FlSpot(6, 50),
                            ],
                            isStrokeCapRound: true,
                            color: Colors.blue,
                            barWidth: 3,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
                          ),
                        ],
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true, interval: 5),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, _) {
                                const days = ["Nov 23", "24", "25", "26", "27", "28", "30"];
                                if (value.toInt() < days.length) {
                                  return Text(days[value.toInt()]);
                                }
                                return const Text('');
                              },
                            ),
                          ),
                        ),
                        gridData: FlGridData(show: true),
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Filtrar'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Exportar'),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
        ],
      ),
    );
  }
}