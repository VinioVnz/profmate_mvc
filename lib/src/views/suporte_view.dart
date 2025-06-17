import 'package:flutter/material.dart';

class SuporteView extends StatefulWidget {
  const SuporteView({super.key});

  @override
  State<SuporteView> createState() => _SuporteViewState();
}

class _SuporteViewState extends State<SuporteView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: Text('Dúvidas frequentes', style: TextStyle(fontSize: 24)),
          ),
          SizedBox(height: 16),

          //Os cards das perguntas frequentes foram criados, mas a informação precisa ser ajustada depois de o app pronto.
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpansionTile(
              title: Text("Como adiciono um novo aluno?"),
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Acesse a aba “Alunos” no menu principal e toque em “+ Adicionar aluno”. '
                    'Preencha as informações básicas como nome, e-mail, telefone e nível de ensino.',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpansionTile(
              title: Text("Como agendo uma aula?"),
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    ''
                    '',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpansionTile(
              title: Text("O app envia lembretes para os alunos?"),
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    ''
                    '',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpansionTile(
              title: Text("Consigo registrar pagamentos recebidos?"),
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    ''
                    '',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpansionTile(
              title: Text("É possível gerar relatórios financeiros?"),
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    ''
                    '',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpansionTile(
              title: Text("Como acompanho as pendências de pagamento?"),
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    ''
                    '',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpansionTile(
              title: Text("Posso personalizar a duração padrão das aulas?"),
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    ''
                    '',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
