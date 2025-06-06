import 'package:flutter/material.dart';
import 'package:profmate/src/app/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProfMate',
      initialRoute: '/home',
      routes: generateRoutes(),
    );
  }
}