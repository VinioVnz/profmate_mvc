import 'package:flutter/material.dart';
import 'package:profmate/src/models/menu_model.dart';
import 'package:profmate/src/views/home_view.dart';

final List<MenuModel> appMenuItems = [
  MenuModel(
    title: 'Menu',
    icon: Icons.home,
    route: '/home',
    page: const HomeView()
    
  ),
];