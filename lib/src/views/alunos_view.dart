import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AlunosView extends StatefulWidget {
  const AlunosView({super.key});

  @override
  State<AlunosView> createState() => _AlunosViewState();
}

class _AlunosViewState extends State<AlunosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: SpeedDial(     
        backgroundColor: Color(0xFFBDD9FF),
        icon: (Icons.add),   
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        children: [
          SpeedDialChild(
            label: "Cadastrar aluno",
            backgroundColor: Colors.white,
            onTap: (){
              //colocar aqui ação de cadastrar novo aluno
            },
          ),
          SpeedDialChild(
            label: "Cadastrar turma",
            backgroundColor: Colors.white,
            onTap: () {
              //colocar aqui ação de cadastrar nova turma
            },
          )
        ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            
          ),
          ), 
    );
  }
}