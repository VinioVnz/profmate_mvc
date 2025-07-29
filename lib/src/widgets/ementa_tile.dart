import 'package:flutter/material.dart';
import '../models/ementa_model.dart';

class EmentaTile extends StatelessWidget {
  final EmentaModel ementa;
  final ValueChanged<bool?> onChanged;

  const EmentaTile({super.key, required this.ementa, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(ementa.titulo),
      subtitle: Text(ementa.descricao),
      value: ementa.concluida,
      onChanged: onChanged,
    );
  }
}
