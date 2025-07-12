import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// Código por: Vinícius Bornhofen e Vitor Henkels
// Última alteração: 09/07/2025
class AulaEvent {
  final String nome;
  final String horario;

  AulaEvent(this.nome, this.horario);
}

class AgendaWidget extends StatelessWidget {
  final DateTime? diaSelecionado;
  final Map<DateTime, List<Map<String, String>>>? aulasPorDia;
  final void Function(DateTime dia)? onDiaSelecionado;
  final bool mostrarAulas;

  const AgendaWidget({
    super.key,
    this.diaSelecionado,
    this.aulasPorDia,
    this.onDiaSelecionado,
    this.mostrarAulas = true,
  });

  @override
  Widget build(BuildContext context) {
    final dia = diaSelecionado ?? DateTime.now();

    final aulasDoDia =
        aulasPorDia?[DateTime(dia.year, dia.month, dia.day)] ?? [];

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 360,
            child: TableCalendar(
              locale: "pt_BR",
              rowHeight: 40,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                markersMaxCount: 1,
                markerSize: 20,
                markerMargin: EdgeInsets.only(top: 2),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isEmpty) return SizedBox.shrink();

                  return Padding(
                    padding: EdgeInsets.only(
                      left: 26,
                    ), // ajusta para onde quiser
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 0, 0),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${events.length}', // mostra quantas aulas tem
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  );
                },
              ),
              eventLoader: (day) {
                final dataNormalizada = DateTime(day.year, day.month, day.day);
                return aulasPorDia?[dataNormalizada] ?? [];
              },
              selectedDayPredicate: (day) => isSameDay(day, diaSelecionado),
              focusedDay: diaSelecionado ?? DateTime.now(),
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
                  "Aulas de ${DateFormat('dd/MM/yyyy').format(dia)}:",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 300,
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
