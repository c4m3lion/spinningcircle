// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_osk/flutter_osk.dart';
import 'package:process_run/shell.dart';
import 'package:spinningcircle/datas.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _focus = FocusNode();
  TextEditingController txtController = TextEditingController();
  void _onFocusChange() async {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
    var shell = Shell();

    var t = shell.run("osk.exe");
    WindowsOSK.show();
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();

    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WindowsOSK.show();
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Çarxı fırlat \nvə\nHədiyyə qazan!",
                style: TextStyle(fontSize: 50, color: MyColors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  focusNode: _focus,
                  autofocus: true,
                  //enabled: !process,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: MyColors.orange)),
                    filled: true,
                    fillColor: MyColors.yellow,
                    focusColor: MyColors.cyan,
                    hintText: "Enter login",
                    //labelText: "User",
                    //errorText: _validateUser,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                height: 100,
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.pushReplacementNamed(context, '/game'),
                  },
                  //onPressed:
                  //    process ? null : () => {checkInput(canGo: true)},
                  child: Text(
                    "Başla",
                    style: TextStyle(fontSize: 30),
                  ),
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
              SizedBox(
                width: 300,
                child: Text(
                  "Qeyd edək ki hər 10 sifarişinizə yalnız 1 fırlatma şansı verilir. İstifadə olunmamış fırlatmalar balansınızdan silinmir.",
                  style: TextStyle(fontSize: 20, color: MyColors.white),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
