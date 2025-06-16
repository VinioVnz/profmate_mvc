import 'package:flutter/material.dart';
import 'package:profmate/src/app/app_routes.dart';
import 'package:profmate/src/services/auth_service.dart';
import 'package:profmate/src/views/login_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProfMate',
      initialRoute: AuthService.isLoggedIn ? '/home' : '/login',
      routes: {
        '/login' : (context) => LoginView(),
        ...generateRoutes()
      },
    );
  }
}