import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampoCalendario extends StatefulWidget {
  final TextEditingController controller;
  final DateTime? initialDate;
  const CampoCalendario({super.key, required this.controller, this.initialDate});

  @override
  _CampoCalendarioState createState() => _CampoCalendarioState();
}
//codigo por: Vinícius Bornhofen

class _CampoCalendarioState extends State<CampoCalendario> {
  Future<void> _selecionarData(BuildContext context) async {
    DateTime? dataEscolhida = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: const Locale('pt', 'BR'),
    );

    if (dataEscolhida != null) {
      String dataFormatada = DateFormat('dd/MM/yyyy').format(dataEscolhida);
      setState(() {
        widget.controller.text = dataFormatada;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Data da Aula',
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () => _selecionarData(context),
        ),
      ),
    );
  }
}
