import 'package:flutter/material.dart';
import 'package:profmate/src/widgets/home_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
          //fazer os botoes
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 //botao alunos
            HomeButton(label: 'Alunos', onPressed: (){
              //Navigator.pushReplacementNamed(context, '');
            }, icon: Icons.person,), //widget personalizado, primeiro sendo o label do botao e dps a função
            //botao atividades
            HomeButton(label: 'Atividades', onPressed: (){
              //Navigator.pushReplacementNamed(context, '');
            }, icon: Icons.edit,),
              ],
            ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
            //botao financeiro
            HomeButton(label: "Financeiro", onPressed: (){
              //Navigator.pushReplacementNamed(context, '');
            }, icon: Icons.attach_money_rounded,),
            //botao mural
            HomeButton(label: "Mural", onPressed: (){
              Navigator.pushReplacementNamed(context, '/mural');
            }, icon: Icons.message,)
            ],
           )
            
          ],
        
        ),
      );
  }
}