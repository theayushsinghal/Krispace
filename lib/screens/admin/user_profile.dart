import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:krispace/custom_components/loading.dart';
import 'package:krispace/models/feed_model.dart';
import 'package:krispace/models/user.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  UserModel userModel;
  Profile({this.userModel});
  @override
  _ProfileState createState() => _ProfileState(userModel: userModel);
}

class _ProfileState extends State<Profile> {
  UserModel userModel;
  List _postsurl = [];
  bool _loadingPosts = true;

  DocumentSnapshot snapshot;
  _ProfileState({this.userModel});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _getPosts();
    });
  }

  _getPosts() async {
    DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(userModel.documentid)
        .get();
    _postsurl = querySnapshot.data()["portfolio"];
    if (this.mounted)
      setState(() {
        _loadingPosts = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(27, 38, 44, 1),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: DefaultTabController(
            length: 3,
            child: Stack(alignment: AlignmentDirectional.topCenter, children: [
              Positioned(
                left: 20,
                top: 10,
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "User Id : ${userModel.documentid}",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromRGBO(249, 252, 251, 1),
                          fontFamily: "Oswald-Regular",
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 35,
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Krispace Profile",
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Color.fromRGBO(249, 252, 251, 1),
                            fontFamily: "Oswald-Regular",
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        contentPadding: EdgeInsets.zero,
                                        content: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(27, 38, 44, 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Color.fromRGBO(
                                                    0, 255, 148, 1),
                                              )),
                                          child: Stack(children: [
                                            Column(children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    'Accept/Reject Account.',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'Arial-Regular'),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    'Once decision is made it connot be undone',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontFamily:
                                                            'Arial-Regular'),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .doc(userModel
                                                                .documentid)
                                                            .update({
                                                          "state": "Approved"
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xff1B262C),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                            width: 2,
                                                            color: Color(
                                                                0xffFFC857),
                                                          ),
                                                        ),
                                                        width: 90,
                                                        height: 60,
                                                        child: Center(
                                                          child: Text(
                                                            "Accept",
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Color(
                                                                  0xffFFC857),
                                                              fontFamily:
                                                                  "Arial-normal",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .doc(userModel
                                                                .documentid)
                                                            .update({
                                                          "state": "Rejected"
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xff1B262C),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                            width: 2,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        width: 90,
                                                        height: 60,
                                                        child: Center(
                                                          child: Text(
                                                            "Reject",
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors.red,
                                                              fontFamily:
                                                                  "Arial-normal",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ]),
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Icon(
                                                  Icons.cancel,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ]),
                                        )));
                              });
                        },
                        child: userModel.state == "Pending"
                            ? Container(
                                width: 56,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                      color: Color.fromRGBO(0, 255, 148, 1),
                                      width: 0.5),
                                ),
                                child: Center(
                                  child: Text(
                                    "Pending",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Color.fromRGBO(0, 255, 148, 0.8),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 20,
                                width: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                      color: Color.fromRGBO(178, 178, 178, 1),
                                      width: 0.5),
                                ),
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      "Approved",
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Color.fromRGBO(178, 178, 178, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 90,
                child: Container(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).viewPadding.vertical -
                      90,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: Color.fromRGBO(249, 252, 251, 1), width: 0.4),
                    ),
                  ),
                  child: _loadingPosts
                      ? Loading()
                      : _postsurl.length == 0
                          ? Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 137,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color:
                                              Color.fromRGBO(249, 252, 251, 1),
                                          width: 0.4),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: topHeight(context, 20),
                                        left: leftWidth(context, 23),
                                        child: Container(
                                          width: 96,
                                          height: 96,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color.fromRGBO(
                                                    0, 255, 148, 0.25),
                                                Color.fromRGBO(
                                                    255, 255, 255, 0.05),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: topHeight(context, 31),
                                          left: leftWidth(context, 34),
                                          child: Container(
                                            width: 74,
                                            height: 74,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      userModel.photourl),
                                                  fit: BoxFit.cover,
                                                ),
                                                color: Colors.transparent,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Color.fromRGBO(
                                                        0, 255, 148, 1),
                                                    width: 1.5)),
                                          )),
                                      Positioned(
                                        top: topHeight(context, 18),
                                        left: leftWidth(context, 140),
                                        child: Text(
                                          userModel.profileName,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Color.fromRGBO(
                                                249, 252, 251, 1),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: topHeight(context, 44),
                                        left: leftWidth(context, 140),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person_outline_sharp,
                                              size: 16,
                                              color: Color.fromRGBO(
                                                  255, 200, 87, 1),
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              userModel.username,
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Color.fromRGBO(
                                                    255, 200, 87, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: topHeight(context, 74),
                                        left: leftWidth(context, 140),
                                        child: Text(
                                          userModel.bio,
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: Color.fromRGBO(
                                                178, 178, 178, 1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                Container(
                                  child: Text(
                                    "No Portfolio images uploaded",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          : SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 137,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Color.fromRGBO(
                                                249, 252, 251, 1),
                                            width: 0.4),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: topHeight(context, 20),
                                          left: leftWidth(context, 23),
                                          child: Container(
                                            width: 96,
                                            height: 96,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color.fromRGBO(
                                                      0, 255, 148, 0.25),
                                                  Color.fromRGBO(
                                                      255, 255, 255, 0.05),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: topHeight(context, 31),
                                            left: leftWidth(context, 34),
                                            child: Container(
                                              width: 74,
                                              height: 74,
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Color.fromRGBO(
                                                          0, 255, 148, 1),
                                                      width: 1.5),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          userModel.photourl))),
                                            )),
                                        Positioned(
                                          top: topHeight(context, 18),
                                          left: leftWidth(context, 140),
                                          child: Text(
                                            userModel.profileName,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Color.fromRGBO(
                                                  249, 252, 251, 1),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: topHeight(context, 44),
                                          left: leftWidth(context, 140),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person_outline_sharp,
                                                size: 16,
                                                color: Color.fromRGBO(
                                                    255, 200, 87, 1),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                userModel.username,
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Color.fromRGBO(
                                                      255, 200, 87, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: topHeight(context, 74),
                                          left: leftWidth(context, 140),
                                          child: Text(
                                            userModel.bio,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color.fromRGBO(
                                                  178, 178, 178, 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Portfolio",
                                    style: TextStyle(
                                      fontSize: 34.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Oswald-Regular",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Wrap(
                                    spacing: 18,
                                    runSpacing: 18,
                                    children: _postsurl.map((data) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1 /
                                                4,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1 /
                                                4,
                                        child: Image.network(
                                          data,
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                ),
              ),
            ]),
          ),
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
