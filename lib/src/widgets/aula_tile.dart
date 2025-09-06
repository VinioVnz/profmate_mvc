import 'package:flutter/material.dart';
import '../models/aula_model.dart';

class AulaTile extends StatelessWidget {
  final AulaModel aula;
  final ValueChanged<bool?> onChanged;

  const AulaTile({super.key, required this.aula, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(aula.titulo),
      value: aula.concluida,
      onChanged: onChanged,
    );
  }
}