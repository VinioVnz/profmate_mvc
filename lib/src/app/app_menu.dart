import 'package:flutter/material.dart';
import 'package:profmate/src/controller/bulletin_board_controller.dart';
import 'package:profmate/src/models/menu_model.dart';
import 'package:profmate/src/views/bulletin_board_view.dart';
import 'package:profmate/src/views/financeiro_view.dart';
import 'package:profmate/src/views/home_view.dart';

final List<MenuModel> appMenuItems = [
  MenuModel(
    title: 'Menu',
    icon: Icons.home,
    route: '/home',
    page: const HomeView()
  ),

  //adicionando o Mural (Bulletin Board) a lista do Menu
  MenuModel(
    title: 'Mural', 
    icon: Icons.message, 
    route: '/mural', 
    page: BulletinBoardView(
      controller: BulletinBoardController(),
    )
  ),

  MenuModel(
    title: 'Financeiro', 
    icon: Icons.money_off_csred_outlined, 
    route: '/financeiro', 
    page: FinanceiroView(
    )
  ),
  
];