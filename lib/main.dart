// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spinningcircle/datas.dart';
import 'package:spinningcircle/login.dart';
import 'package:spinningcircle/wheel.dart';
import 'package:spinningcircle/win.dart';

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
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: MyColors.background, centerTitle: true),
        scaffoldBackgroundColor: MyColors.background,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyColors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  width: 0.0,
                ),
              ),
            ),
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/wheel': (context) => WheelPage(),
        '/login': (context) => LoginPage(),
        '/win': (context) => WinPage(),
      },
    ),
  ));
}
