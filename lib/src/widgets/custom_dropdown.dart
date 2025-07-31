import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final String titulo;
  final String hintText;
  final List<String> items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final bool readOnly;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.titulo,
    required this.hintText,
    required this.items,
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

          child: DropdownButtonFormField<String>(
            value: value,
            hint: Text(
              hintText,
              style: TextStyle(color: Colors.grey[400], fontSize: 16),),
              items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: readOnly ? null : onChanged,
            validator: validator,
            isExpanded: true,
            decoration: const InputDecoration.collapsed(hintText: '',),
            dropdownColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
