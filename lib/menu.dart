import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 50,
          width: 100,
          child: ElevatedButton(
            onPressed: (() => {
                  Navigator.pushNamed(context, "/wheel"),
                }),
            child: Icon(Icons.play_arrow),
          ),
        ),
      ),
    );
  }
}
