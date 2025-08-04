import 'package:flutter/material.dart';
import 'package:profmate/src/app/app_menu.dart';
import 'package:profmate/src/views/add_ementa_view.dart';
import 'package:profmate/src/views/progress_view.dart';
import 'package:profmate/src/widgets/base_layout.dart';

Map<String, WidgetBuilder> generateRoutes(){
  final Map<String, WidgetBuilder> routes = {
    '/': (_) => const ProgressView(),
    '/addEmenta': (_) => const AddEmentaView(),

  };

  for(var item in appMenuItems){
    routes[item.route] = (context) => BaseLayout(
      title: item.title,
      body: item.page,);

    }
  return routes;
  }