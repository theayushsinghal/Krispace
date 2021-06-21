import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krispace/screens/authentication/intro.dart';
import 'package:krispace/screens/authentication/login.dart';
import 'package:krispace/screens/authentication/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateProfilePopup extends StatefulWidget {
  @override
  _CreateProfilePopup createState() => _CreateProfilePopup();
}

class _CreateProfilePopup extends State<CreateProfilePopup> {
  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    double Height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    Width /= 414;
    Height /= 736;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.transparent, //Color(0xff1B262C),
        contentPadding: EdgeInsets.zero,
        content: Stack(
          alignment: Alignment.center,
          fit: StackFit.passthrough,
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff1B262C),
                    border: Border.all(
                      width: 2,
                      color: Color(0xff00FF94),
                    )),
                width: 320 * Width,
                height: 341 * Height,
              ),
            ),
            Positioned(
              left: 25 * Width,
              top: 79 * Height,
              child: Container(
                width: 269 * Width,
                height: 24 * Height,
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'To enjoy all activities login first.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Arial-Regular'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (124 * Height),
              left: (70 * Width),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Login();
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff1B262C),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 2,
                      color: Color(0xffFFC857),
                    ),
                  ),
                  width: (180 * Width),
                  height: (32 * Height),
                  child: Center(
                    child: Text(
                      "Go to Login",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xffFFC857),
                        fontFamily: "Arial-normal",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 26 * Height,
              left: 145 * Width,
              child: Container(
                height: 40 * Height,
                width: 40 * Width,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xffFFC857),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (271 * Height),
              left: (70 * Width),
              child: GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  bool check = prefs.getBool("FirstLogin");
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    if (check == null) {
                      prefs.setBool("FirstLogin", true);
                      return Intro();
                    } else {
                      return Register();
                    }
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff1B262C),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 2,
                      color: Color(0xffFFC857),
                    ),
                  ),
                  width: (180 * Width),
                  height: (32 * Height),
                  child: Center(
                    child: Text(
                      "Go to Create Account",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xffFFC857),
                        fontFamily: "Arial-normal",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 26 * Width,
              top: 179 * Height,
              child: Container(
                alignment: Alignment.center,
                width: 269 * Width,
                height: 24 * Height,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Or',
                    style: TextStyle(
                      color: Color(0xff00FF94),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 25 * Width,
              top: 226 * Height,
              child: Container(
                width: 269 * Width,
                height: 24 * Height,
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'New User ? create your account first.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Arial-Regular'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 290 * Width,
              top: 11 * Height,
              child: Opacity(
                opacity: .8,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20 * Height,
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
