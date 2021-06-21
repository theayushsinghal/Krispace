import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:krispace/custom_components/loading.dart';
import 'package:krispace/screens/authentication/phone_auth.dart';
import 'package:krispace/screens/home/home.dart';
import 'package:krispace/screens/register_profile/profile_welcome_screen.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController repasswordController = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  int index = 1;
  double opacity = 0;
  bool agree = false;
  bool obscure1 = true;
  bool obscure2 = true;
  bool isSamePass = false;
  bool loading = false;

  Future<User> registerUser() async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      User user = result.user;
      return user;
    } catch (e) {
      print(e);
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
                width: leftWidth(context, 374),
                height: topHeight(context, 448.5),
                child: Image.asset(
                  "Assets/Images/Vector1_CreateAccount.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 492),
              left: leftWidth(context, 23.5),
              child: Container(
                color: Colors.transparent,
                width: leftWidth(context, 375.5),
                height: topHeight(context, 107),
                child: Image.asset(
                  "Assets/Images/Vector9_CreateAccount.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 584),
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
              top: topHeight(context, 33),
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
                    if (index == 1)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    else
                      setState(() {
                        index = 1;
                      });
                  },
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 74),
              left: leftWidth(context, 37),
              child: Container(
                width: leftWidth(context, 236),
                height: topHeight(context, 49),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 34.0,
                      color: Colors.white,
                      fontFamily: "Oswald-Regular",
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: leftWidth(context, 37),
              top: topHeight(context, 143),
              child: progressBar(),
            ),
            Positioned(
              top: topHeight(context, 188),
              left: leftWidth(context, index == 1 ? 37 : 27),
              child: index == 1 ? Index1() : Index2(),
            ),
            Positioned(
              top: topHeight(context, 467),
              left: leftWidth(context, 34),
              child: GestureDetector(
                onTap: () async {
                  if (index == 1) {
                    if (opacity != 1) {
                      final snackBar = SnackBar(
                        content: Text(
                          emailController.text.length == 0
                              ? 'Email needed to continue.'
                              : 'Provided Email does not exist',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 3),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    } else {
                      setState(() {
                        index = 2;
                      });
                    }
                  } else {
                    if (passwordController.text.length == 0 ||
                        repasswordController.text.length == 0) {
                      final snackBar = SnackBar(
                        content: Text(
                          'Any field cannot be left empty',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 3),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    } else if (passwordController.text !=
                        repasswordController.text) {
                      final snackBar = SnackBar(
                        content: Text(
                          'Password Does not match',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 3),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    } else if (passwordController.text.length < 8) {
                      final snackBar = SnackBar(
                        content: Text(
                          'Password cannot be less than 8 characters',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 3),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    } else if (!agree) {
                      final snackBar = SnackBar(
                        content: Text(
                          'read and agree to terms and conditions to continue',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 3),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    } else {
                      setState(() {
                        loading = true;
                      });
                      User user = await registerUser();
                      if (FirebaseAuth.instance.currentUser == null) {
                        setState(() {
                          loading = false;
                          final snackBar = SnackBar(
                            content: Text(
                              'Could not Sign Up.',
                              textAlign: TextAlign.center,
                            ),
                            duration: Duration(seconds: 3),
                          );
                          _scaffoldKey.currentState.showSnackBar(snackBar);
                        });
                      } else {
                        setState(() {
                          loading = false;
                        });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileWelcomeScreen(),
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
                      index == 1 ? "Next" : "Create",
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
                height: topHeight(context, 24),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Sign Up With",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontFamily: "Oswald-Regular",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
                    if (!reference.exists) {
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
              top: topHeight(context, 660),
              child: Container(
                width: leftWidth(context, 307),
                height: topHeight(context, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ? ",
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
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        "Login Now",
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

  Widget progressBar() {
    return Container(
      width: leftWidth(context, 226),
      height: 14,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: leftWidth(context, 14),
              height: 14,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(255, 200, 87, 1), width: 0.5),
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 200, 87, 1),
              ),
            ),
          ),
          Positioned(
            left: 14,
            top: 5,
            child: Container(
              width: leftWidth(context, 100),
              height: 4,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(255, 200, 87, 1), width: 0.5),
                color: Color.fromRGBO(255, 200, 87, 1),
              ),
            ),
          ),
          Positioned(
            right: 14,
            top: 5,
            child: Container(
              width: leftWidth(context, 100),
              height: 4,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(255, 200, 87, 1), width: 0.5),
                color: index == 1
                    ? Color.fromRGBO(27, 38, 44, 1)
                    : Color.fromRGBO(255, 200, 87, 1),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: leftWidth(context, 14),
              height: 14,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(255, 200, 87, 1), width: 0.5),
                shape: BoxShape.circle,
                color: index == 1
                    ? Color.fromRGBO(27, 38, 44, 1)
                    : Color.fromRGBO(255, 200, 87, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Index1() {
    return Container(
      height: leftWidth(context, 255),
      width: leftWidth(context, 328),
      child: Stack(
        children: [
          Positioned(
            top: topHeight(context, 0),
            left: 0,
            child: Container(
              width: leftWidth(context, 77),
              height: topHeight(context, 24),
              child: Text(
                "Email ID",
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
            top: topHeight(context, 36),
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: Color(0xff00FF94))),
              width: leftWidth(context, 328),
              height: topHeight(context, 38),
            ),
          ),
          Positioned(
            top: topHeight(context, 38),
            left: leftWidth(context, 16),
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
            ),
          ),
          Positioned(
            left: leftWidth(context, 300),
            top: topHeight(context, 44),
            child: Container(
                alignment: Alignment.topLeft,
                height: topHeight(context, 16),
                width: leftWidth(context, 16),
                child: Opacity(
                  opacity: opacity,
                  child: Icon(
                    Icons.check_sharp,
                    color: Colors.black,
                    size: 20,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget Index2() {
    return Container(
      height: topHeight(context, 255),
      width: leftWidth(context, 348),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: leftWidth(context, 10),
            child: Container(
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
            top: topHeight(context, 96),
            left: leftWidth(context, 10),
            child: Container(
              height: topHeight(context, 24),
              child: Text(
                "Confirm Password",
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
            top: topHeight(context, 34),
            left: leftWidth(context, 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: Color(0xff00FF94))),
              width: leftWidth(context, 328),
              height: topHeight(context, 38),
              padding: EdgeInsets.only(left: leftWidth(context, 10)),
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
                  obscureText: obscure1,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  //onSaved: (value) => this._email = value,
                ),
              ),
            ),
          ),
          Positioned(
            top: topHeight(context, 130),
            left: leftWidth(context, 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: Color(0xff00FF94))),
              width: leftWidth(context, 328),
              height: topHeight(context, 38),
              padding: EdgeInsets.only(left: leftWidth(context, 10)),
              child: Center(
                child: TextField(
                  controller: repasswordController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(19),
                  ],
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 6,
                  ),
                  obscureText: obscure2,
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
            top: topHeight(context, 200),
            left: leftWidth(context, 42),
            child: Container(
              //decoration: BoxDecoration(color: Colors.orange),
              width: leftWidth(context, 296),
              height: topHeight(context, 20),

              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "I agree to the ",
                    style: TextStyle(
                      wordSpacing: .1,
                      fontSize: 11.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Color(0xff00FF94),
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    " and ",
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Private Policy",
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Color(0xff00FF94),
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
            left: leftWidth(context, 10),
            top: topHeight(context, 200),
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
