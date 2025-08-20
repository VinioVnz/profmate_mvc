import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String titulo;
  final String mensagem;
  final VoidCallback aoCancelar;
  final VoidCallback aoConfirmar;
  
  const CustomDialog({
    required this.titulo,
    required this.mensagem,
    required this.aoCancelar,
    required this.aoConfirmar,
    super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
      ),
      title: Text(titulo, textAlign: TextAlign.center,),
      content: Text(mensagem, textAlign: TextAlign.center,),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row( mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: BotaoCancelar(aoCancelar: aoCancelar)),
              SizedBox(width: 12),
              Expanded(child: BotaoConfirmar(aoConfirmar: aoConfirmar)),
            ],
          ),
        ),
       
      ],
    );
  }
}

class BotaoCancelar extends StatelessWidget {
  final String tituloBotao;
  final VoidCallback? aoCancelar;

  const BotaoCancelar({
    required this.aoCancelar,
    this.tituloBotao = "Cancelar",
    super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 167, 17, 6),
        foregroundColor: Colors.white,
        elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: aoCancelar,
      child: Text(tituloBotao),
    );
  }
}

class BotaoConfirmar extends StatelessWidget {
  final String tituloBotao;
  final VoidCallback? aoConfirmar;

  const BotaoConfirmar({
    required this.aoConfirmar,
    this.tituloBotao = "Confirmar",
    super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 53, 91, 140),
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: aoConfirmar,
      child: Text(tituloBotao),
    );
  }
}
