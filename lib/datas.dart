import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyColors {
  static Color yellow = const Color(0xffFFC914);
  static Color black = const Color(0xff2E282A);
  static Color cyan = const Color(0xff17BEBB);
  static Color orange = const Color(0xffE4572E);
  static Color green = const Color(0xff76B041);
  static Color red = const Color(0xffFF0000);
  static Color white = Colors.white;
  static Color background = const Color(0xff454E9E);

  static Color randomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }
}

class UserData {
  static String name = "";
  static String object = "";
  static int chance = 1;
}
