import 'package:flutter/material.dart';

class CampoFormulario extends StatelessWidget {
  final TextEditingController controller;
  final String titulo;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

  const CampoFormulario({
    super.key,
    required this.controller,
    required this.hintText,
    required this.titulo,
    this.validator,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titulo != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              titulo!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 4),
        ],

        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: Colors.black),
            color: readOnly ? Color.fromARGB(138, 230, 225, 225): Colors.white,
          ),

          child: TextFormField(
            controller: controller,
            onTap: onTap,
            readOnly: readOnly,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            validator: validator,
            keyboardType: keyboardType,
          ),
        ),
      ],
    );
  }
}
