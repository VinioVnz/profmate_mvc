import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampoHorario extends StatefulWidget {
  final TextEditingController controller;

  const CampoHorario({super.key, required this.controller});

  @override
  _CampoHorarioState createState() => _CampoHorarioState();
}
//codigo por: Vinícius Bornhofen
class _CampoHorarioState extends State<CampoHorario> {
  void _selecionarHora(BuildContext context) {
    DateTime horaAtual = DateTime.now();

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 250,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            initialTimerDuration: Duration(
              hours: horaAtual.hour,
              minutes: horaAtual.minute,
            ),
            onTimerDurationChanged: (Duration novaHora) {
              final agora = DateTime.now();
              final horarioCompleto = DateTime(
                agora.year,
                agora.month,
                agora.day,
                novaHora.inHours,
                novaHora.inMinutes % 60,
              );

              final horaFormatada =
                  DateFormat('HH:mm').format(horarioCompleto);

              setState(() {
                widget.controller.text = horaFormatada;
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Horário',
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(Icons.access_time),
          onPressed: () => _selecionarHora(context),
        ),
      ),
    );
  }
}
