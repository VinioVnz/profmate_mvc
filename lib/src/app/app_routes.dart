import 'package:flutter/material.dart';
import 'package:profmate/src/app/app_menu.dart';
import 'package:profmate/src/views/add_ementa_view.dart';
import 'package:profmate/src/views/progresso_view.dart';
import 'package:profmate/src/views/adicionar_atividade_view.dart';
import 'package:profmate/src/widgets/base_layout.dart';

Map<String, WidgetBuilder> generateRoutes() {
  final Map<String, WidgetBuilder> routes = {
    '/progresso': (_) => const ProgressoView(),
    '/addEmenta': (_) => const AddEmentaView(),
    '/adicionar_atividade_view': (_) => const AdicionarAtividadeView(),
  };

  for (var item in appMenuItems) {
    routes[item.route] = (context) =>
        BaseLayout(title: item.title, body: item.page);
  }
  return routes;
}
