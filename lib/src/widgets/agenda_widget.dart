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
    final aulasDoDia = aulasPorDia?[DateTime(
          diaSelecionado.year,
          diaSelecionado.month,
          diaSelecionado.day,
        )] ??
        [];

    return Column(
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
              if(onDiaSelecionado != null){
                onDiaSelecionado!(dia);
              }
            },
          ),
        ),
        const SizedBox(height: 16),
        if (mostrarAulas && aulasPorDia != null)
  ...[
    const SizedBox(height: 16),
    Text(
      "Aulas de ${DateFormat('dd/MM/yyyy').format(diaSelecionado)}:",
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    ...aulasDoDia.map((aula) => ListTile(
          title: Text("Aluno: ${aula['nome']}"),
          subtitle: Text("Horário: ${aula['horario']}"),
        )),
  ],
      ],
    );
  }
}