import 'package:flutter/material.dart';
import 'package:profmate/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.azulEscuro, width: 2),
          ),
        ),
      ),
    );
  }
}
