// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spinningcircle/datas.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fireworks/fireworks.dart';
import 'package:spinningcircle/win.dart';

class WheelPage extends StatefulWidget {
  const WheelPage({Key? key}) : super(key: key);

  @override
  _WheelPageState createState() => _WheelPageState();
}

class _WheelPageState extends State<WheelPage> {
  StreamController<int> controller = StreamController<int>();
  int item = 0;
  double power = 10;
  double powvalue = 5;
  bool powering = false;
  int spinningspeed = 10;
  bool isSpinning = false;

  void spin() {
    var rng = Random();
    item = rng.nextInt(3);
    print(item);
    controller.add(item);
  }

  void powerstop({int spinspeed = -1}) async {
    powvalue = 0;
    if (power <= 400 && power >= 340) {
      spinningspeed = 10;
    }
    if (power <= 340 && power >= 250) {
      spinningspeed = 7;
    }
    if (power <= 250 && power >= 140) {
      spinningspeed = 5;
    }
    if (power <= 140 && power >= 10) {
      spinningspeed = 3;
    }
    if (spinspeed != -1) {
      spinningspeed = spinspeed;
    }
    UserData.chance--;
    isSpinning = true;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 500));

    spin();
  }

  void powerstart() async {
    powering = true;
    setState(() {});
    while (powvalue != 0) {
      await Future.delayed(Duration(milliseconds: 1));
      power += powvalue;
      if (power > 400) {
        powvalue = -5;
      }
      if (power < 10) {
        powvalue = 5;
      }
      setState(() {});
    }
  }

  void win(context) async {
    final player = AudioPlayer();
    //TODO: implement api to send win
    await Future.delayed(Duration(seconds: 1));
    isSpinning = false;
    setState(() {});
    await player.setAsset('assets/winsound.mp3');
    player.play();
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false, // set to false
        pageBuilder: (_, __, ___) => WinPage(),
      ),
    );
  }

  _onBasicAlertPressed(context) {
    Alert(
      context: context,
      //title: "Alert",
      desc: "Çarxdan istifadə etmək üçün\nən azı 10 sifariş\ntamamlamalısınız!",
    ).show();
  }

  FortuneItemStyle wheelitemStyle() {
    return FortuneItemStyle(
      color: Colors.grey, // <-- custom circle slice fill color
      borderColor: Colors.green, // <-- custom circle slice stroke color
      borderWidth: 3, // <-- custom circle slice stroke width
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Şansınızı sınayın!"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/wheelback.png",
                  height: 645,
                ),
                Center(
                  child: SizedBox(
                    height: 500,
                    child: FortuneWheel(
                      animateFirst: false,
                      duration: Duration(seconds: spinningspeed),
                      indicators: <FortuneIndicator>[
                        FortuneIndicator(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            child: TriangleIndicator(
                              color: MyColors.red,
                            ),
                          ),
                        ),
                      ],
                      onFling: () {
                        powerstop(spinspeed: 10);
                      },
                      onAnimationStart: () {
                        print(spinningspeed);
                      },
                      onAnimationEnd: () {
                        win(context);
                      },
                      selected: controller.stream,
                      items: [
                        FortuneItem(
                          child: Text('Masin'),
                          style: wheelitemStyle(),
                        ),
                        FortuneItem(
                          child: Text('playstation'),
                          style: wheelitemStyle(),
                        ),
                        FortuneItem(
                          child: Text('silah'),
                          style: wheelitemStyle(),
                        ),
                        FortuneItem(
                          child: Text('silah1'),
                          style: wheelitemStyle(),
                        ),
                        FortuneItem(
                          child: Text('silah2'),
                          style: wheelitemStyle(),
                        ),
                        FortuneItem(
                          child: Text('silah3'),
                          style: wheelitemStyle(),
                        ),
                        FortuneItem(
                          child: Text('silah4'),
                          style: wheelitemStyle(),
                        ),
                        FortuneItem(
                          child: Text('silah5'),
                          style: wheelitemStyle(),
                        ),
                        FortuneItem(
                          child: Text('silah6'),
                          style: wheelitemStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: 0,
                ),
                Image.asset(
                  "assets/power.png",
                  height: 40,
                ),
                Positioned(
                  left: power,
                  child: Image.asset(
                    "assets/powerline.png",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onSurface: Colors.red,
                ),
                onPressed: isSpinning
                    ? null
                    : () => {
                          //spin(),
                          if (UserData.chance > 0)
                            {
                              powering ? powerstop() : powerstart(),
                            }
                          else
                            {
                              _onBasicAlertPressed(context),
                            }
                        },
                child: Text(
                  "Fırlat",
                  style: TextStyle(fontSize: 30, color: MyColors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: Text(
                "Mümkün fırlatmaların sayı: ${UserData.chance}",
                style: TextStyle(fontSize: 20, color: MyColors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
