import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  const HomeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.0, color: Color(0xffE6E6E6)),
        ),
        width: 130,
        height: 127,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(4),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Stack(
            children: [
              if (icon != null)
                Positioned(
                  child: Center(child: 
                    Icon(icon, size: 48,color: Colors.black,))
                ),

                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(label, 
                          style: const TextStyle(
                            fontSize: 14, 
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                            )
                          ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
