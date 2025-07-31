import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String tituloBotao;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    required this.tituloBotao,
    required this.onPressed,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        onPressed: onPressed,
        child: Text(tituloBotao, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
