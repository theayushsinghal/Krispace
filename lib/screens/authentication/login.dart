import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:krispace/custom_components/loading.dart';
import 'package:krispace/screens/admin/admin_home.dart';
import 'package:krispace/screens/authentication/phone_auth.dart';
import 'package:krispace/screens/authentication/register.dart';
import 'package:krispace/screens/home/home.dart';
import 'package:krispace/screens/register_profile/profile_welcome_screen.dart';

import 'forget password1.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool agree = false;
  bool obscure3 = true;
  bool isValidMail = false;
  bool loading = false;
  double opacity = 0;

  Future<User> loginUser() async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      User user = result.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<User> googlesignin() async {
    try {
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gSA.accessToken,
        idToken: gSA.idToken,
      );
      User user = (await _auth.signInWithCredential(credential)).user;
      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xff1B262C), //.fromRGBO(27, 38, 44, 1),
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.passthrough,
          children: [
            Positioned(
              left: leftWidth(context, 251),
              top: topHeight(context, -66),
              child: Opacity(
                opacity: 0.1,
                child: Container(
                  color: Colors.transparent,
                  width: leftWidth(context, 251),
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
              left: leftWidth(context, 20),
              child: Container(
                color: Colors.transparent,
                width: leftWidth(context, 365.5),
                height: topHeight(context, 403.5),
                child: Image.asset(
                  "Assets/Images/Vector1_CreateAccount.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 444.5),
              left: leftWidth(context, 15),
              child: Container(
                color: Colors.transparent,
                width: leftWidth(context, 375.5),
                height: topHeight(context, 153.5),
                child: Image.asset(
                  "Assets/Images/Vector20_Login.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 582),
              left: leftWidth(context, 296),
              child: Container(
                color: Colors.transparent,
                width: leftWidth(context, 116.5),
                height: topHeight(context, 16),
                child: Image.asset(
                  "Assets/Images/Vector17_CreateAccount.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 30),
              left: leftWidth(context, 37),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 255, 148, 1),
                  shape: BoxShape.circle,
                ),
                width: leftWidth(context, 34),
                height: topHeight(context, 34),
                child: GestureDetector(
                  child: Icon(Icons.arrow_back_rounded),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 74),
              left: leftWidth(context, 37),
              child: Container(
                width: leftWidth(context, 223),
                height: topHeight(context, 55),
                child: Text(
                  "Login Now",
                  style: TextStyle(
                    fontSize: 34.0,
                    color: Colors.white,
                    fontFamily: "Oswald-Regular",
                  ),
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 150),
              left: leftWidth(context, 37),
              child: Container(
                width: leftWidth(context, 77),
                height: topHeight(context, 24),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: "Oswald-Regular",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 246),
              left: leftWidth(context, 38),
              child: Container(
                width: leftWidth(context, 128),
                height: topHeight(context, 24),
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: "Oswald-Regular",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 185),
              left: leftWidth(context, 38),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: Color(0xff00FF94))),
                width: leftWidth(context, 328),
                height: topHeight(context, 38),
                padding: EdgeInsets.only(left: 10),
              ),
            ),
            Positioned(
              top: topHeight(context, 188),
              left: leftWidth(context, 48),
              width: leftWidth(context, 328),
              height: topHeight(context, 38),
              child: TextField(
                controller: emailController,
                onChanged: (String val) {
                  if (RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(val)) {
                    print("true");
                    setState(() {
                      opacity = 1;
                    });
                  } else {
                    print("false");
                    setState(() {
                      opacity = 0;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: "abc@gmail.com",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                //onSaved: (value) => this._email = value,
              ),
            ),
            Positioned(
              top: topHeight(context, 280),
              left: leftWidth(context, 39),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: Color(0xff00FF94))),
                width: leftWidth(context, 328),
                height: topHeight(context, 38),
                padding: EdgeInsets.only(left: 10),
                child: Center(
                  child: TextField(
                    controller: passwordController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(19),
                    ],
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 6,
                    ),
                    obscureText: obscure3,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    //onSaved: (value) => this._email = value,
                  ),
                ),
              ),
            ),
            Positioned(
              left: leftWidth(context, 341),
              top: topHeight(context, 293),
              child: InkWell(
                onTap: () {
                  setState(() {
                    obscure3 = !obscure3;
                  });
                },
                child: Container(
                  height: topHeight(context, 16),
                  width: leftWidth(context, 16),
                  child: obscure3
                      ? Icon(
                          Icons.visibility_off,
                          color: Colors.black,
                          size: 16,
                        )
                      : Icon(
                          Icons.visibility,
                          color: Colors.black,
                          size: 16,
                        ),
                ),
              ),
            ),
            Positioned(
              left: leftWidth(context, 341),
              top: topHeight(context, 196),
              child: Container(
                  alignment: Alignment.topLeft,
                  height: topHeight(context, 16),
                  width: leftWidth(context, 16),
                  child: Opacity(
                    opacity: opacity,
                    child: Icon(
                      Icons.check_sharp,
                      color: Colors.black,
                      size: 18,
                    ),
                  )),
            ),
            Positioned(
              left: leftWidth(context, 38),
              top: topHeight(context, 352),
              child: Container(
                width: leftWidth(context, 20),
                height: topHeight(context, 20),
                color: Color(0xff00FF94),
                child: Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    activeColor: Color(0xff00FF94),
                    checkColor: Colors.black,
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        agree = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 350),
              left: leftWidth(context, 69),
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  width: leftWidth(context, 294),
                  height: topHeight(context, 20),
                  child: FittedBox(
                    alignment: Alignment.bottomLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Remember me next time",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 423),
              left: leftWidth(context, 34),
              child: GestureDetector(
                onTap: () async {
                  if (emailController.text.length == 0 ||
                      passwordController.text.length == 0) {
                    final snackBar = SnackBar(
                      content: Text(
                        'Any field cannot be left empty',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 3),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                    setState(() => loading = true);
                    User user = await loginUser();
                    if (user == null) {
                      setState(() {
                        loading = false;
                      });
                      final snackBar = SnackBar(
                        content: Text(
                          'Could not sign in with current credentials',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 3),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    } else {
                      DocumentSnapshot reference = await FirebaseFirestore
                          .instance
                          .collection("Users")
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .get();
                      setState(() {
                        loading = false;
                      });
                      if (reference.data()["type"] == "Admin") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminHome(),
                          ),
                        );
                      } else if (!reference.exists) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileWelcomeScreen(),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      }
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffFFC857),
                      borderRadius: BorderRadius.circular(5)),
                  width: leftWidth(context, 346),
                  height: topHeight(context, 48),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontFamily: "Oswald-Regular",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 560),
              left: leftWidth(context, 157),
              child: Container(
                width: leftWidth(context, 100),
                height: topHeight(context, 30),
                child: Text(
                  "Login With",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: "Oswald-Regular",
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 600),
              left: leftWidth(context, 34),
              child: GestureDetector(
                onTap: () async {
                  setState(() => loading = true);
                  User user = await googlesignin();
                  if (FirebaseAuth.instance.currentUser == null) {
                    setState(() {
                      loading = false;
                    });
                  } else {
                    DocumentSnapshot reference = await FirebaseFirestore
                        .instance
                        .collection("Users")
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .get();
                    setState(() {
                      loading = false;
                    });
                    if (reference.data()["type"] == "Admin") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminHome(),
                        ),
                      );
                    } else if (!reference.exists) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileWelcomeScreen(),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff1B262C),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: Color(0xff00FF94)),
                  ),
                  width: leftWidth(context, 168),
                  height: topHeight(context, 48),
                  child: Center(
                    child: Text(
                      "Google",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xff00FF94),
                        fontFamily: "Oswald-Regular",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 600),
              left: leftWidth(context, 212),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneAuthentication(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff1B262C),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: Color(0xff00FF94)),
                  ),
                  width: leftWidth(context, 168),
                  height: topHeight(context, 48),
                  child: Center(
                    child: Text(
                      "Mobile No.",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xff00FF94),
                        fontFamily: "Oswald-Regular",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 489),
              child: Container(
                //decoration: BoxDecoration(color: Colors.orange),
                width: leftWidth(context, 160),
                height: topHeight(context, 20),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Forget Password ? ",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white70,
                        fontFamily: "Oswald-Regular",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword1()),
                        );
                      },
                      child: Text(
                        "Click Here",
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Color(0xff00FF94),
                          fontFamily: "Oswald-Regular",
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 660),
              child: Container(
                width: leftWidth(context, 307),
                height: topHeight(context, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ? ",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white70,
                        fontFamily: "Oswald-Regular",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text(
                        "Sign Up Now",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xff00FF94),
                          fontFamily: "Oswald-Regular",
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            loading
                ? Positioned(
                    top: 0,
                    left: 0,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Loading())
                : Positioned(
                    top: 0, left: 0, width: 0, height: 0, child: SizedBox()),
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
