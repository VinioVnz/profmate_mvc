import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:profmate/src/app/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

   // Carrega variáveis do .env
  print("Caminho atual: ${Directory.current.path}"); 
  await dotenv.load(fileName: ".env");
  runApp(AppWidget());
}