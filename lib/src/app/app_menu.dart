import 'package:flutter/material.dart';
import 'package:profmate/src/controller/configuracoes_controller.dart';
import 'package:profmate/src/controller/mural_controller.dart';
import 'package:profmate/src/models/menu_model.dart';
import 'package:profmate/src/views/configuracoes_view.dart';
import 'package:profmate/src/views/financeiro_view.dart';
import 'package:profmate/src/views/mural_view.dart';
import 'package:profmate/src/views/home_view.dart';
import 'package:profmate/src/views/suporte_view.dart';

final List<MenuModel> appMenuItems = [
  MenuModel(
    title: 'Menu',
    icon: Icons.home,
    route: '/home',
    page: const HomeView(),
  ),

  MenuModel(
    title: 'Financeiro',
    icon: Icons.attach_money_rounded,
    route: '/financeiro',
    page: FinanceiroView(),
  ),

  //adicionando o Mural à lista do Menu
  MenuModel(
    title: 'Mural',
    icon: Icons.message,
    route: '/mural',
    page: MuralView(controller: MuralController()),
  ),

  MenuModel(
    title: 'Configurações',
    icon: Icons.settings,
    route: '/configuracoes',
    page: ConfiguracoesView(configuracoesController: ConfiguracoesController()),
  ),

  MenuModel(
    title: 'Suporte',
    icon: Icons.help,
    route: '/suporte',
    page: SuporteView(),
  ),
];
