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
            HomeButton(label: 'Alunos', onPressed: (){}, icon: Icons.person,), //widget personalizado, primeiro sendo o label do botao e dps a função
            //botao atividades
            HomeButton(label: 'Atividades', onPressed: (){}, icon: Icons.edit,),
              ],
            ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
            //botao financeiro
            HomeButton(label: "Financeiro", onPressed: (){}, icon: Icons.attach_money_rounded,),
            //botao mural
            HomeButton(label: "Mural", onPressed: (){}, icon: Icons.message,)
            ],
           )
            
          ],
        
        ),
      );
  }
}