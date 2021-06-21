import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:krispace/custom_components/loading.dart';

class ContestResult extends StatefulWidget {
  final DocumentSnapshot contest;
  final DocumentSnapshot currentuser;

  const ContestResult({Key key, this.contest, this.currentuser})
      : super(key: key);
  @override
  _ContestResultState createState() => _ContestResultState();
}

class _ContestResultState extends State<ContestResult> {
  List friends;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    friends = widget.currentuser.data()["friends"];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(27, 38, 44, 1),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromRGBO(249, 252, 251, 1),
                      width: 0.5,
                    ),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Contest Result",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Color.fromRGBO(249, 252, 251, 1),
                          fontFamily: "Oswald-Regular",
                        ),
                      ),
                      Icon(
                        Icons.share_sharp,
                        color: Color.fromRGBO(249, 252, 251, 1),
                        size: 26,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: widget.contest.data()["state"] == "Declared"
                    ? Container(
                        width: 262,
                        height: 313,
                        child: Image.asset("Assets/Images/Group 104.png"),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width - 30,
                        child: ListView.builder(
                            itemCount: widget.contest.data()["winners"].length,
                            itemBuilder: (context, index) {
                              return Winner(
                                rank: index + 1,
                                contest: widget.contest,
                                currentuser: widget.currentuser,
                              );
                            })),
              ),
            ],
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

class Winner extends StatefulWidget {
  final int rank;
  final DocumentSnapshot contest;
  final DocumentSnapshot currentuser;

  const Winner({Key key, this.rank, this.currentuser, this.contest})
      : super(key: key);
  @override
  _WinnerState createState() => _WinnerState();
}

class _WinnerState extends State<Winner> {
  List<Color> colorlist = [
    Color.fromRGBO(255, 196, 45, 1),
    Color.fromRGBO(222, 226, 230, 1),
    Color.fromRGBO(212, 162, 118, 1)
  ];
  List<String> ranks = ["Ist", "IInd", "IIIrd"];
  bool follow;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    follow = widget.currentuser
        .data()["friends"]
        .contains(widget.contest.data()["winners"][widget.rank - 1]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(widget.contest.data()["winners"][widget.rank - 1])
            .snapshots(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: Container(
                  width: 50,
                  height: 50,
                  child: Loading(),
                ))
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          ranks[widget.rank - 1] + " Prize Winner",
                          style: TextStyle(
                              color: colorlist[widget.rank - 1],
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.award,
                            color: colorlist[widget.rank - 1],
                            size: 24,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  snapshot.data.data()["url"]),
                                              fit: BoxFit.cover,
                                            ),
                                            shape: BoxShape.circle,
                                            color: Colors.blueGrey,
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    0, 255, 148, 1))),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Text(
                                        snapshot.data.data()["name"],
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                249, 252, 251, 1),
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (!follow) {
                                      FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(FirebaseAuth
                                              .instance.currentUser.uid)
                                          .update({
                                        "friends": FieldValue.arrayUnion([
                                          widget.contest.data()["winners"]
                                              [widget.rank - 1]
                                        ])
                                      });
                                    } else {
                                      FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(FirebaseAuth
                                              .instance.currentUser.uid)
                                          .update({
                                        "friends": FieldValue.arrayRemove([
                                          widget.contest.data()["winners"]
                                              [widget.rank - 1]
                                        ])
                                      });
                                    }
                                    setState(() {
                                      follow = !follow;
                                    });
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(
                                          color: follow
                                              ? Color.fromRGBO(178, 178, 178, 1)
                                              : colorlist[0],
                                          width: 0.5),
                                    ),
                                    child: Container(
                                      child: Center(
                                        child: follow
                                            ? Text(
                                                "UnFollow",
                                                style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Color.fromRGBO(
                                                      178, 178, 178, 1),
                                                ),
                                              )
                                            : Text(
                                                "Follow",
                                                style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: colorlist[0],
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
        });
  }
}
