import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaWidget extends StatefulWidget {
  const AgendaWidget({super.key});

  @override
  State<AgendaWidget> createState() => _AgendaWidgetState();
}
final formatador= DateFormat('dd/MM/yyyy','pt_BR');
  DateTime hoje = DateTime.now();
  final dataFormatada = formatador.format(hoje);
class _AgendaWidgetState extends State<AgendaWidget> {
  
  void _noDiaSelecionado(DateTime dia, DateTime diaFocado) {
    setState(() {
      hoje = dia;
    });
  }

  @override
  Widget build(BuildContext context) {
    String dataFormatada = formatador.format(hoje);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text("Dia selecionado = $dataFormatada"),
          Container(
            height: 280,
            child: TableCalendar(
              locale: "pt_BR",
              rowHeight: 40,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, hoje),
              focusedDay: hoje,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime(2045, 06, 30),
              onDaySelected: _noDiaSelecionado,
            ),
          ),
        ],
      ),
    );
  }
}
