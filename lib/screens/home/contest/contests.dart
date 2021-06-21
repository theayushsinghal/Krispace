import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:krispace/custom_components/alerts/participation_popup.dart';
import 'package:krispace/screens/home/contest/voting_list.dart';

class Contests extends StatefulWidget {
  @override
  _ContestsState createState() => _ContestsState();
}

class _ContestsState extends State<Contests> {
  double height;
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
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Krispace Contests",
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
                      margin: EdgeInsets.only(top: 16, bottom: 0),
                      width: MediaQuery.of(context).size.width,
                      height: 0.5,
                      color: Color.fromRGBO(249, 252, 251, 1),
                    ),
                    Expanded(
                      child: Container(
                          child: snapshot.data.docs.length == 1
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "No Contests for now",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 22,
                                        fontFamily: "Oswald-Regular"),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (snapshot.data.docs[index].id ==
                                        "DefaultPosters") {
                                      return SizedBox();
                                    } else {
                                      return Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        actionExtentRatio: 0.25,
                                        child: contest(
                                            context, snapshot.data.docs[index]),
                                        secondaryActions: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20)),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          0, 255, 148, 0.5),
                                                      Color.fromRGBO(
                                                          249, 252, 251, 0.25)
                                                    ])),
                                            child: IconSlideAction(
                                              color: Colors.transparent,
                                              iconWidget: Icon(
                                                Icons.how_to_vote,
                                                size: 40,
                                                color: Color.fromRGBO(
                                                    0, 255, 148, 1),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        VotingList(
                                                            contest: snapshot
                                                                .data
                                                                .docs[index]),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  })),
                    ),
                    SizedBox(
                      height: 70,
                    ),
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
                    InkWell(
                      onTap: () async {
                        if (data
                            .data()["participants"]
                            .contains(FirebaseAuth.instance.currentUser.uid)) {
                          DocumentSnapshot member = await FirebaseFirestore
                              .instance
                              .collection("Contests")
                              .doc(data.id)
                              .collection("Participants")
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .get();
                          showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return SubmissionPopup(
                                  contest: data,
                                  member: member,
                                );
                              });
                        } else {
                          showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return ParticipationPopup(
                                  contest: data,
                                );
                              });
                        }
                      },
                      child: Container(
                        width: 90.0,
                        height: 21,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 200, 87, 1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Center(
                          child: Text(
                            data.data()["participants"].contains(
                                    FirebaseAuth.instance.currentUser.uid)
                                ? "View"
                                : "Participate",
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.black,
                            ),
                          ),
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
}
