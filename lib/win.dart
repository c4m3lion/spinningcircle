// ignore_for_file: prefer_const_constructors

import 'package:fireworks/fireworks.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spinningcircle/datas.dart';

class WinPage extends StatefulWidget {
  const WinPage({Key? key}) : super(key: key);

  @override
  _WinPageState createState() => _WinPageState();
}

class _WinPageState extends State<WinPage> {
  void playSound() async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playSound();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Şansınızı sınayın!"),
        ),
        backgroundColor: Colors.grey.withOpacity(0.5),
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
            ),
            Fireworks(
              numberOfExplosions: 10,
              delay: 2,
            ),
            SizedBox(
              height: 200,
              width: 300,
              child: Card(
                color: MyColors.green,
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Təbriklər!\nSiz\n${UserData.object}\nQazandınız!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    )),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(100),
                child: SizedBox(
                  height: 70,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onSurface: Colors.red,
                    ),
                    onPressed: () => {
                      Navigator.pop(context),
                    },
                    child: Text(
                      "Geri",
                      style: TextStyle(fontSize: 30, color: MyColors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
