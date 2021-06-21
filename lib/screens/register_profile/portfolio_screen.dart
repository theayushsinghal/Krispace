import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krispace/custom_components/loading.dart';
import 'package:krispace/screens/home/home.dart';
import 'dart:io';

import 'package:multi_image_picker/multi_image_picker.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double opacity = 0, monthly_price = 0.0, yearly_price = 0.0;
  String dropdownValue = "INR";
  bool paid = true, free = false;
  List<File> images = [];
  List<File> permimages = [];
  bool loading = false;
  final picker = ImagePicker();
  int index = 1;

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
                            'Portfolio',
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
                                setState(() {
                                  index = 2;
                                });
                              } else {
                                setState(() {
                                  loading = true;
                                  permimages.addAll(images);
                                });
                                List<String> url = [];
                                for (int i = 0; i < permimages.length; i++) {
                                  Reference firebaseStorageRef =
                                      FirebaseStorage.instance.ref().child(
                                          'users/portfolio/${FirebaseAuth.instance.currentUser.uid}/${getRandString(6)}');
                                  TaskSnapshot taskSnapshot =
                                      await firebaseStorageRef
                                          .putFile(permimages[i]);
                                  url.add(
                                      await taskSnapshot.ref.getDownloadURL());
                                }
                                print(url);
                                FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .update({
                                  'portfolio': FieldValue.arrayUnion(url),
                                  'monthlysub': monthly_price,
                                  'yearlysub': yearly_price,
                                  'subscribers': [],
                                });
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
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
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff1B262C),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 3,
                        color: Color.fromRGBO(0, 255, 148, 1),
                      )),
                  child: images.length > 0
                      ? Image.file(
                          images[0],
                          fit: BoxFit.cover,
                        )
                      : InkWell(
                          onTap: () async {
                            await getImage().then((imag) {
                              setState(() {
                                images.add(imag);
                              });
                            });
                          },
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(255, 200, 87, 1)),
                                  child: Icon(Icons.add),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "Add",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Oswald-Regular",
                                      color: Color.fromRGBO(0, 255, 148, 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff1B262C),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 3,
                        color: Color.fromRGBO(0, 255, 148, 1),
                      )),
                  child: images.length > 1
                      ? Image.file(
                          images[1],
                          fit: BoxFit.cover,
                        )
                      : InkWell(
                          onTap: () async {
                            await getImage().then((imag) {
                              setState(() {
                                images.add(imag);
                              });
                            });
                          },
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(255, 200, 87, 1)),
                                  child: Icon(Icons.add),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "Add",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Oswald-Regular",
                                      color: Color.fromRGBO(0, 255, 148, 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff1B262C),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 3,
                        color: Color.fromRGBO(0, 255, 148, 1),
                      )),
                  child: images.length > 2
                      ? Image.file(
                          images[2],
                          fit: BoxFit.cover,
                        )
                      : InkWell(
                          onTap: () async {
                            await getImage().then((imag) {
                              setState(() {
                                images.add(imag);
                              });
                            });
                          },
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(255, 200, 87, 1)),
                                  child: Icon(Icons.add),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "Add",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Oswald-Regular",
                                      color: Color.fromRGBO(0, 255, 148, 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff1B262C),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 3,
                        color: Color.fromRGBO(0, 255, 148, 1),
                      )),
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        permimages.addAll(images);
                        images = [];
                      });
                    },
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(255, 200, 87, 1)),
                            child: Icon(Icons.add),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "Add More",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Oswald-Regular",
                                color: Color.fromRGBO(0, 255, 148, 1)),
                          ),
                          images.length > 3
                              ? SizedBox(
                                  height: 14,
                                )
                              : SizedBox(),
                          images.length > 3
                              ? Text(
                                  images.length > 3
                                      ? "${images.length - 3} more uploads"
                                      : "",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Oswald-Regular",
                                      color: Color.fromRGBO(0, 255, 148, 1)),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

//second page
  Widget index2() {
    double Width = MediaQuery.of(context).size.width;
    double Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Container(
      height: MediaQuery.of(context).size.height - 200,
      width: MediaQuery.of(context).size.width - 40,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: (181 * Width) / 414,
              height: (24 * Height) / 736,
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Choose Price Category",
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
          // checkbox paid or free
          Positioned(
            top: ((229.0 - 185.0) * Height) / 736,
            left: (0 * Width) / 414,
            child: Container(
              height: (20 * Height) / 736,
              child: Row(
                children: [
                  Container(
                    width: (20 * Width) / 414,
                    height: (20 * Height) / 736,
                    //color: Color(0xff00FF94),
                    child: Transform.scale(
                      scale: 1,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: Color(0xffFFC857),
                        ),
                        child: Checkbox(
                          activeColor: Color(0xffFFC857),
                          checkColor: Colors.black,
                          value: paid,
                          onChanged: (value) {
                            setState(() {
                              paid = value;
                              free = !paid;
                              if (free) {
                                monthly_price = 0.0;
                                yearly_price = 0.0;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: (15 * Width) / 414,
                  ),
                  Text(
                    "Paid",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff00FF94),
                    ),
                  ),
                  SizedBox(
                    width: (40 * Width) / 414,
                  ),
                  Container(
                    width: (20 * Width) / 414,
                    height: (20 * Height) / 736,
                    //color: Color(0xff00FF94),
                    child: Transform.scale(
                      scale: 1,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: Color(0xffFFC857),
                        ),
                        child: Checkbox(
                          activeColor: Color(0xffFFC857),
                          checkColor: Colors.black,
                          value: free,
                          onChanged: (value) {
                            setState(() {
                              free = value;
                              paid = !free;
                              if (free) {
                                monthly_price = 0.0;
                                yearly_price = 0.0;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: (15 * Width) / 414,
                  ),
                  Text(
                    "Free",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff00FF94),
                    ),
                  )
                ],
              ),
            ),
          ),
          //set price
          Positioned(
            top: ((284 - 185) * Height) / 736,
            left: (0 * Width) / 414,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: (181 * Width) / 414,
                  height: (24 * Height) / 736,
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Set Price",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontFamily: "Oswald-Regular",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: (20 * Height) / 736),
                Container(
                  width: (187 * Width) / 414,
                  height: (20 * Height) / 736,
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "For Monthly Subscription",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff00FF94),
                        fontFamily: "Oswald-Regular",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: (10 * Height) / 736),
                Row(
                  children: [
                    Container(
                      height: (38 * Height) / 736,
                      width: (68 * Width) / 414,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xff00FF94),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: DropdownButton<String>(
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 20,
                          value: dropdownValue,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['INR', 'USD']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(width: (10 * Width) / 414),
                    Container(
                      height: (38 * Height) / 736,
                      width: (250 * Width) / 414,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xff00FF94),
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 13.0, bottom: 3),
                        child: free
                            ? FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '0.0',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : TextField(
                                onChanged: (String value) {
                                  setState(
                                    () {
                                      try {
                                        this.monthly_price =
                                            double.parse(value);
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Enter Valid Price'),
                                        ));
                                      }
                                    },
                                  );
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: (20 * Height) / 736),
                Container(
                  width: (187 * Width) / 414,
                  height: (20 * Height) / 736,
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "For Annual Subscription",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff00FF94),
                        fontFamily: "Oswald-Regular",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: (10 * Height) / 736),
                Row(
                  children: [
                    Container(
                      height: (38 * Height) / 736,
                      width: (68 * Width) / 414,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xff00FF94),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: DropdownButton<String>(
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 20,
                          value: dropdownValue,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['INR', 'USD']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(width: (10 * Width) / 414),
                    Container(
                      height: (38 * Height) / 736,
                      width: (250 * Width) / 414,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xff00FF94),
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 13.0, bottom: 3),
                        child: free
                            ? FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '0.0',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : TextField(
                                onChanged: (String value) {
                                  setState(
                                    () {
                                      try {
                                        this.yearly_price = double.parse(value);
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Enter Valid Price'),
                                        ));
                                      }
                                    },
                                  );
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                      ),
                    ),
                  ],
                ),
              ],
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
