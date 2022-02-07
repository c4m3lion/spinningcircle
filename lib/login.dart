// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:spinningcircle/datas.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';
import 'package:window_manager/window_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Holds the text that user typed.
  String text = '';
  // True if shift enabled.
  bool shiftEnabled = false;
  bool showKeyboard = false;

  // is true will show the numeric keyboard.
  bool isNumericMode = false;
  TextEditingController txtController = TextEditingController();

  bool isLogin = false;

  /// Fired when the virtual keyboard key is pressed.
  _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      text = text + (shiftEnabled ? key.capsText : key.text);
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (text.length == 0) return;
          text = text.substring(0, text.length - 1);
          break;
        case VirtualKeyboardKeyAction.Return:
          text = text + '\n';
          break;
        case VirtualKeyboardKeyAction.Space:
          text = text + key.text;
          break;
        case VirtualKeyboardKeyAction.Shift:
          shiftEnabled = !shiftEnabled;
          break;
        default:
      }
    }
    print(text);
    // Update the screen
    setState(() {});
  }

  void setFullscreen() async {
    await WindowManager.instance.setFullScreen(true);
  }

  void login() async {
    isLogin = true;
    setState(() {});
    //TODO: implement api to login
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushNamed(context, '/wheel');
    isLogin = false;
    txtController.clear();
    text = "";
    UserData.chance = 1;
    UserData.name = "Ali";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setFullscreen();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  enabled: false,
                  controller: txtController,
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
                  onPressed: isLogin
                      ? null
                      : () => {
                            login(),
                          },
                  //onPressed:
                  //    process ? null : () => {checkInput(canGo: true)},
                  child: Text(
                    "Başla",
                    style: TextStyle(fontSize: 30),
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isLogin
          ? null
          : Container(
              // Keyboard is transparent
              color: Colors.deepPurple,
              child: VirtualKeyboard(
                  // Default height is 300
                  height: 350,
                  // Default height is will screen width
                  width: 600,
                  // Default is black
                  textColor: Colors.white,
                  textController: txtController,
                  // Default 14
                  fontSize: 20,
                  // the layouts supported
                  defaultLayouts: [VirtualKeyboardDefaultLayouts.English],
                  // [A-Z, 0-9]
                  type: VirtualKeyboardType.Alphanumeric,
                  // Callback for key press event
                  onKeyPress: _onKeyPress),
            ),
    );
  }
}
