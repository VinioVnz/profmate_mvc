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
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(//responsabilidade, tornar a tela arrastavel
        child: Column(
          children: [
            //deixar a agenda clicavel, quando clico na agenda ele navega para a tela agenda
            //é feito a utilização de um inkWell, pois o Elevated Button permite cliques internos
            //(quando clicava em um dia, ele não navegava)
            Container(
              height: 360,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey,
                  width: 0.4, // espessura da borda
                ),
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
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //botao alunos
                HomeButton(
                  label: 'Alunos',
                  onPressed: () {
                  Navigator.pushReplacementNamed(context, '/alunos');
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
      ),
    );
  }
}
