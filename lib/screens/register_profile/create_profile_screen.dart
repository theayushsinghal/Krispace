import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krispace/custom_components/loading.dart';
import 'dart:io';
import 'package:krispace/screens/home/home.dart';
import 'package:krispace/screens/register_profile/portfolio_screen.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController useridController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> id = [];
  List<String> categories = [];
  File image;
  bool loading = false;
  final picker = ImagePicker();
  int index = 1;

  Future<bool> idExists() async {
    QuerySnapshot ref = await FirebaseFirestore.instance
        .collection("Users")
        .where("userid", isEqualTo: useridController.text)
        .get();
    if (ref.size == 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(27, 38, 44, 1),
        body: loading
            ? Center(child: Loading())
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: topHeight(context, 736),
                  child: Stack(
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
                              if (index == 2) {
                                setState(() {
                                  index = 1;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: topHeight(context, 74),
                        left: 37,
                        child: Container(
                          width: leftWidth(context, 232),
                          height: topHeight(context, 49),
                          child: Text(
                            'Create Profile',
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
                        left: leftWidth(context, 37),
                        top: topHeight(context, 143),
                        child: progressBar(),
                      ),
                      index == 1
                          ? Positioned(
                              top: topHeight(context, 196),
                              left: leftWidth(context, 37),
                              child: index1(),
                            )
                          : Positioned(
                              top: topHeight(context, 185),
                              left: leftWidth(context, 37),
                              child: index2(),
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
                              index == 1 ? 'Next' : "Create",
                              style: TextStyle(
                                  height: 1.25,
                                  fontSize: 24.0,
                                  color: Color.fromRGBO(27, 38, 44, 1),
                                  fontFamily: "Oswald-Regular",
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () async {
                              if (index == 1) {
                                if (nameController.text.isEmpty ||
                                    useridController.text.isEmpty) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Fields cannot be left empty',
                                      textAlign: TextAlign.center,
                                    ),
                                    duration: Duration(seconds: 3),
                                  );
                                  _scaffoldKey.currentState
                                      .showSnackBar(snackBar);
                                } else if (image == null) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Please upload your profile image',
                                      textAlign: TextAlign.center,
                                    ),
                                    duration: Duration(seconds: 3),
                                  );
                                  _scaffoldKey.currentState
                                      .showSnackBar(snackBar);
                                } else {
                                  bool ans = await idExists();
                                  if (ans) {
                                    final snackBar = SnackBar(
                                      content: Text(
                                        'Username already exists',
                                        textAlign: TextAlign.center,
                                      ),
                                      duration: Duration(seconds: 3),
                                    );
                                    _scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                  } else {
                                    setState(() {
                                      index = 2;
                                    });
                                  }
                                }
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                Reference firebaseStorageRef =
                                    FirebaseStorage.instance.ref().child(
                                        'users/${FirebaseAuth.instance.currentUser.uid}/${getRandString(6)}');
                                UploadTask uploadTask =
                                    firebaseStorageRef.putFile(image);
                                TaskSnapshot taskSnapshot = await uploadTask;
                                String url =
                                    await taskSnapshot.ref.getDownloadURL();
                                FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .set({
                                  'name': nameController.text,
                                  'userid': useridController.text,
                                  'bio': bioController.text,
                                  'type': "User",
                                  'state': "Pending",
                                  'Balance': 0,
                                  'Earning': 0,
                                  'UPI_id': "No UPI yet",
                                  'account_no': "No account yet",
                                  'referal_link':
                                      "krispace/" + useridController.text,
                                  'url': url,
                                  'categories': categories,
                                  'portfolio': [],
                                  'monthlysub': 0.0,
                                  'yearlysub': 0.0,
                                  'subscribers': [],
                                  'friends': [],
                                });
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PortfolioScreen(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget progressBar() {
    return Container(
      width: leftWidth(context, 226),
      height: topHeight(context, 14),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: leftWidth(context, 14),
              height: topHeight(context, 14),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(255, 200, 87, 1), width: 0.5),
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 200, 87, 1),
              ),
            ),
          ),
          Positioned(
            left: leftWidth(context, 14),
            top: topHeight(context, 5),
            child: Container(
              width: leftWidth(context, 100),
              height: topHeight(context, 4),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(255, 200, 87, 1), width: 0.5),
                color: Color.fromRGBO(255, 200, 87, 1),
              ),
            ),
          ),
          Positioned(
            right: leftWidth(context, 14),
            top: topHeight(context, 5),
            child: Container(
              width: leftWidth(context, 100),
              height: topHeight(context, 4),
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
              height: topHeight(context, 14),
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

//first page
  Widget index1() {
    return Container(
      height: topHeight(context, 350),
      width: leftWidth(context, 328),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          Positioned(
            top: topHeight(context, 1),
            child: Container(
              width: leftWidth(context, 113),
              height: topHeight(context, 24),
              child: Text(
                'Choose Avatar',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontFamily: "Oswald-Regular",
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            top: topHeight(context, 42),
            child: Container(
              width: leftWidth(context, 100),
              height: topHeight(context, 100),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(0, 255, 148, 1),
                  ),
                  color: Colors.white),
              child: image != null
                  ? Image.file(
                      image,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('Assets/Images/Profile.png'),
            ),
          ),
          Positioned(
            top: topHeight(context, 132),
            child: Container(
              width: leftWidth(context, 20),
              height: topHeight(context, 20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(27, 38, 44, 1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: leftWidth(context, 16),
                  height: topHeight(context, 16),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 200, 87, 1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: topHeight(context, 132),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              onTap: () async {
                await getImage().then((imag) {
                  setState(() {
                    image = imag;
                  });
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                width: leftWidth(context, 20),
                height: topHeight(context, 20),
                child: Center(
                    child: Icon(
                  Icons.add,
                  size: 18,
                )),
              ),
            ),
          ),
          Positioned(
            top: topHeight(context, 179),
            left: 0,
            child: Container(
              width: leftWidth(context, 77),
              height: topHeight(context, 24),
              child: Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.white,
                  fontFamily: "Oswald-Regular",
                ),
              ),
            ),
          ),
          Positioned(
            top: topHeight(context, 214),
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color.fromRGBO(0, 255, 148, 1)),
                  color: Color.fromRGBO(249, 252, 251, 1)),
              width: leftWidth(context, 328),
              height: topHeight(context, 38),
            ),
          ),
          Positioned(
            top: topHeight(context, 216),
            left: leftWidth(context, 22),
            child: Container(
              width: leftWidth(context, 280),
              height: topHeight(context, 38),
              child: TextField(
                controller: nameController,
                maxLines: 1,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter Fullname",
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
            ),
          ),
          Positioned(
            top: topHeight(context, 276),
            left: 0,
            child: Container(
              width: leftWidth(context, 77),
              height: topHeight(context, 24),
              child: Text(
                'User ID',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontFamily: "Oswald-Regular",
                ),
              ),
            ),
          ),
          Positioned(
            top: topHeight(context, 312),
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color.fromRGBO(0, 255, 148, 1)),
                  color: Color.fromRGBO(249, 252, 251, 1)),
              width: leftWidth(context, 328),
              height: topHeight(context, 38),
            ),
          ),
          Positioned(
            top: topHeight(context, 314),
            left: leftWidth(context, 22),
            child: Container(
              width: leftWidth(context, 280),
              height: topHeight(context, 38),
              child: TextField(
                controller: useridController,
                maxLines: 1,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter Username",
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
            ),
          ),
        ],
      ),
    );
  }

//second page
  Widget index2() {
    return Container(
      height: topHeight(context, 396),
      width: leftWidth(context, 329),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: leftWidth(context, 148),
              height: topHeight(context, 24),
              child: Text(
                'Choose Categories',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontFamily: "Oswald-Regular",
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Positioned(
            top: topHeight(context, 38),
            left: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  categories.contains("art")
                      ? categories.remove("art")
                      : categories.add("art");
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: categories.contains("art")
                      ? Color.fromRGBO(0, 255, 148, 1)
                      : Color.fromRGBO(255, 200, 87, 1),
                ),
                width: leftWidth(context, 329),
                height: topHeight(context, 40),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 130),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("art")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.dstATop),
                                image:
                                    AssetImage("Assets/Images/art-drawing.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 159),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("art")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.4),
                                    BlendMode.dstATop),
                                image:
                                    AssetImage("Assets/Images/art-drawing.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 188),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("art")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.dstATop),
                                image:
                                    AssetImage("Assets/Images/art-drawing.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 217),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("art")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.8),
                                    BlendMode.dstATop),
                                image:
                                    AssetImage("Assets/Images/art-drawing.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 246),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("art")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                image:
                                    AssetImage("Assets/Images/art-drawing.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 18),
                      child: Container(
                        height: topHeight(context, 40),
                        child: Center(
                          child: Text(
                            'Art and Drawing',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Oswald-Regular",
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: topHeight(context, 86),
            left: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  categories.contains("photography")
                      ? categories.remove("photography")
                      : categories.add("photography");
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: categories.contains("photography")
                      ? Color.fromRGBO(0, 255, 148, 1)
                      : Color.fromRGBO(255, 200, 87, 1),
                ),
                width: leftWidth(context, 329),
                height: topHeight(context, 40),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 130),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("photography")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.dstATop),
                                image:
                                    AssetImage("Assets/Images/photography.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 159),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("photography")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.4),
                                    BlendMode.dstATop),
                                image:
                                    AssetImage("Assets/Images/photography.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 188),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("photography")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.dstATop),
                                image:
                                    AssetImage("Assets/Images/photography.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 217),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("photography")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.8),
                                    BlendMode.dstATop),
                                image:
                                    AssetImage("Assets/Images/photography.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 246),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("photography")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                image:
                                    AssetImage("Assets/Images/photography.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 18),
                      child: Container(
                        height: topHeight(context, 40),
                        child: Center(
                          child: Text(
                            'Photography',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Oswald-Regular",
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: topHeight(context, 134),
            left: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  categories.contains("writing")
                      ? categories.remove("writing")
                      : categories.add("writing");
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: categories.contains("writing")
                      ? Color.fromRGBO(0, 255, 148, 1)
                      : Color.fromRGBO(255, 200, 87, 1),
                ),
                width: leftWidth(context, 329),
                height: topHeight(context, 40),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 130),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("writing")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.dstATop),
                                image:
                                    AssetImage("Assets/Images/writing-cat.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 159),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("writing")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.4),
                                    BlendMode.dstATop),
                                image:
                                    AssetImage("Assets/Images/writing-cat.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 188),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("writing")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.dstATop),
                                image:
                                    AssetImage("Assets/Images/writing-cat.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 217),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("writing")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.8),
                                    BlendMode.dstATop),
                                image:
                                    AssetImage("Assets/Images/writing-cat.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 246),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categories.contains("writing")
                                ? Color.fromRGBO(0, 255, 148, 1)
                                : Color.fromRGBO(255, 200, 87, 1),
                            image: DecorationImage(
                                image:
                                    AssetImage("Assets/Images/writing-cat.png"),
                                repeat: ImageRepeat.repeat)),
                        width: leftWidth(context, 83),
                        height: topHeight(context, 40),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: leftWidth(context, 18),
                      child: Container(
                        height: topHeight(context, 40),
                        child: Center(
                          child: Text(
                            'Writing',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Oswald-Regular",
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: topHeight(context, 207),
            left: 0,
            child: Container(
              width: leftWidth(context, 148),
              height: topHeight(context, 24),
              child: Text(
                'Add Bio',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontFamily: "Oswald-Regular",
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Positioned(
            top: topHeight(context, 241),
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color.fromRGBO(0, 255, 148, 1)),
                  color: Color.fromRGBO(249, 252, 251, 1)),
              width: leftWidth(context, 328),
              height: topHeight(context, 155),
            ),
          ),
          Positioned(
            top: topHeight(context, 241),
            left: leftWidth(context, 22),
            child: Container(
              width: leftWidth(context, 280),
              height: topHeight(context, 155),
              child: TextField(
                controller: bioController,
                textInputAction: TextInputAction.newline,
                maxLines: 7,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: "Add here",
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

  Future uploadImageToFirebase(BuildContext context, int index) async {
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
        'users/${FirebaseAuth.instance.currentUser.uid}/${getRandString(6)}');
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("Contests")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      "uploadurl": FieldValue.arrayUnion([url]),
    });
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  Future<File> getImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    return File(pickedImage.path);
  }
}
