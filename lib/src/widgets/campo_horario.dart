import 'package:flutter/material.dart';

class CampoHorario extends StatefulWidget {
  final TextEditingController controller;

  const CampoHorario({super.key, required this.controller});

  @override
  _CampoHorarioState createState() => _CampoHorarioState();
}

class _CampoHorarioState extends State<CampoHorario> {
  Future<void> _selecionarHora(BuildContext context) async {
    // Pega hora atual como inicial
    final TimeOfDay? horaSelecionada = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horaSelecionada != null) {
      // Formata para HH:mm
      final String horaFormatada =
          '${horaSelecionada.hour.toString().padLeft(2, '0')}:${horaSelecionada.minute.toString().padLeft(2, '0')}';

      // Atualiza o TextField
      widget.controller.text = horaFormatada;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: () => _selecionarHora(context),
      decoration: InputDecoration(
        labelText: 'Horário',
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.access_time),
      ),
    );
  }
}
