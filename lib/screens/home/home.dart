import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krispace/custom_components/alerts/create_profile_pop_up.dart';
import 'package:krispace/screens/home/contest/contests.dart';
import 'package:krispace/screens/home/feed/feed.dart';
import 'package:krispace/screens/home/profile/current_user_profile.dart';
import 'package:krispace/screens/home/wallet/wallet.dart';

import '../splash_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int createpost;
  File post;
  final _formKey = GlobalKey<FormState>();
  String _paid = "Paid";
  String error = "";
  TextEditingController headline = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController support = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (FirebaseAuth.instance.currentUser != null) {
        DocumentSnapshot User = await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .get();
        if (User.data()["state"] == "Rejected") {
          deletemessage(context);
        }
        if (FirebaseAuth.instance.currentUser.photoURL == null) {
          FirebaseAuth.instance.currentUser.updateProfile(
              displayName: User.data()["name"], photoURL: User.data()["url"]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FirebaseAuth.instance.currentUser == null
          ? DefaultTabController(
              length: 5,
              child: Scaffold(
                backgroundColor: Color.fromRGBO(27, 38, 44, 1),
                body: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      child: TabBarView(
                          controller: _tabController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            FeedPage(
                              user: null,
                            ),
                            Contests(),
                            Container(),
                            Wallet(
                              user: null,
                            ),
                            CurrentUserProfile(),
                          ]),
                    ),
                    Positioned(
                        top: 10,
                        child: Container(
                          width: leftWidth(context, 375),
                          height: topHeight(context, 40),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(178, 178, 178, 1),
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PopupMenuButton<String>(
                                padding: EdgeInsets.zero,
                                color: Colors.transparent,
                                offset: Offset(-20, -60),
                                icon: Icon(
                                  FontAwesomeIcons.bars,
                                  color: Colors.black,
                                ),
                                elevation: 0,
                                onSelected: (String choice) {
                                  if (choice == "logout") {
                                    if (FirebaseAuth.instance.currentUser ==
                                        null) {
                                      logincheckmessage(context);
                                    } else {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SplashScreen(),
                                        ),
                                      );
                                    }
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    "Krispace",
                                    "Notifications",
                                    "Privacy & Security",
                                    "Change Password",
                                    "Help Centre",
                                    "blank",
                                    "logout"
                                  ].map((String choice) {
                                    return PopupMenuItem<String>(
                                      value: choice,
                                      height: (choice == "blank")
                                          ? 22
                                          : choice == "Krispace"
                                              ? 53
                                              : 40,
                                      enabled: (choice == "blank" ||
                                              choice == "Krispace")
                                          ? false
                                          : true,
                                      child: (choice == "blank")
                                          ? Container(
                                              height: 22,
                                              width: 200,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 0.3),
                                                  color: Color.fromRGBO(
                                                      27, 38, 44, 1)),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    27, 38, 44, 1),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(
                                                      choice == "Krispace"
                                                          ? 20.0
                                                          : 0),
                                                  bottomRight: Radius.circular(
                                                      choice == "logout"
                                                          ? 20.0
                                                          : 0),
                                                ),
                                              ),
                                              width: 200,
                                              height: choice == "Krispace"
                                                  ? 53
                                                  : 40,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 0.3),
                                                  color: Color.fromRGBO(
                                                      27, 38, 44, 1),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight: Radius.circular(
                                                        choice == "Krispace"
                                                            ? 20.0
                                                            : 0),
                                                    bottomRight:
                                                        Radius.circular(
                                                            choice == "logout"
                                                                ? 20.0
                                                                : 0),
                                                  ),
                                                  gradient: (choice == "logout")
                                                      ? LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Color.fromRGBO(0,
                                                                255, 148, 0.5),
                                                            Color.fromRGBO(249,
                                                                252, 251, 0.25),
                                                          ],
                                                        )
                                                      : LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Color.fromRGBO(
                                                                27, 38, 44, 1),
                                                            Color.fromRGBO(
                                                                27, 38, 44, 1)
                                                          ],
                                                        ),
                                                ),
                                                width: 200,
                                                height: choice == "Krispace"
                                                    ? 53
                                                    : 40,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: choice == "Krispace"
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                              width: 100,
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Container(
                                                                    width: 30,
                                                                    height: 30,
                                                                    child: Image
                                                                        .asset(
                                                                            "Assets/Images/krispace_logo.png"),
                                                                  ),
                                                                  Text(
                                                                    choice,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Color.fromRGBO(
                                                                            249,
                                                                            252,
                                                                            251,
                                                                            1)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Icon(
                                                                  Icons.close,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          178,
                                                                          178,
                                                                          178,
                                                                          1)),
                                                            )
                                                          ],
                                                        )
                                                      : Text(
                                                          (choice == "logout" &&
                                                                  FirebaseAuth
                                                                          .instance
                                                                          .currentUser ==
                                                                      null)
                                                              ? "Login"
                                                              : choice,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[300]),
                                                        ),
                                                ),
                                              ),
                                            ),
                                    );
                                  }).toList();
                                },
                              ),
                              Text(
                                "Krispace",
                                textAlign: TextAlign.center,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Stack(
                          children: [
                            CustomPaint(
                              size: Size(MediaQuery.of(context).size.width, 60),
                              painter: CustomPaintBar(),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 60,
                              child: TabBar(
                                controller: _tabController,
                                indicator: UnderlineTabIndicator(
                                    insets:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    borderSide: BorderSide(
                                      width: 6.0,
                                      color: Color.fromRGBO(255, 200, 87, 1),
                                    )),
                                tabs: [
                                  Tab(
                                    icon: Icon(
                                      FontAwesomeIcons.home,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Tab(
                                    icon: Icon(
                                      FontAwesomeIcons.trophy,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: leftWidth(context, 40),
                                  ),
                                  Tab(
                                    icon: Icon(
                                      FontAwesomeIcons.wallet,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Tab(
                                    icon: Icon(
                                      FontAwesomeIcons.userAlt,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                                onTap: (int index) {
                                  if (FirebaseAuth.instance.currentUser ==
                                          null &&
                                      index > 0) {
                                    setState(() {
                                      _tabController.index = 0;
                                    });
                                    logincheckmessage(context);
                                  }
                                  if (index == 2) {
                                    setState(() {
                                      _tabController.index = 0;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FloatingActionButton(
                    backgroundColor: Color.fromRGBO(255, 200, 87, 1),
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 40,
                    ),
                    onPressed: () async {
                      if (FirebaseAuth.instance.currentUser == null) {
                        logincheckmessage(context);
                      } else {
                        setState(() {
                          createpost = 0;
                          _paid = "Paid";
                          headline = new TextEditingController();
                          about = new TextEditingController();
                          support = new TextEditingController();
                        });
                        _editModalBottomSheet(context);
                      }
                    },
                  ),
                ),
              ),
            )
          : StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser
                      .uid) //FirebaseAuth.instance.currentUser.uid
                  .snapshots(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator()))
                    : DefaultTabController(
                        length: 5,
                        child: Scaffold(
                          backgroundColor: Color.fromRGBO(27, 38, 44, 1),
                          body: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Positioned(
                                child: TabBarView(
                                    controller: _tabController,
                                    physics: NeverScrollableScrollPhysics(),
                                    children: [
                                      FeedPage(
                                        user: snapshot.data,
                                      ),
                                      Contests(),
                                      Container(),
                                      Wallet(
                                        user: snapshot.data,
                                      ),
                                      CurrentUserProfile(),
                                    ]),
                              ),
                              Positioned(
                                  top: 10,
                                  child: Container(
                                    width: leftWidth(context, 375),
                                    height: topHeight(context, 40),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(178, 178, 178, 1),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        PopupMenuButton<String>(
                                          padding: EdgeInsets.zero,
                                          color: Colors.transparent,
                                          offset: Offset(-20, -60),
                                          icon: Icon(
                                            FontAwesomeIcons.bars,
                                            color: Colors.black,
                                          ),
                                          elevation: 0,
                                          onSelected: (String choice) {
                                            if (choice == "logout") {
                                              if (FirebaseAuth
                                                      .instance.currentUser ==
                                                  null) {
                                                logincheckmessage(context);
                                              } else {
                                                FirebaseAuth.instance.signOut();
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SplashScreen(),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          itemBuilder: (BuildContext context) {
                                            return [
                                              "Krispace",
                                              "Notifications",
                                              "Privacy & Security",
                                              "Change Password",
                                              "Help Centre",
                                              "blank",
                                              "logout"
                                            ].map((String choice) {
                                              return PopupMenuItem<String>(
                                                value: choice,
                                                height: (choice == "blank")
                                                    ? 22
                                                    : choice == "Krispace"
                                                        ? 53
                                                        : 40,
                                                enabled: (choice == "blank" ||
                                                        choice == "Krispace")
                                                    ? false
                                                    : true,
                                                child: (choice == "blank")
                                                    ? Container(
                                                        height: 22,
                                                        width: 200,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 0.3),
                                                            color:
                                                                Color.fromRGBO(
                                                                    27,
                                                                    38,
                                                                    44,
                                                                    1)),
                                                      )
                                                    : Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              27, 38, 44, 1),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(choice ==
                                                                        "Krispace"
                                                                    ? 20.0
                                                                    : 0),
                                                            bottomRight: Radius
                                                                .circular(choice ==
                                                                        "logout"
                                                                    ? 20.0
                                                                    : 0),
                                                          ),
                                                        ),
                                                        width: 200,
                                                        height:
                                                            choice == "Krispace"
                                                                ? 53
                                                                : 40,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 0.3),
                                                            color:
                                                                Color.fromRGBO(
                                                                    27,
                                                                    38,
                                                                    44,
                                                                    1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      choice ==
                                                                              "Krispace"
                                                                          ? 20.0
                                                                          : 0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      choice ==
                                                                              "logout"
                                                                          ? 20.0
                                                                          : 0),
                                                            ),
                                                            gradient: (choice ==
                                                                    "logout")
                                                                ? LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    colors: [
                                                                      Color.fromRGBO(
                                                                          0,
                                                                          255,
                                                                          148,
                                                                          0.5),
                                                                      Color.fromRGBO(
                                                                          249,
                                                                          252,
                                                                          251,
                                                                          0.25),
                                                                    ],
                                                                  )
                                                                : LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    colors: [
                                                                      Color.fromRGBO(
                                                                          27,
                                                                          38,
                                                                          44,
                                                                          1),
                                                                      Color.fromRGBO(
                                                                          27,
                                                                          38,
                                                                          44,
                                                                          1)
                                                                    ],
                                                                  ),
                                                          ),
                                                          width: 200,
                                                          height: choice ==
                                                                  "Krispace"
                                                              ? 53
                                                              : 40,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: choice ==
                                                                    "Krispace"
                                                                ? Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            100,
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: [
                                                                            Container(
                                                                              width: 30,
                                                                              height: 30,
                                                                              child: Image.asset("Assets/Images/krispace_logo.png"),
                                                                            ),
                                                                            Text(
                                                                              choice,
                                                                              style: TextStyle(fontSize: 16, color: Color.fromRGBO(249, 252, 251, 1)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: Icon(
                                                                            Icons
                                                                                .close,
                                                                            color: Color.fromRGBO(
                                                                                178,
                                                                                178,
                                                                                178,
                                                                                1)),
                                                                      )
                                                                    ],
                                                                  )
                                                                : Text(
                                                                    (choice == "logout" &&
                                                                            FirebaseAuth.instance.currentUser ==
                                                                                null)
                                                                        ? "Login"
                                                                        : choice,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey[300]),
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                              );
                                            }).toList();
                                          },
                                        ),
                                        Text(
                                          "Krispace",
                                          textAlign: TextAlign.center,
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.search,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: Stack(
                                    children: [
                                      CustomPaint(
                                        size: Size(
                                            MediaQuery.of(context).size.width,
                                            60),
                                        painter: CustomPaintBar(),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 60,
                                        child: TabBar(
                                          controller: _tabController,
                                          indicator: UnderlineTabIndicator(
                                              insets: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              borderSide: BorderSide(
                                                width: 6.0,
                                                color: Color.fromRGBO(
                                                    255, 200, 87, 1),
                                              )),
                                          tabs: [
                                            Tab(
                                              icon: Icon(
                                                FontAwesomeIcons.home,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Tab(
                                              icon: Icon(
                                                FontAwesomeIcons.trophy,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              width: leftWidth(context, 40),
                                            ),
                                            Tab(
                                              icon: Icon(
                                                FontAwesomeIcons.wallet,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Tab(
                                              icon: Icon(
                                                FontAwesomeIcons.userAlt,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                          onTap: (int index) {
                                            if (index > 0) {
                                              if (FirebaseAuth
                                                      .instance.currentUser ==
                                                  null) {
                                                logincheckmessage(context);
                                                setState(() {
                                                  _tabController.index = 0;
                                                });
                                              } else if (snapshot.data
                                                      .data()["state"] ==
                                                  "Pending") {
                                                statecheckmessage(context);
                                                setState(() {
                                                  _tabController.index = 0;
                                                });
                                              }
                                            }
                                            if (index == 2) {
                                              setState(() {
                                                _tabController.index = 0;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          floatingActionButtonLocation:
                              FloatingActionButtonLocation.centerFloat,
                          floatingActionButton: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: FloatingActionButton(
                              backgroundColor: Color.fromRGBO(255, 200, 87, 1),
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 40,
                              ),
                              onPressed: () async {
                                if (FirebaseAuth.instance.currentUser == null) {
                                  logincheckmessage(context);
                                } else {
                                  if (snapshot.data.data()["state"] ==
                                      "Pending") {
                                    statecheckmessage(context);
                                  } else {
                                    setState(() {
                                      createpost = 0;
                                      _paid = "Paid";
                                      headline = new TextEditingController();
                                      about = new TextEditingController();
                                      support = new TextEditingController();
                                    });
                                    _editModalBottomSheet(context);
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      );
              }),
    );
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void _editModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return CustomPaint(
              size: MediaQuery.of(context).size,
              painter: CustomPaintPopUp(),
              child: SingleChildScrollView(
                child: createpost == 0
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 270,
                        child: Column(
                          children: [
                            FloatingActionButton(
                              backgroundColor: Color.fromRGBO(0, 255, 148, 1),
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.black,
                                size: 32,
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(height: 28),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Choose content",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final pickedFile = await ImagePicker()
                                          .getImage(source: ImageSource.camera);

                                      setState(() {
                                        if (pickedFile != null) {
                                          post = File(pickedFile.path);
                                        } else {
                                          print('No image selected.');
                                        }
                                      });
                                      setState(() {
                                        createpost = 1;
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color.fromRGBO(
                                              255, 200, 87, 0.5)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.camera_enhance_rounded,
                                            size: 40,
                                          ),
                                          Text(
                                            "Camera",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final pickedFile = await ImagePicker()
                                          .getImage(
                                              source: ImageSource.gallery);

                                      setState(() {
                                        if (pickedFile != null) {
                                          post = File(pickedFile.path);
                                        } else {
                                          print('No image selected.');
                                        }
                                      });
                                      setState(() {
                                        createpost = 1;
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color.fromRGBO(
                                              255, 200, 87, 0.5)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.photo_library_outlined,
                                            size: 40,
                                          ),
                                          Text(
                                            "Gallery",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.vertical -
                            50,
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              FloatingActionButton(
                                backgroundColor: Color.fromRGBO(0, 255, 148, 1),
                                child: Icon(
                                  Icons.close_rounded,
                                  color: Colors.black,
                                  size: 32,
                                ),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                              ),
                              SizedBox(
                                height: 12.5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Text(
                                  "Create Post",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(27, 38, 44, 1)),
                                ),
                              ),
                              SizedBox(
                                height: 19,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(255, 200, 87, 0.5),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      width: 100,
                                      height: 100,
                                      child: post == null
                                          ? Icon(
                                              Icons.add_circle_outline_rounded,
                                              size: 44,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.5),
                                            )
                                          : Image.file(
                                              post,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 21,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Text(
                                  "Headline",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(27, 38, 44, 1)),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 30,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(width: 0.5)),
                                child: TextFormField(
                                  controller: headline,
                                  validator: (String val) {
                                    if (val.length == 0) {
                                      setState(() {
                                        error = "Headline cannot be left empty";
                                      });
                                    } else {
                                      setState(() {
                                        error = "";
                                      });
                                    }
                                    return null;
                                  },
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  decoration: new InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Text(
                                  "Post Caption",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(27, 38, 44, 1)),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 148,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(width: 0.5)),
                                child: TextFormField(
                                  controller: about,
                                  validator: (String val) {
                                    if (val.length == 0) {
                                      setState(() {
                                        error =
                                            "Description cannot be left empty";
                                      });
                                    } else if (error.length == 0) {
                                      setState(() {
                                        error = "";
                                      });
                                    }
                                    return null;
                                  },
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 9,
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Text(
                                  "Supported Tags",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(27, 38, 44, 1)),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(width: 0.5)),
                                child: TextFormField(
                                  controller: support,
                                  validator: (String val) {
                                    if (val.length == 0) {
                                      setState(() {
                                        error = "Tags cannot be left empty";
                                      });
                                    } else {
                                      setState(() {
                                        error = "";
                                      });
                                    }
                                    return null;
                                  },
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 2,
                                  decoration: new InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 17,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      hoverColor: Colors.black,
                                      activeColor: Colors.black,
                                      value: "Paid",
                                      groupValue: _paid,
                                      onChanged: (value) {
                                        setState(() {
                                          _paid = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Paid",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(27, 38, 44, 1)),
                                    ),
                                    Radio<String>(
                                      hoverColor: Colors.black,
                                      activeColor: Colors.black,
                                      value: "Free",
                                      groupValue: _paid,
                                      onChanged: (value) {
                                        setState(() {
                                          _paid = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Free",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(27, 38, 44, 1)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 17,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (_formKey.currentState.validate() &&
                                      error.length == 0) {
                                    DocumentReference docref = FirebaseFirestore
                                        .instance
                                        .collection("Posts")
                                        .doc();
                                    DocumentSnapshot user =
                                        await FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(FirebaseAuth
                                                .instance.currentUser.uid)
                                            .get();
                                    Reference firebaseStorageRef =
                                        FirebaseStorage.instance.ref().child(
                                            'users/${FirebaseAuth.instance.currentUser.uid}/posts/${getRandString(6)}');
                                    UploadTask uploadTask =
                                        firebaseStorageRef.putFile(post);
                                    TaskSnapshot taskSnapshot =
                                        await uploadTask;
                                    String url =
                                        await taskSnapshot.ref.getDownloadURL();
                                    await docref.set({
                                      "headline": headline.text,
                                      "description": about.text,
                                      "tags": support.text,
                                      "paid": _paid == "Paid",
                                      "dateTime": DateTime.now(),
                                      "postId": docref.id,
                                      "ownerId":
                                          FirebaseAuth.instance.currentUser.uid,
                                      "comments": 0,
                                      "username": user.data()["userid"],
                                      "feedurl": url,
                                      "profileurl": FirebaseAuth
                                          .instance.currentUser.photoURL,
                                      "likes": []
                                    });
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 48,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color.fromRGBO(255, 200, 87, 1)),
                                  child: Center(
                                    child: Text(
                                      "Post",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Oswald-Regular",
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Center(
                                  child: Text(
                                    error,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
              ),
            );
          });
        });
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

  void statecheckmessage(BuildContext context) async {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.transparent, //Color(0xff1B262C),
              contentPadding: EdgeInsets.zero,
              content: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff1B262C),
                      border: Border.all(
                        width: 3,
                        color: Color(0xff00FF94),
                      )),
                  height: MediaQuery.of(context).size.width * 4 / 5 + 100,
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: 135,
                        height: 135,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("Assets/Images/Group 113.png"),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Thank You",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Oswald-Regular",
                            color: Color.fromRGBO(255, 200, 87, 1)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Please wait till your profile is reviewed. It will become live as soon as it is approved from our end. Till then you can explore other posts.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(0, 255, 148, 1),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 200, 87, 1),
                            borderRadius: BorderRadius.circular(5)),
                        width: leftWidth(context, 306),
                        height: topHeight(context, 40),
                        child: TextButton(
                          child: Text(
                            "Explore other Posts",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromRGBO(27, 38, 44, 1),
                                fontFamily: "Oswald-Regular",
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  )),
            ),
          );
          ;
        });
  }

  void deletemessage(BuildContext context) async {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.transparent, //Color(0xff1B262C),
              contentPadding: EdgeInsets.zero,
              content: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff1B262C),
                      border: Border.all(
                        width: 3,
                        color: Color(0xff00FF94),
                      )),
                  height: MediaQuery.of(context).size.width * 4 / 5 + 100,
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: 135,
                        height: 135,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("Assets/Images/Group 113.png"),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Thank You",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Oswald-Regular",
                            color: Color.fromRGBO(255, 200, 87, 1)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Please wait till your profile is reviewed. It will become live as soon as it is approved from our end. Till then you can explore other posts.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(0, 255, 148, 1),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 200, 87, 1),
                            borderRadius: BorderRadius.circular(5)),
                        width: leftWidth(context, 306),
                        height: topHeight(context, 40),
                        child: TextButton(
                          child: Text(
                            "Explore other Posts",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromRGBO(27, 38, 44, 1),
                                fontFamily: "Oswald-Regular",
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  )),
            ),
          );
          ;
        });
  }

  void logincheckmessage(BuildContext context) async {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CreateProfilePopup();
        });
  }
}

class CustomPaintBar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..color = Colors.white
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, convertRadiusToSigma(8));
    //starting point
    Path path1 = Path()..moveTo(0, 20);
    //building the around points
    path1.quadraticBezierTo(0, 0, 20, 0);
    path1.lineTo(size.width * 0.42, 0);
    path1.arcToPoint(Offset(size.width * 0.58, 0),
        radius: Radius.circular(10), clockwise: false);
    path1.lineTo(size.width - 20, 0);
    path1.quadraticBezierTo(size.width, 0, size.width, 20);
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();

    Paint paint2 = Paint()
      ..color = Color.fromRGBO(255, 200, 87, 1)
      ..style = PaintingStyle.fill;
    Path path2 = Path()..moveTo(0, 20);
    //building the around points
    path2.quadraticBezierTo(0, 0, 20, 0);
    path2.lineTo(size.width * 0.42, 0);
    path2.arcToPoint(Offset(size.width * 0.58, 0),
        radius: Radius.circular(10), clockwise: false);
    path2.lineTo(size.width - 20, 0);
    path2.quadraticBezierTo(size.width, 0, size.width, 20);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path1, paint1);
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomPaintPopUp extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..color = Colors.white
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, convertRadiusToSigma(8));
    //starting point
    Path path1 = Path()..moveTo(2, 45);
    //building the around points
    path1.quadraticBezierTo(1, 35, 20, 30);
    path1.lineTo(size.width * 0.42 - 3, 30);
    path1.arcToPoint(Offset(size.width * 0.58 + 3, 30),
        radius: Radius.circular(10), clockwise: false);
    path1.lineTo(size.width - 20, 30);
    path1.quadraticBezierTo(size.width - 1, 35, size.width - 2, 30);
    path1.lineTo(size.width - 2, size.height - 1);
    path1.lineTo(2, size.height - 1);
    path1.close();

    Paint paint2 = Paint()
      ..color = Color.fromRGBO(0, 255, 148, 1)
      ..style = PaintingStyle.fill;
    Path path2 = Path()..moveTo(0, 45);
    //building the around points
    path2.quadraticBezierTo(1, 28, 20, 28);
    path2.lineTo(size.width * 0.42, 28);
    path2.arcToPoint(Offset(size.width * 0.58, 28),
        radius: Radius.circular(10), clockwise: false);
    path2.lineTo(size.width - 20, 28);
    path2.quadraticBezierTo(size.width - 1, 28, size.width, 45);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path1, paint1);
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
