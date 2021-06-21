import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:krispace/screens/admin/pendingpayments.dart';
import 'package:krispace/screens/admin/user_approval.dart';
import 'package:krispace/screens/splash_screen.dart';

import 'manage_contests.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _paid = "Paid";
  String dropdownValue = 'INR';
  String category = "Photography";
  String error = "";
  TextEditingController headline = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController fees = TextEditingController();
  TextEditingController firstPrize = TextEditingController();
  TextEditingController secondPrize = TextEditingController();
  TextEditingController thirdPrize = TextEditingController();
  TextEditingController rulesAndRegulation = TextEditingController();
  TextEditingController InputNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color.fromRGBO(27, 38, 44, 1),
          body: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned(
                  top: topHeight(context, 10),
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
                              FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SplashScreen(),
                                ),
                              );
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
                                enabled:
                                    (choice == "blank" || choice == "Krispace")
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
                                            color:
                                                Color.fromRGBO(27, 38, 44, 1)),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(27, 38, 44, 1),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                                choice == "Krispace"
                                                    ? 20.0
                                                    : 0),
                                            bottomRight: Radius.circular(
                                                choice == "logout" ? 20.0 : 0),
                                          ),
                                        ),
                                        width: 200,
                                        height: choice == "Krispace" ? 53 : 40,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 0.3),
                                            color:
                                                Color.fromRGBO(27, 38, 44, 1),
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
                                            gradient: (choice == "logout")
                                                ? LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          0, 255, 148, 0.5),
                                                      Color.fromRGBO(
                                                          249, 252, 251, 0.25),
                                                    ],
                                                  )
                                                : LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          27, 38, 44, 1),
                                                      Color.fromRGBO(
                                                          27, 38, 44, 1)
                                                    ],
                                                  ),
                                          ),
                                          width: 200,
                                          height:
                                              choice == "Krispace" ? 53 : 40,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: choice == "Krispace"
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
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
                                                              child: Image.asset(
                                                                  "Assets/Images/krispace_logo.png"),
                                                            ),
                                                            Text(
                                                              choice,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
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
                                                        onTap: () {},
                                                        child: Icon(Icons.close,
                                                            color:
                                                                Color.fromRGBO(
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
                                                        color:
                                                            Colors.grey[300]),
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
                top: topHeight(context, 70),
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewPadding.vertical -
                    130,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  height: topHeight(context, 100),
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        AdminApproval(),
                        AdminContests(),
                        Container(),
                        AdminWallet(),
                        Container(),
                      ]),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(MediaQuery.of(context).size.width, 60),
                        painter: _tabController.index != 1
                            ? CustomPaintBarStraight()
                            : CustomPaintBarCurved(),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 60,
                        decoration: _tabController.index == 1
                            ? BoxDecoration()
                            : BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      'Assets/Images/bottomnavbar.png',
                                    ),
                                    fit: BoxFit.scaleDown),
                              ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: UnderlineTabIndicator(
                              insets: EdgeInsets.symmetric(horizontal: 10),
                              borderSide: BorderSide(
                                width: 6.0,
                                color: Color.fromRGBO(255, 200, 87, 1),
                              )),
                          tabs: [
                            Tab(
                              icon: Icon(
                                FontAwesomeIcons.users,
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
                          onTap: (int index) async {
                            setState(() {
                              _tabController.index = index;
                            });
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
          floatingActionButton: _tabController.index == 1
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FloatingActionButton(
                    backgroundColor: Color.fromRGBO(255, 200, 87, 1),
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 40,
                    ),
                    onPressed: () async {
                      setState(() {
                        _paid = "Paid";
                        dropdownValue = 'INR';
                        category = "Photography";
                        headline = new TextEditingController();
                        about = new TextEditingController();
                        fees = new TextEditingController();
                        firstPrize = new TextEditingController();
                        secondPrize = new TextEditingController();
                        thirdPrize = new TextEditingController();
                        rulesAndRegulation = new TextEditingController();
                        InputNumber = new TextEditingController();
                      });
                      _editModalBottomSheet(context);
                    },
                  ),
                )
              : SizedBox(),
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
              child: Container(
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
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            "Create Contest",
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 200, 87, 0.5),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "Assets/Images/Admin/${category == 'Photography' ? "photo.png" : category == 'Videography' ? "video.png" : category == 'Art and Drawing' ? "paint.png" : category == 'Writing' ? "pen.png" : "null"}")),
                                      borderRadius: BorderRadius.circular(5)),
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.add_circle_outline_rounded,
                                    size: 44,
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Select Category",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(27, 38, 44, 1)),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 30,
                                        child: Container(
                                            width: 400,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                                border: Border.all(width: 0.5)),
                                            height: 30,
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: category,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              iconSize: 20,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                              underline: Container(
                                                height: 0,
                                                color: Colors.transparent,
                                              ),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  category = newValue;
                                                });
                                              },
                                              items: <String>[
                                                'Photography',
                                                'Videography',
                                                'Art and Drawing',
                                                'Writing',
                                                'Other'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 21,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                          margin: const EdgeInsets.symmetric(horizontal: 40.0),
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            "About Contest",
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
                          margin: const EdgeInsets.symmetric(horizontal: 40.0),
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(width: 0.5)),
                          child: TextFormField(
                            controller: about,
                            validator: (String val) {
                              if (val.length == 0) {
                                setState(() {
                                  error = "Description cannot be left empty";
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
                          margin: const EdgeInsets.symmetric(horizontal: 25.0),
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
                                    fees = new TextEditingController(text: "");
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
                          height: 14,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            "Enter Fees",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _paid == "Free"
                                    ? Colors.grey
                                    : Color.fromRGBO(27, 38, 44, 1)),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(width: 0.5)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: dropdownValue,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 20,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.transparent,
                                        ),
                                        onChanged: _paid == "Free"
                                            ? null
                                            : (String newValue) {
                                                setState(() {
                                                  dropdownValue = newValue;
                                                });
                                              },
                                        items: <String>['INR']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(width: 0.5)),
                                    height: 30,
                                    child: Center(
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        controller: fees,
                                        enabled: _paid == "Paid",
                                        validator: (String val) {
                                          if (val.length == 0 &&
                                              _paid == "Paid") {
                                            setState(() {
                                              error =
                                                  "fees cannot be left empty";
                                            });
                                          } else if (error.length == 0) {
                                            setState(() {
                                              error = "";
                                            });
                                          }
                                          return null;
                                        },
                                        style: TextStyle(fontSize: 16),
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            "Enter Prize Amount",
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
                            margin:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 70,
                                  child: Text(
                                    "1st Prize",
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 196, 45, 1)),
                                  ),
                                ),
                                Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(width: 0.5)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: dropdownValue,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 20,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.transparent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownValue = newValue;
                                          });
                                        },
                                        items: <String>['INR']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(width: 0.5)),
                                    height: 30,
                                    child: Center(
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        controller: firstPrize,
                                        style: TextStyle(fontSize: 16),
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 70,
                                  child: Text(
                                    "2nd Prize",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(222, 226, 230, 1)),
                                  ),
                                ),
                                Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(width: 0.5)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: dropdownValue,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 20,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.transparent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownValue = newValue;
                                          });
                                        },
                                        items: <String>['INR']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(width: 0.5)),
                                    height: 30,
                                    child: Center(
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        controller: secondPrize,
                                        style: TextStyle(fontSize: 16),
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 70,
                                  child: Text(
                                    "3rd Prize",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(212, 162, 118, 1)),
                                  ),
                                ),
                                Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(width: 0.5)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: dropdownValue,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 20,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.transparent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownValue = newValue;
                                          });
                                        },
                                        items: <String>['INR']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(width: 0.5)),
                                    height: 30,
                                    child: Center(
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        controller: thirdPrize,
                                        style: TextStyle(fontSize: 16),
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            "Rules and Regulation",
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
                          margin: const EdgeInsets.symmetric(horizontal: 40.0),
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(width: 0.5)),
                          child: TextFormField(
                            controller: rulesAndRegulation,
                            validator: (String val) {
                              if (val.length == 0) {
                                setState(() {
                                  error = "Rules cannot be left empty";
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
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            "Number of Images/videos",
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
                          margin: const EdgeInsets.symmetric(horizontal: 40.0),
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(width: 0.5)),
                          child: TextFormField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: InputNumber,
                            validator: (String val) {
                              if (val.length == 0) {
                                setState(() {
                                  error =
                                      "Number of uploads cannot be left empty";
                                });
                              } else if (error.length == 0) {
                                setState(() {
                                  error = "";
                                });
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 12),
                            maxLines: 1,
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
                          height: 37,
                        ),
                        InkWell(
                          onTap: () async {
                            List prizes = [];
                            if (firstPrize.text.length != 0) {
                              prizes.add(int.parse(firstPrize.text));
                            }
                            if (secondPrize.text.length != 0) {
                              prizes.add(int.parse(secondPrize.text));
                            }
                            if (thirdPrize.text.length != 0) {
                              prizes.add(int.parse(thirdPrize.text));
                            }
                            if (_formKey.currentState.validate() &&
                                error.length == 0) {
                              DocumentSnapshot doc = await FirebaseFirestore
                                  .instance
                                  .collection("Contests")
                                  .doc("DefaultPosters")
                                  .get();
                              DocumentReference docref = FirebaseFirestore
                                  .instance
                                  .collection("Contests")
                                  .doc();
                              docref.set({
                                "contestId": docref.id,
                                "category": category,
                                "headline": headline.text,
                                "about": about.text,
                                "paid": _paid == "Paid",
                                "fees": fees.text.length == 0
                                    ? 00
                                    : int.parse(fees.text),
                                "poster": doc.data()[category],
                                "dateTime": DateTime.now(),
                                "regulation": rulesAndRegulation.text,
                                "prizes": prizes,
                                "submissionNumber": int.parse(InputNumber.text),
                                "participants": [],
                                "voters": [],
                                "winners": [],
                                "state": "Registration"
                              });
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromRGBO(255, 200, 87, 1)),
                            child: Center(
                              child: Text(
                                "Create",
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
                          margin: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Center(
                            child: Text(
                              error,
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          });
        });
  }
}

class CustomPaintBarCurved extends CustomPainter {
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

class CustomPaintBarStraight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..color = Colors.white
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, convertRadiusToSigma(8));
    //starting point
    Path path1 = Path()..moveTo(0, 20);
    //building the around points
    path1.quadraticBezierTo(0, 0, 20, 0);
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
