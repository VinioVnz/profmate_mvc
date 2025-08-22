import 'package:flutter/material.dart';

class BarraPesquisa extends StatelessWidget {
  final String textoBarra;
  final ValueChanged<String> onChanged;

  const BarraPesquisa({
    Key? key,
    required this.textoBarra,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: textoBarra,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
        onChanged: onChanged,
      ),
    );
  }
}