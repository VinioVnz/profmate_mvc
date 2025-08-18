import 'package:flutter/material.dart';

class CustomDropdownApi<T> extends StatelessWidget {
  final T? value;
  final String titulo;
  final String hintText;
  final List<T> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool readOnly;
  final String Function(T) itemLabel; // 👈 função pra pegar o texto

  const CustomDropdownApi({
    super.key,
    required this.value,
    required this.titulo,
    required this.hintText,
    required this.items,
    required this.itemLabel,
    this.onChanged,
    this.validator,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            titulo,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: Colors.black),
            color: readOnly ? Colors.grey[200] : Colors.white,
          ),
          child: DropdownButtonFormField<T>(
            value: value,
            hint: Text(
              hintText,
              style: TextStyle(color: Colors.grey[400], fontSize: 16),
            ),
            items: items
                .map((item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(itemLabel(item)), // mostra só o nome
                    ))
                .toList(),
            onChanged: readOnly ? null : onChanged,
            validator: validator,
            isExpanded: true,
            decoration: const InputDecoration.collapsed(hintText: ''),
            dropdownColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
