// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spinningcircle/datas.dart';
import 'package:spinningcircle/game.dart';
import 'package:spinningcircle/login.dart';
import 'package:spinningcircle/menu.dart';
import 'package:spinningcircle/wheel.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(Shortcuts(
    shortcuts: <LogicalKeySet, Intent>{
      LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
    },
    child: MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: MyColors.background),
      initialRoute: '/login',
      routes: {
        '/wheel': (context) => WheelPage(),
        '/menu': (context) => MenuPage(),
        '/game': (context) => GamePage(),
        '/login': (context) => LoginPage(),
      },
    ),
  ));
}
