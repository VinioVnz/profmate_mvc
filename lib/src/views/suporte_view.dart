import 'package:flutter/material.dart';
import 'package:profmate/src/controller/suporte_controller.dart';
import 'package:profmate/src/widgets/card_faq.dart';

class SuporteView extends StatefulWidget {
  const SuporteView({super.key});

  @override
  State<SuporteView> createState() => _SuporteViewState();
}

class _SuporteViewState extends State<SuporteView> {
  final SuporteController _controller = SuporteController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          Center(
            child: Text(
              'Dúvidas frequentes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          CardFaq(
            pergunta: "Como adiciono um novo aluno?",
            resposta:
                "Acesse a tela “Alunos” no menu principal, toque no botão no canto inferior direito da tela e escolha a opção “Cadastrar aluno”. "
                "Preencha as informações completas do seu novo aluno e toque em “Salvar”."
          ),
          CardFaq(
            pergunta: "Como agendo uma aula?",
            resposta:
                "No menu do app, toque no calendário, a tela da agenda será aberta. "
                "Toque no botão “+”, no canto inferior direito da tela. "
                "Escolha a data, o horário e o aluno da aula e toque em “Salvar”."
          ),
          CardFaq(
            pergunta: "Consigo registrar pagamentos recebidos?",
            resposta: "Sim. Na tela 'Financeiro', encontre o pagamento gerado para o aluno em questão e registre o pagamento tocando na caixinha de confirmação.",
          ),
          CardFaq(
            pergunta: "Como acompanho as pendências de pagamento?",
            resposta: "Na tela “Financeiro”, você encontra os pagamentos registrados listados e o status de cada um deles.",
          ),
           CardFaq(
            pergunta: "Como registro atividades para um aluno?",
            resposta: "Vá até o menu do app e toque em “Atividades”. "
            "Toque no botão “Criar nova atividade” na parte de baixo da tela. "
            "Registre os dados da nova atividade e toque no botão “Criar atividade”.",
          ),
          CardFaq(
            pergunta: "É possível anexar arquivos, como PDFs ou imagens?",
            resposta: "Sim. Quando criar uma nova atividade, adicione o material no campo “Arquivos”.",
          ),
          CardFaq(
            pergunta: "Como me comunico com os alunos pelo app?",
            resposta: "Você pode se comunicar com seus alunos pelo “Mural”. " 
            "Acesse o “Mural” pelo menu sanduíche do app no canto superior esquerdo. "
            "Digite seu recado na barra na parte de baixo da tela e o envie.",
          ),
          
          CardFaq(pergunta: "O app funciona offline?", resposta: "Não. Para fazer login e utilizar os dados do app, você precisa de acesso à internet."),
          CardFaq(
            pergunta: "O app tem backup dos meus dados?",
            resposta: "Sim, todos os seus dados estão seguros em nosso banco de dados.",
          ),
          SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1.0, color: Color(0xffE6E6E6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Não encontrou resposta para a sua dúvida?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  "Entre em contato conosco por e-mail.",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.email_outlined),
                    label: Text("Enviar um e-mail"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),
                      ),
                    ),
                    onPressed: () {
                      _controller.enviarEmailDeSuporte();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
