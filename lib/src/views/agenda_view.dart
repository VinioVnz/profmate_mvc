import 'package:flutter/widgets.dart';
import 'package:profmate/src/models/agenda_model.dart';
import 'package:profmate/src/widgets/agendaWidget.dart';

class AgendaView extends StatefulWidget {
  const AgendaView({super.key});

  @override
  State<AgendaView> createState() => _AgendaViewState();
}

class _AgendaViewState extends State<AgendaView> {
  Agendawidget agendawidget = Agendawidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Padding(padding: EdgeInsetsGeometry.all(16),
          child: Column(
            children: [
              agendawidget,
              Container(
                child: Text(DateTime.now().toString()),
              ),
              Container(
                child: Text("")
              )
            ],
          ),
          ) ,
      ],
      );
  }
}
