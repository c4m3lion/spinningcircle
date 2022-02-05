import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class WheelPage extends StatefulWidget {
  const WheelPage({Key? key}) : super(key: key);

  @override
  _WheelPageState createState() => _WheelPageState();
}

class _WheelPageState extends State<WheelPage> {
  StreamController<int> controller = StreamController<int>();
  int item = 0;

  void spin() {
    var rng = Random();
    item = rng.nextInt(3);
    print(item);
    controller.add(item);
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
        title: Text("Spinning wheel"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 500,
              child: FortuneWheel(
                animateFirst: false,
                onFling: () {
                  spin();
                },
                selected: controller.stream,
                items: [
                  FortuneItem(child: Text('Masin')),
                  FortuneItem(child: Text('playstation')),
                  FortuneItem(child: Text('silah')),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 100,
            child: ElevatedButton(
                onPressed: () => {
                      spin(),
                    },
                child: Text("PRESS")),
          )
        ],
      ),
    );
  }
}
