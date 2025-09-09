import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:profmate/src/app/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:profmate/src/services/auth_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Verifica login persistente
  final isLoggedIn = await AuthService().checkLogin();

  runApp(AppWidget(initialRoute: isLoggedIn ? '/home' : '/login'));
}
