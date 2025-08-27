import 'package:flutter/material.dart';
import 'package:profmate/src/widgets/agenda_widget.dart';
import 'package:profmate/src/widgets/home_button.dart';

//Código por: Vinícius Bornhofen
//Última alteração: 09/07/2025
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
    final size = MediaQuery.of(context).size;
    return Padding(
  padding: const EdgeInsets.all(16),
  child: SizedBox(
    width: size.width,
    height: size.height,
    child: Column(
      children: [
        // Agenda ocupa parte maior da tela
        Expanded(
          flex: 3, // 👈 controla o quanto da tela ela pega
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey, width: 0.4),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AgendaWidget(),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/agenda');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12), // espaçamento responsivo

        // Botões ocupam menos espaço proporcional
        Expanded(
          flex: 2, // 👈 menor que a agenda
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeButton(
                    label: 'Alunos',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/alunos');
                    },
                    icon: Icons.person,
                  ),
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
                  HomeButton(
                    label: "Financeiro",
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/financeiro');
                    },
                    icon: Icons.attach_money_rounded,
                  ),
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
        ),
      ],
    ),
  ),
);

  }
}
