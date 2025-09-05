import 'package:flutter/material.dart';
import 'package:profmate/src/controller/aula_api_controller.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/widgets/agenda_widget.dart';
import 'package:profmate/src/widgets/home_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  //DateTime _diaSelecionado = DateTime.now();
  Map<DateTime, List<Map<String, String>>> _aulasPorDia = {};
  TextEditingController dataController = TextEditingController();
  final horarioController = TextEditingController();
  final AulaApiController _aulaController = AulaApiController();
  final CadastroAlunoController _alunoController = CadastroAlunoController();
  AlunoApiModel? selectedAluno;
  List<AlunoApiModel> alunos = [];
  int? usuarioId;

  @override
  void initState() {
    super.initState();
    _carregarIdUsuario();
    loadAlunos().then((_) => loadAulas());
  }

  void _carregarIdUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');
    if (id != null) {
      setState(() {
        usuarioId = id;
      });
    }
  }

  Future<void> loadAulas() async {
    try {
      final lista = await _aulaController.listarAulas(context);

      setState(() {
        _aulasPorDia.clear();

        for (var aula in lista) {
          final aluno = alunos.firstWhere(
            (a) => a.id == aula.idAluno && a.usuarioId == usuarioId,
            orElse: () => AlunoApiModel(
              id: 0,
              nome: 'Aluno não encontrado',
              cpf: '',
              email: '',
              endereco: '',
              telefone: '',
              dataNascimento: '',
              usuarioId: 0,
            ),
          );

          // só adiciona se tiver um id válido
          if (aluno.id == 0) continue;

          final dataNormalizada = DateTime.parse(aula.data);
          _aulasPorDia[dataNormalizada] ??= [];
          _aulasPorDia[dataNormalizada]!.add({
            'nome': aluno.nome,
            'horario': aula.horario,
          });
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao carregar Aulas'),
          backgroundColor: Colors.red,
        ),
      );
      print('ERRO LOAD AULAS: $e');
    }
  }

  Future<void> loadAlunos() async {
    final lista = await _alunoController.listarAluno(context);
    setState(() {
      alunos = lista;
    });
  }

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
              flex: 3, // controla o quanto da tela ela pega
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
                      child: AgendaWidget(aulasPorDia: _aulasPorDia),
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
              flex: 2, // menor que a agenda
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
                          Navigator.pushReplacementNamed(
                            context,
                            '/atividade_view',
                          );
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
                          Navigator.pushReplacementNamed(
                            context,
                            '/financeiro',
                          );
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
