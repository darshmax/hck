import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hck_case_management/Providers/login_provider.dart';
import 'package:hck_case_management/Screens/HomeScreen/home_screen.dart';
import 'package:provider/provider.dart';

import 'Helpers/auth_service.dart';
import 'Providers/global_provider.dart';
import 'Screens/LoginScreen/login_screen.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  AuthService appAuth = new AuthService();

  Widget _defaultHome = new MainLogin();

  bool _result = await appAuth.login();
  if (_result) {
    _defaultHome = new HomeScreen();
  }
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp(home: _defaultHome,));
}

class MyApp extends StatelessWidget {
  final Widget home;

  const MyApp({Key key, this.home}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GlobalProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
      ],
      child: MaterialApp(
        title: 'High Court of Karnataka',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          // textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
          // .apply(bodyColor: Colors.black87,),
        ),
        home: home,
      ),
    );
  }
}

