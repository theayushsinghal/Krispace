import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'admin_home.dart';

class AdminContests extends StatefulWidget {
  @override
  _AdminContestsState createState() => _AdminContestsState();
}

class _AdminContestsState extends State<AdminContests> {
  double height;
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
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.vertical -
        130;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Contests").snapshots(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator()))
              : Column(
                  children: [
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Our Contests",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: "Oswald-Regular"),
                          ),
                          Icon(
                            FontAwesomeIcons.filter,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 15),
                      width: MediaQuery.of(context).size.width,
                      height: 0.5,
                      color: Color.fromRGBO(249, 252, 251, 1),
                    ),
                    Expanded(
                      child: Container(
                          child: ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (snapshot.data.docs[index].id ==
                                    "DefaultPosters") {
                                  return SizedBox();
                                } else {
                                  return contest(
                                      context, snapshot.data.docs[index]);
                                }
                              })),
                    )
                  ],
                );
        });
  }

  Widget contest(BuildContext context, DocumentSnapshot data) {
    DateTime dateTime = data.data()["dateTime"].toDate();
    String date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 126,
      decoration: BoxDecoration(
        border: Border(
          bottom:
              BorderSide(color: Color.fromRGBO(249, 252, 251, 1), width: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 87,
            height: 87,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(249, 252, 251, 1), width: 0.5),
              image: DecorationImage(
                image: NetworkImage(data.data()["poster"]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 278,
            height: 87,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.data()["headline"],
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromRGBO(249, 252, 251, 1),
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Color.fromRGBO(255, 200, 87, 1),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 30,
                    child: Text(
                      data.data()["about"],
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Color.fromRGBO(178, 178, 178, 1),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 21,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                            color: Color.fromRGBO(0, 255, 148, 1), width: 0.5),
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 14),
                        child: Center(
                          child: Text(
                            data.data()["fees"] == 0
                                ? "Free"
                                : "Paid : Fee Rs. ${data.data()["fees"]}",
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Color.fromRGBO(0, 255, 148, 0.8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 120.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Icon(
                              FontAwesomeIcons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                            onTap: () async {
                              setState(() {
                                _paid = data.data()["paid"] ? "Paid" : "Free";
                                dropdownValue = 'INR';
                                category = data.data()["category"];
                                headline = new TextEditingController(
                                    text: data.data()["headline"]);
                                about = new TextEditingController(
                                    text: data.data()["about"]);
                                fees = data.data()["paid"]
                                    ? new TextEditingController(
                                        text: data.data()["fees"].toString())
                                    : new TextEditingController();
                                firstPrize = new TextEditingController();
                                secondPrize = new TextEditingController();
                                thirdPrize = new TextEditingController();
                                if (data.data()["prizes"].length >= 1) {
                                  firstPrize = new TextEditingController(
                                      text:
                                          data.data()["prizes"][0].toString());
                                  if (data.data()["prizes"].length >= 2) {
                                    secondPrize = new TextEditingController(
                                        text: data
                                            .data()["prizes"][1]
                                            .toString());
                                    if (data.data()["prizes"].length == 3)
                                      thirdPrize = new TextEditingController(
                                          text: data
                                              .data()["prizes"][2]
                                              .toString());
                                    else {}
                                  }
                                }
                                rulesAndRegulation = new TextEditingController(
                                    text: data.data()["regulation"]);
                                InputNumber = new TextEditingController(
                                    text: data
                                        .data()["submissionNumber"]
                                        .toString());
                              });
                              _editModalBottomSheet(
                                  context, data.data()["contestId"]);
                            },
                          ),
                          Container(
                            width: 90.0,
                            height: 21,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 200, 87, 1),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Center(
                              child: Text(
                                "Declare Result",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
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

  void _editModalBottomSheet(BuildContext context, String documentId) {
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
                              int.parse(secondPrize.text);
                            }
                            if (thirdPrize.text.length != 0) {
                              int.parse(thirdPrize.text);
                            }
                            if (_formKey.currentState.validate() &&
                                error.length == 0) {
                              DocumentSnapshot doc = await FirebaseFirestore
                                  .instance
                                  .collection("Contests")
                                  .doc("DefaultPosters")
                                  .get();
                              FirebaseFirestore.instance
                                  .collection("Contests")
                                  .doc(documentId)
                                  .update({
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
                                "Update",
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
