import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
   Future<bool> checkLogin(context)async{
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString(('jwt_token'));

  if(token == null){
    //Navigator.pushReplacementNamed(context, '/login');
    return false;
  }
  return true;
 }

 Future<void> logout()async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('jwt_token');
 }
}