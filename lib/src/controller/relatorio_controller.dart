import 'package:fl_chart/fl_chart.dart';

class RelatorioController {
  String filtroAtual = "Trimestre";

  List<FlSpot> getDadosGrafico() {
    // Muda os dados conforme o filtro
    switch (filtroAtual) {
      case "Ano":
        return [
          FlSpot(0, 20),
          FlSpot(1, 25),
          FlSpot(2, 28),
          FlSpot(3, 30),
          FlSpot(4, 32),
          FlSpot(5, 40),
        ];
      case "Personalizado":
        return [
          FlSpot(0, 15),
          FlSpot(1, 18),
          FlSpot(2, 22),
        ];
      case "Trimestre":
      default:
        return [
          FlSpot(0, 30),
          FlSpot(1, 35),
          FlSpot(2, 40),
          FlSpot(3, 38),
          FlSpot(4, 44),
          FlSpot(5, 43),
          FlSpot(6, 50),
        ];
    }
  }

  void aplicarFiltro(String filtro) {
    filtroAtual = filtro;
  }
}
