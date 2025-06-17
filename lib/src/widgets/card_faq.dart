import 'package:flutter/material.dart';

class CardFaq extends StatelessWidget {
  final String pergunta;
  final String resposta;
  const CardFaq({required this.pergunta, required this.resposta, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(pergunta),
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(resposta, textAlign: TextAlign.justify),
          ),
        ],
      ),
    );
  }
}
