import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hck_case_management/Screens/LoginScreen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants.dart';


class AuthService {
  Future<bool> login() async {
    final prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString('loginUser') ?? "";
    if(auth != ""){
      return true;
    }else {
      return false;
    }
  }

  // Logout
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(loginUser, "");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
      return MainLogin();
    }));
  }
}