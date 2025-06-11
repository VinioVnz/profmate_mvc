import 'package:flutter/material.dart';
import 'package:profmate/src/widgets/home_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
          //fazer os botoes
          children: [
            //botao alunos
            HomeButton(label: 'Alunos', onPressed: (){}, icon: Icons.abc,), //widget personalizado, primeiro sendo o label do botao e dps a função
            //botao atividades
            HomeButton(label: 'Atividades', onPressed: (){}),
            //botao financeiro
            HomeButton(label: "Financeiro", onPressed: (){}),
            //botao mural
            HomeButton(label: "Mural", onPressed: (){})
            
          ],
        
        ),
      );
  }
}