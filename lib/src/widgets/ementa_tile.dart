import 'package:flutter/material.dart';
import 'package:profmate/src/models/ementa_api_model.dart';

class EmentaTile extends StatelessWidget {
  final EmentaApiModel ementa;
  final ValueChanged<bool?> onChanged;

  const EmentaTile({
    super.key,
    required this.ementa,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${ementa.modulo} - ${ementa.topico}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (ementa.descricao.isNotEmpty)
                    Text(
                      ementa.descricao,
                      style: const TextStyle(fontSize: 14),
                    ),
                ],
              ),
            ),
            Checkbox(
              value: ementa.concluida,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
