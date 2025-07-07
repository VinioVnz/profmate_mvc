import 'package:flutter/material.dart';
import 'package:profmate/src/widgets/agenda_widget.dart';
import 'package:profmate/src/widgets/home_button.dart';

//Código por: Vinícius Bornhofen
//Última alteração: 07/07/2025
//add rota do financeiro,
//PENDENTE: Add rota do alunos e do atividades(ambas telas nao foram feitas ainda)
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DateTime _diaSelecionado = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          AgendaWidget(
            diaSelecionado: _diaSelecionado,
            mostrarAulas: false,
            onDiaSelecionado: (dia) {
              setState(() {
                _diaSelecionado = dia;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //botao alunos
              HomeButton(
                label: 'Alunos',
                onPressed: () {
                  //Navigator.pushReplacementNamed(context, '/alunos');
                },
                icon: Icons.person,
              ), //widget personalizado, primeiro sendo o label do botao e dps a função
              //botao atividades
              HomeButton(
                label: 'Atividades',
                onPressed: () {
                  //Navigator.pushReplacementNamed(context, '/atividades');
                },
                icon: Icons.edit,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //botao financeiro
              HomeButton(
                label: "Financeiro",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/financeiro');
                },
                icon: Icons.attach_money_rounded,
              ),
              //botao mural
              HomeButton(
                label: "Mural",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/mural');
                },
                icon: Icons.message,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
