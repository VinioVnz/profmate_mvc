import 'package:flutter/material.dart';
import 'package:profmate/src/widgets/card_faq.dart';

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
                "Acesse a aba “Alunos” no menu principal e toque em “+ Adicionar aluno”. "
                "Preencha as informações básicas como nome, e-mail, telefone e nível de ensino.",
          ),
          CardFaq(
            pergunta: "Como agendo uma aula?",
            resposta:
                "Na aba “Agenda”, toque no dia desejado ou no botão “+”. "
                "Escolha o aluno, horário, duração e local da aula. "
                "Você também pode adicionar observações.",
          ),
          CardFaq(
            pergunta: "O app envia lembretes para os alunos?",
            resposta: "resposta",
          ),
          CardFaq(
            pergunta: "Consigo registrar pagamentos recebidos?",
            resposta: "resposta",
          ),
          CardFaq(
            pergunta: "É possível gerar relatórios financeiros?",
            resposta: "resposta",
          ),
          CardFaq(
            pergunta: "Como acompanho as pendências de pagamento?",
            resposta: "resposta",
          ),
          CardFaq(
            pergunta: "Posso personalizar a duração padrão das aulas?",
            resposta: "resposta",
          ),
          CardFaq(
            pergunta: "Como registro atividades ou tarefas para um aluno?",
            resposta: "resposta",
          ),
          CardFaq(
            pergunta: "O aluno pode ver as tarefas que eu envio?",
            resposta: "resposta",
          ),
          CardFaq(
            pergunta: "É possível anexar arquivos, como PDFs ou imagens?",
            resposta: "resposta",
          ),
          CardFaq(
            pergunta: "Como me comunico com os alunos pelo app?",
            resposta: "resposta",
          ),
          CardFaq(
            pergunta: "Consigo ver um histórico de aulas dadas a cada aluno?",
            resposta: "resposta",
          ),
          CardFaq(pergunta: "O app funciona offline?", resposta: "resposta"),
          CardFaq(
            pergunta: "O app tem backup dos meus dados?",
            resposta: "resposta",
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
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.email_outlined),
                    label: Text("Enviar um e-mail"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {
                      // colocar aqui o método de enviar email
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
