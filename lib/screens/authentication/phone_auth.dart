import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krispace/custom_components/pin_entry.dart';
import 'package:krispace/screens/home/home.dart';
import 'package:krispace/screens/register_profile/profile_welcome_screen.dart';

class PhoneAuthentication extends StatefulWidget {
  @override
  _PhoneAuthenticationState createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  TextEditingController phoneController = TextEditingController();
  String Verificationid = '';
  String pin = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
              top: topHeight(context, 23),
              left: leftWidth(context, 33),
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
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 74),
              left: leftWidth(context, 37),
              child: Container(
                height: topHeight(context, 49),
                child: Text(
                  'Phone Authentication',
                  style: TextStyle(
                    fontSize: 34.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Oswald-Regular",
                  ),
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 188),
              left: leftWidth(context, 37),
              child: Text(
                'Phone No.',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Oswald-Regular",
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 222),
              left: leftWidth(context, 38),
              width: leftWidth(context, 328),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: Color.fromRGBO(0, 255, 148, 1)),
                        color: Color.fromRGBO(249, 252, 251, 1)),
                    width: leftWidth(context, 50),
                    height: topHeight(context, 38),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          width: leftWidth(context, 30),
                          top: topHeight(context, 1),
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "+91",
                              isDense: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "-",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Oswald-Regular",
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: Color.fromRGBO(0, 255, 148, 1)),
                        color: Color.fromRGBO(249, 252, 251, 1)),
                    width: leftWidth(context, 200),
                    height: topHeight(context, 38),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          width: leftWidth(context, 180),
                          top: 0,
                          child: TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                              isDense: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: "+91" + phoneController.text,
                        verificationCompleted:
                            (PhoneAuthCredential credential) async {
                          await FirebaseAuth.instance
                              .signInWithCredential(credential);
                          if (FirebaseAuth.instance.currentUser != null) {
                            DocumentSnapshot reference = await FirebaseFirestore
                                .instance
                                .collection("Users")
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .get();
                            if (reference.exists) {
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),
                              );
                            } else {
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileWelcomeScreen(),
                                ),
                              );
                            }
                          } else {
                            final snackBar = SnackBar(
                              content: Text(
                                'Verify your phone number to continue',
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 3),
                            );
                            _scaffoldKey.currentState.showSnackBar(snackBar);
                          }
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          if (e.code == 'invalid-phone-number') {
                            final snackBar = SnackBar(
                              content: Text(
                                'Invalid Phone Number, please check and try again',
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 3),
                            );
                            _scaffoldKey.currentState.showSnackBar(snackBar);
                          }
                        },
                        codeSent:
                            (String verificationId, int resendToken) async {
                          setState(() {
                            Verificationid = verificationId;
                          });
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationId, smsCode: pin);
                          await FirebaseAuth.instance
                              .signInWithCredential(credential);
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          setState(() {
                            Verificationid = verificationId;
                          });
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Color.fromRGBO(255, 200, 87, 1)),
                          color: Color.fromRGBO(255, 200, 87, 1)),
                      width: leftWidth(context, 50),
                      height: topHeight(context, 38),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: topHeight(context, 320),
              left: leftWidth(context, 37),
              child: Text(
                'OTP',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Oswald-Regular",
                ),
              ),
            ),
            Positioned(
              top: topHeight(context, 354),
              left: leftWidth(context, 38),
              width: 328,
              height: topHeight(context, 38),
              child: PinEntryTextField(
                onSubmit: (String pinp) async {
                  setState(() {
                    pin = pinp;
                  });
                  try {
                    final AuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: Verificationid,
                      smsCode: pin,
                    );

                    await FirebaseAuth.instance
                        .signInWithCredential(credential);
                    final snackBar = SnackBar(
                      content: Text(
                        'Successfully signed in',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 3),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  } catch (e) {
                    final snackBar = SnackBar(
                      content: Text(
                        'Failed to sign in',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 3),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  }
                },
                fields: 6,
                isTextObscure: true,
                fontSize: 18.0,
                showFieldAsBox: true,
              ),
            ),
            Positioned(
              top: topHeight(context, 641.5),
              left: leftWidth(context, 2),
              child: Container(
                color: Colors.transparent,
                width: 388,
                height: topHeight(context, 83.5),
                child: Image.asset(
                  "Assets/Images/Vector 2.png",
                  fit: BoxFit.fill,
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
                    "Verify Now",
                    style: TextStyle(
                        height: 1.25,
                        fontSize: 24.0,
                        color: Color.fromRGBO(27, 38, 44, 1),
                        fontFamily: "Oswald-Regular",
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () async {
                    try {
                      final AuthCredential credential =
                          PhoneAuthProvider.credential(
                        verificationId: Verificationid,
                        smsCode: pin,
                      );

                      await FirebaseAuth.instance
                          .signInWithCredential(credential);
                      final snackBar = SnackBar(
                        content: Text(
                          'Successfully signed in',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 3),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    } catch (e) {
                      final snackBar = SnackBar(
                        content: Text(
                          'Failed to sign in',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 3),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    }

                    if (FirebaseAuth.instance.currentUser != null) {
                      DocumentSnapshot reference = await FirebaseFirestore
                          .instance
                          .collection("Users")
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .get();
                      if (reference.exists) {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      } else
                        Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileWelcomeScreen(),
                        ),
                      );
                    } else {
                      final snackBar = SnackBar(
                        content: Text(
                          'Verify your phone number to continue',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 3),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    }
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
