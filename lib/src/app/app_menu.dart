import 'package:flutter/material.dart';
import 'package:profmate/src/controller/mural_controller.dart';
import 'package:profmate/src/controller/tarefas_controller.dart';
import 'package:profmate/src/models/menu_model.dart';
import 'package:profmate/src/views/agenda_view.dart';
import 'package:profmate/src/views/alunos_view.dart';
import 'package:profmate/src/views/atividade_view.dart';
import 'package:profmate/src/views/financeiro_view.dart';
import 'package:profmate/src/views/mural_view.dart';
import 'package:profmate/src/views/home_view.dart';
import 'package:profmate/src/views/suporte_view.dart';
import 'package:profmate/src/views/tarefas_view.dart';

final List<MenuModel> appMenuItems = [
  MenuModel(
    title: 'Home',
    icon: Icons.home,
    route: '/home',
    page: const HomeView(),
  ),

  MenuModel(
    title: 'Alunos',
    icon: Icons.person,
    route: '/alunos',
    //page: AlunosView(cadastroAlunoController: CadastroAlunoController(),),
    page: AlunosView(),
  ),

  MenuModel(
    title: 'Agenda',
    icon: Icons.calendar_month_outlined,
    route: '/agenda',
    page: AgendaView(),
  ),

  MenuModel(
    title: 'Atividades',
    icon: Icons.book,
    route: '/atividades',
    page: AtividadesView(),
  ),

  MenuModel(
    title: 'Mural',
    icon: Icons.message,
    route: '/mural',
    page: MuralView(controller: MuralController()),
  ),

  MenuModel(
    title: 'Financeiro',
    icon: Icons.attach_money_rounded,
    route: '/financeiro',
    page: FinanceiroView(),
  ),

  MenuModel(
    title: 'Tarefas',
    icon: Icons.check_box,
    route: '/tarefas',
    page: TarefasView(controller: TarefasController()),
  ),

  MenuModel(
    title: 'Suporte',
    icon: Icons.help,
    route: '/suporte',
    page: SuporteView(),
  ),

  /*  MenuModel(
    title: 'Configurações',
    icon: Icons.settings,
    route: '/configuracoes',
    page: ConfiguracoesView(configuracoesController: ConfiguracoesController()),
  ), */
];
