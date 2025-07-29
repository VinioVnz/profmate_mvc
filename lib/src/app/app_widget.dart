import 'package:flutter/material.dart';
import 'package:profmate/src/app/app_routes.dart';
import 'package:profmate/src/services/auth_service.dart';
import 'package:profmate/src/views/login_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('pt','BR'),
      supportedLocales: const[
        Locale('pt','BR')
      ],
      localizationsDelegates: const[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
      title: 'ProfMate',
      initialRoute: '/login',
      //AuthService.isLoggedIn  ? '/home' : '/login'
      routes: {
        '/login' : (context) => LoginView(),
        ...generateRoutes()
      },
    );
  }
}