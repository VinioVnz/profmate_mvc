import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  const HomeButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150,
          height: 90,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // alinha à esquerda
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) Icon(icon, size: 28),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
