
import 'dart:io';
import 'package:flutter/material.dart';

class CadastrarAlunoController{
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  final enderecoController = TextEditingController();
  final telefoneController = TextEditingController();
  final valorController = TextEditingController();
  final formaPagamentoController = TextEditingController();

  DateTime? dataNascimento;
  DateTime? vencimento;

   void dispose(){
    nomeController.dispose();
    cpfController.dispose();
    emailController.dispose();
    enderecoController.dispose();
    telefoneController.dispose();
    valorController.dispose();
    formaPagamentoController.dispose();
    
  }
  
}