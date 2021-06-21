import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krispace/screens/admin/admin_home.dart';
import 'package:krispace/screens/register_profile/create_profile_screen.dart';
import 'package:krispace/screens/register_profile/portfolio_screen.dart';
import 'package:krispace/screens/register_profile/profile_welcome_screen.dart';
import 'home/home.dart';

class SplashScreen extends StatelessWidget {
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
                child: centerBackground(context),
                top: topHeight(context, 149),
              ),
              Positioned(
                child: krispaceIntro(context),
                top: topHeight(context, 28),
              ),
              Positioned(
                child: fourBlock(context),
                top: topHeight(context, 198.55),
              ),
              Positioned(
                top: topHeight(context, 495),
                child: unleashCreativity(context),
              ),
              Positioned(
                top: topHeight(context, 570),
                child: splashButton(context),
              ),
            ],
          )),
    );
  }

  Widget krispaceIntro(BuildContext context) {
    return Container(
      width: 201,
      height: 79,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset("Assets/Images/krispace_logo.png"),
          ),
          Positioned(
            left: 77,
            bottom: 0,
            child: Container(
              width: 129,
              height: 72,
              child: Center(
                child: Text(
                  'Krispace',
                  style: TextStyle(
                    fontSize: 36.0,
                    color: Colors.white,
                    fontFamily: "Oswald-Regular",
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget fourBlock(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 200,
      height: 200,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Table(
          border: TableBorder.symmetric(
              inside: BorderSide(color: Colors.white, width: 3)),
          children: <TableRow>[
            TableRow(children: [
              TableCell(
                child: Container(
                  margin: EdgeInsets.all(17),
                  width: 64,
                  height: 64,
                  child: Image.asset("Assets/Images/camera.png"),
                ),
              ),
              TableCell(
                child: Container(
                  margin: EdgeInsets.all(17),
                  width: 64,
                  height: 64,
                  child: Image.asset("Assets/Images/drama.png"),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  margin: EdgeInsets.all(17),
                  width: 64,
                  height: 64,
                  child: Image.asset("Assets/Images/writing.png"),
                ),
              ),
              TableCell(
                child: Container(
                  margin: EdgeInsets.all(17),
                  width: 64,
                  height: 64,
                  child: Image.asset("Assets/Images/color-palette.png"),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget unleashCreativity(BuildContext context) {
    return Container(
      width: leftWidth(context, 308),
      height: topHeight(context, 72),
      child: Center(
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 34.0,
              color: Colors.white,
              fontFamily: "Oswald-Regular",
            ),
            children: <TextSpan>[
              new TextSpan(text: 'Unleash your '),
              new TextSpan(
                  text: 'creativity',
                  style: new TextStyle(color: Color.fromRGBO(0, 255, 149, 1))),
            ],
          ),
        ),
      ),
    );
  }

  Widget centerBackground(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: topHeight(context, 334),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: topHeight(context, 0),
            left: MediaQuery.of(context).size.width - leftWidth(context, 99.45),
            child: Image.asset("Assets/Images/star.png"),
          ),
          Positioned(
            bottom: 0,
            left: leftWidth(context, 60),
            child: Image.asset("Assets/Images/star.png"),
          ),
          Positioned(
            top: topHeight(context, 65),
            child: Opacity(
              opacity: 0.10,
              child: Container(
                  color: Colors.transparent,
                  width: leftWidth(context, 332),
                  height: topHeight(context, 221),
                  child: Image.asset("Assets/Images/vector1.png")),
            ),
          ),
          Positioned(
            top: topHeight(context, 49.55),
            child: Opacity(
              opacity: 0.10,
              child: Container(
                  color: Colors.transparent,
                  width: leftWidth(context, 332 * 1.15),
                  height: topHeight(context, 221 * 1.15),
                  child: Image.asset(
                    "Assets/Images/vector1.png",
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget splashButton(BuildContext context) {
    return Container(
      width: leftWidth(context, 80),
      height: topHeight(context, 80),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: topHeight(context, 10),
            child: Container(
              width: leftWidth(context, 60),
              height: topHeight(context, 60),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(radius: 1, colors: [
                    Color.fromRGBO(255, 180, 60, 1),
                    Color.fromRGBO(255, 200, 87, 0.7),
                  ])),
            ),
          ),
          Positioned(
            child: Container(
              width: leftWidth(context, 80),
              height: topHeight(context, 80),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(radius: 4, colors: [
                    Color.fromRGBO(255, 255, 255, 0.3),
                    Color.fromRGBO(255, 255, 255, 0.1),
                  ])),
              child: IconButton(
                iconSize: 35,
                icon: Icon(Icons.arrow_forward_rounded),
                onPressed: () async {
                  if (FirebaseAuth.instance.currentUser == null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  } else {
                    DocumentSnapshot ref = await FirebaseFirestore.instance
                        .collection("Users")
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .get();
                    if (ref.exists) {
                      if (ref.data()["type"] == "Admin") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminHome(),
                          ),
                        );
                      } else {
                        print(FirebaseAuth.instance.currentUser.uid);
                        if (ref.data()["portfolio"].length != 0) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PortfolioScreen(),
                            ),
                          );
                        }
                      }
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileWelcomeScreen(),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
        ],
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
