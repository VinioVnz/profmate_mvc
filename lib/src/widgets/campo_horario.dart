import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampoHorario extends StatefulWidget {
  final TextEditingController controller;

  const CampoHorario({super.key, required this.controller});

  @override
  _CampoHorarioState createState() => _CampoHorarioState();
}

class _CampoHorarioState extends State<CampoHorario> {
  Future<void> _selecionarHora(BuildContext context) async {
    TimeOfDay? horaEscolhida = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (horaEscolhida != null) {
      final agora = DateTime.now();
      final horarioCompleto = DateTime(
        agora.year,
        agora.month,
        agora.day,
        horaEscolhida.hour,
        horaEscolhida.minute,
      );

      String horaFormatada = DateFormat('HH:mm').format(horarioCompleto);
      setState(() {
        widget.controller.text = horaFormatada;
      });
    }
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
