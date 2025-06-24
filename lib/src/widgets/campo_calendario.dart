import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampoCalendario extends StatefulWidget {
  @override
  _CampoCalendarioState createState() => _CampoCalendarioState();
}

class _CampoCalendarioState extends State<CampoCalendario> {
  final TextEditingController _dataController = TextEditingController();

  Future<void> _selecionarData(BuildContext context) async {
    DateTime? dataEscolhida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: const Locale('pt', 'BR'), // mostra mês e dia em português
    );

    if (dataEscolhida != null) {
      String dataFormatada = DateFormat('dd/MM/yyyy').format(dataEscolhida);
      setState(() {
        _dataController.text = dataFormatada;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _dataController,
      readOnly: true, // impede digitação manual
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
