import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class Agendawidget extends StatefulWidget {
  const Agendawidget({super.key});

  @override
  State<Agendawidget> createState() => _AgendaState();
}

class _AgendaState extends State<Agendawidget> {
  void _diaSelecionado(DateTime dia, DateTime diaEmFoco) {
    setState(() {
      hoje = dia;
    });
  }

  DateTime hoje = DateTime.now();
  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text("Data selecionada " + hoje.toString().split(" ")[0]),
          Container(
            child: TableCalendar(
              locale: "pt_BR",
              rowHeight: 40,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (dia) => isSameDay(dia, hoje),
              focusedDay: hoje,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 10, 16),
              onDaySelected: _diaSelecionado,
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
