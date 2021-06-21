import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krispace/models/user.dart';
import 'package:krispace/screens/admin/user_profile.dart';

class VotingList extends StatefulWidget {
  final DocumentSnapshot contest;

  const VotingList({Key key, this.contest}) : super(key: key);

  @override
  _VotingListState createState() => _VotingListState();
}

class _VotingListState extends State<VotingList> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(27, 38, 44, 1),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Participant Voting",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: "Oswald-Regular"),
                  ),
                  Text(
                    "Vote Left : " +
                        (widget.contest
                                .data()["voters"]
                                .contains(FirebaseAuth.instance.currentUser.uid)
                            ? "0"
                            : "1"),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: "Oswald-Regular"),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Participants List",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Total Participants : ${widget.contest.data()["participants"].length.toString()}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
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
                child: ListView.builder(
                    itemCount: widget.contest.data()["participants"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return userListTab(
                          widget.contest.data()["participants"][index]);
                    }))
          ],
        ),
      ),
    );
  }

  Widget userListTab(String id) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Contests")
            .doc(widget.contest.id)
            .collection("Participants")
            .doc(id)
            .snapshots(),
        builder: (context, snapshot) {
          return InkWell(
            onTap: () async {
              DocumentSnapshot snap = await FirebaseFirestore.instance
                  .collection("Contests")
                  .doc(widget.contest.id)
                  .get();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
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
                                shape: BoxShape.circle,
                                color: Colors.blueGrey,
                                border: Border.all(
                                    color: Color.fromRGBO(0, 255, 148, 1))),
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          Text(
                            snapshot.data.data()["name"],
                            style: TextStyle(
                                color: Color.fromRGBO(249, 252, 251, 1),
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    snapshot.data
                            .data()["voters"]
                            .contains(FirebaseAuth.instance.currentUser.uid)
                        ? Container(
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
                                  "Voted",
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color.fromRGBO(178, 178, 178, 1),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              if (!widget.contest.data()["voters"].contains(
                                  FirebaseAuth.instance.currentUser.uid)) {
                                FirebaseFirestore.instance
                                    .collection("Contests")
                                    .doc(widget.contest.id)
                                    .collection("Participants")
                                    .doc(id)
                                    .update({
                                  "voters": FieldValue.arrayUnion(
                                      [FirebaseAuth.instance.currentUser.uid])
                                });
                                FirebaseFirestore.instance
                                    .collection("Contests")
                                    .doc(widget.contest.id)
                                    .update({
                                  "voters": FieldValue.arrayUnion(
                                      [FirebaseAuth.instance.currentUser.uid])
                                });
                                Navigator.of(context).pop();
                              }
                            },
                            child: Container(
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
                                  "Vote",
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color.fromRGBO(0, 255, 148, 0.8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
