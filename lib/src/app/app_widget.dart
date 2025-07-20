import 'package:flutter/material.dart';
import 'package:profmate/src/app/app_routes.dart';
import 'package:profmate/src/services/auth_service.dart';
import 'package:profmate/src/views/login_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:profmate/theme/app_colors.dart';


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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF1E3A5E),
          ),
            useMaterial3: false,
            textTheme: GoogleFonts.montserratTextTheme(),
  
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1E3A5E),
            foregroundColor: Colors.white,
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1E3A5E),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      title: 'ProfMate',
      initialRoute: AuthService.isLoggedIn ? '/home' : '/login',
      routes: {
        '/login' : (context) => LoginView(),
        ...generateRoutes()
      },
    );
  }
}