import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

//Codigo por: Vinícius Bornhofen e Vitor Henkels
//Última alteração: 07/07/2025
class AgendaWidget extends StatelessWidget {
  final DateTime diaSelecionado;
  final Map<DateTime, List<Map<String, String>>>? aulasPorDia;
  final void Function(DateTime dia)? onDiaSelecionado;
  final mostrarAulas;
  const AgendaWidget({
    super.key,
    required this.diaSelecionado,
    this.aulasPorDia,
    this.onDiaSelecionado,
    this.mostrarAulas = true,
  });

  @override
  Widget build(BuildContext context) {
    final aulasDoDia =
        aulasPorDia?[DateTime(
          diaSelecionado.year,
          diaSelecionado.month,
          diaSelecionado.day,
        )] ??
        [];

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 360,
            child: TableCalendar(
              locale: "pt_BR",
              rowHeight: 40,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, diaSelecionado),
              focusedDay: diaSelecionado,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime(2045, 06, 30),
              onDaySelected: (dia, _) {
                if (onDiaSelecionado != null) {
                  onDiaSelecionado!(dia);
                }
              },
            ),
          ),
          if (mostrarAulas && aulasPorDia != null) ...[
            const SizedBox(height: 16),
            Container(
              width: 200,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              child: Center(
                child: Text(
                  "Aulas de ${DateFormat('dd/MM/yyyy').format(diaSelecionado)}:",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 300, // altura limite para lista de aulas
              child: ListView.builder(
                itemCount: aulasDoDia.length,
                itemBuilder: (context, index) {
                  final aula = aulasDoDia[index];
                  return ListTile(
                    title: Text("Aluno: ${aula['nome']}"),
                    subtitle: Text("Horário: ${aula['horario']}"),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
