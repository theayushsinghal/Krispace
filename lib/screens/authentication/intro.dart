import 'package:flutter/material.dart';
import 'package:krispace/screens/authentication/register.dart';
import 'package:krispace/screens/register_profile/profile_welcome_screen.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  int set = 1;
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
                top: 149,
              ),
              Positioned(
                top: 20,
                right: 20,
                child: InkWell(
                  child: Text(
                    "skip>>",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                child: krispaceIntro(),
                top: 28,
              ),
              Positioned(
                child: Image.asset(set == 1
                    ? "Assets/Images/community.png"
                    : set == 2
                        ? "Assets/Images/trophy.png"
                        : "Assets/Images/salarybag.png"),
                top: 198.55,
              ),
              Positioned(
                top: 495,
                child: unleashCreativity(),
              ),
              Positioned(
                bottom: 63,
                child: splashButton(context),
              ),
              set == 1
                  ? Positioned(
                      bottom: 96.6,
                      right: 136.6,
                      child: sideButton(),
                    )
                  : set == 2
                      ? Positioned(
                          bottom: 96.6, right: 136.6, child: sideButton())
                      : Positioned(
                          bottom: 96.6, left: 107, child: sideButton()),
              set == 1
                  ? Positioned(
                      bottom: 96.6,
                      right: 107,
                      child: sideButton(),
                    )
                  : set == 2
                      ? Positioned(
                          bottom: 96.6,
                          left: 135,
                          child: sideButton(),
                        )
                      : Positioned(
                          bottom: 96.6, left: 135, child: sideButton()),
            ],
          )),
    );
  }

  Widget krispaceIntro() {
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
            right: 0,
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

  Widget unleashCreativity() {
    String text1 = set == 1
        ? "Join community of "
        : set == 2
            ? "Participate in "
            : "Earn money from ";
    String text2 = set == 1
        ? "artists"
        : set == 2
            ? "contests"
            : "posts";
    return Container(
      height: 72,
      child: Center(
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 34.0,
              color: Colors.white,
              fontFamily: "Oswald-Regular",
            ),
            children: <TextSpan>[
              new TextSpan(text: text1),
              new TextSpan(
                  text: text2,
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
      height: 334,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            right: 50,
            child: Image.asset("Assets/Images/star.png"),
          ),
          Positioned(
            bottom: 0,
            left: 60,
            child: Image.asset("Assets/Images/star.png"),
          ),
          Positioned(
            top: 65,
            child: Opacity(
              opacity: 0.10,
              child: Container(
                  color: Colors.transparent,
                  width: 332,
                  height: 221,
                  child: Image.asset("Assets/Images/vector1.png")),
            ),
          ),
          Positioned(
            top: 49.55,
            child: Opacity(
              opacity: 0.10,
              child: Container(
                  color: Colors.transparent,
                  width: 332 * 1.15,
                  height: 221 * 1.15,
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
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 10,
            child: Container(
              width: 60,
              height: 60,
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
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(radius: 4, colors: [
                    Color.fromRGBO(255, 255, 255, 0.3),
                    Color.fromRGBO(255, 255, 255, 0.1),
                  ])),
              child: IconButton(
                iconSize: 35,
                icon: Icon(Icons.arrow_forward_rounded),
                onPressed: () {
                  if (set < 3) {
                    setState(() {
                      set += 1;
                    });
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sideButton() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 1.6,
          child: Container(
            width: 12.8,
            height: 12.8,
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
            width: 16,
            height: 16,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(radius: 4, colors: [
                  Color.fromRGBO(255, 255, 255, 0.3),
                  Color.fromRGBO(255, 255, 255, 0.1),
                ])),
          ),
        ),
      ],
    );
  }
}
