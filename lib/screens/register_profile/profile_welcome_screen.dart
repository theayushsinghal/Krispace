import 'package:flutter/material.dart';

import 'create_profile_screen.dart';

class ProfileWelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(27, 38, 44, 1),
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.passthrough,
          children: [
            Positioned(
              left: leftWidth(context, 251),
              top: topHeight(context, -66),
              child: Opacity(
                opacity: 0.10,
                child: Container(
                  color: Colors.transparent,
                  width: leftWidth(context, 241),
                  height: topHeight(context, 205),
                  child: Image.asset(
                    "Assets/Images/krispace_logo.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 44),
              left: leftWidth(context, 29),
              child: Container(
                color: Colors.transparent,
                width: leftWidth(context, 358),
                height: topHeight(context, 597),
                child: Image.asset(
                  "Assets/Images/Vector 1.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 641.5),
              left: leftWidth(context, 2),
              child: Container(
                color: Colors.transparent,
                width: leftWidth(context, 388),
                height: topHeight(context, 83.5),
                child: Image.asset(
                  "Assets/Images/Vector 2.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 23),
              left: leftWidth(context, 37),
              child: Container(
                margin: EdgeInsets.all(7.73),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 255, 148, 1),
                  shape: BoxShape.circle,
                ),
                width: leftWidth(context, 34),
                height: topHeight(context, 34),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.arrow_back_rounded),
                  onPressed: () {},
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 74),
              left: leftWidth(context, 37),
              child: Container(
                width: leftWidth(context, 232),
                height: topHeight(context, 49),
                child: Text(
                  'Welcome !!',
                  style: TextStyle(
                    fontSize: 34.0,
                    color: Colors.white,
                    fontFamily: "Oswald-Regular",
                  ),
                ),
              ),
            ),
            Positioned(
              left: leftWidth(context, 67),
              top: topHeight(context, 148),
              child: Container(
                color: Colors.transparent,
                width: leftWidth(context, 280),
                height: topHeight(context, 280),
                child: Image.asset(
                  "Assets/Images/profile_welcome.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 451),
              left: leftWidth(context, 74),
              child: Container(
                width: leftWidth(context, 286),
                height: topHeight(context, 60),
                child: Text(
                  'Welcome to the world of Krispace',
                  style: TextStyle(
                    height: 1.2,
                    fontSize: 24.0,
                    color: Colors.white,
                    fontFamily: "Oswald-Regular",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 530),
              left: leftWidth(context, 54),
              child: Container(
                width: leftWidth(context, 306),
                height: topHeight(context, 49),
                child: Text(
                  'Let\'s create your profile',
                  style: TextStyle(
                    height: 1.2,
                    fontSize: 24.0,
                    color: Colors.white,
                    fontFamily: "Oswald-Regular",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 618),
              left: leftWidth(context, 34),
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 200, 87, 1),
                    borderRadius: BorderRadius.circular(5)),
                width: leftWidth(context, 346),
                height: topHeight(context, 48),
                child: TextButton(
                  child: Text(
                    'Create Profile',
                    style: TextStyle(
                        height: 1.25,
                        fontSize: 24.0,
                        color: Color.fromRGBO(27, 38, 44, 1),
                        fontFamily: "Oswald-Regular",
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateProfile(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double leftWidth(BuildContext context, double number) {
    return (number * MediaQuery.of(context).size.width) / 414;
  }

  double topHeight(BuildContext context, double number) {
    return (number *
            (MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.vertical)) /
        736;
  }
}
