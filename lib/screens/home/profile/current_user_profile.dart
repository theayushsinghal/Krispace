import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:krispace/custom_components/loading.dart';
import 'package:krispace/screens/home/profile/contest_result.dart';

class CurrentUserProfile extends StatefulWidget {
  @override
  _CurrentUserProfileState createState() => _CurrentUserProfileState();
}

class _CurrentUserProfileState extends State<CurrentUserProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: Container(
                    width: 50,
                    height: 50,
                    child: Loading(),
                  ))
                : DefaultTabController(
                    length: 4,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Positioned(
                          top: topHeight(context, 76),
                          child: Container(
                            width: 375,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Krispace Profile",
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Color.fromRGBO(249, 252, 251, 1),
                                      fontFamily: "Oswald-Regular",
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Color.fromRGBO(249, 252, 251, 1),
                                    ),
                                    onPressed: () {})
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: topHeight(context, 121),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 137,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: Color.fromRGBO(249, 252, 251, 1),
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
                                          Color.fromRGBO(0, 255, 148, 0.25),
                                          Color.fromRGBO(255, 255, 255, 0.05),
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
                                                  snapshot.data.data()["url"]),
                                              fit: BoxFit.fill),
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
                                    snapshot.data.data()["name"],
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Color.fromRGBO(249, 252, 251, 1),
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
                                        color: Color.fromRGBO(255, 200, 87, 1),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        snapshot.data.data()["userid"],
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color:
                                              Color.fromRGBO(255, 200, 87, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: topHeight(context, 74),
                                  left: leftWidth(context, 140),
                                  child: Text(
                                    snapshot.data.data()["bio"],
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color.fromRGBO(178, 178, 178, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: topHeight(context, 258.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: leftWidth(context, 49),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: Color.fromRGBO(249, 252, 251, 1),
                                    width: 0.4),
                              ),
                            ),
                            child: TabBar(
                              unselectedLabelStyle: TextStyle(
                                fontSize: 10.0,
                                color: Color.fromRGBO(249, 252, 251, 1),
                              ),
                              unselectedLabelColor:
                                  Color.fromRGBO(249, 252, 251, 1),
                              labelColor: Color.fromRGBO(255, 200, 87, 1),
                              labelStyle: TextStyle(
                                fontSize: 12.0,
                                color: Color.fromRGBO(255, 200, 87, 1),
                              ),
                              indicator: UnderlineTabIndicator(
                                  insets: EdgeInsets.symmetric(horizontal: 25),
                                  borderSide: BorderSide(
                                    width: 6.0,
                                    color: Color.fromRGBO(255, 200, 87, 1),
                                  )),
                              tabs: [
                                Tab(text: 'My Posts'),
                                Tab(text: 'My Contests'),
                                Tab(text: 'My Friends'),
                                Tab(text: 'My Portfolio'),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: topHeight(context, 301),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: topHeight(context, 400),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: Color.fromRGBO(249, 252, 251, 1),
                                    width: 0.4),
                              ),
                            ),
                            child: TabBarView(children: [
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("Posts")
                                      .where("ownerId",
                                          isEqualTo: FirebaseAuth
                                              .instance.currentUser.uid)
                                      .snapshots(),
                                  builder: (context, snapshot2) {
                                    return snapshot2.connectionState ==
                                            ConnectionState.waiting
                                        ? Center(
                                            child: Container(
                                            width: 50,
                                            height: 50,
                                            child: Loading(),
                                          ))
                                        : snapshot2.data.docs.length == 0
                                            ? Center(
                                                child: Text(
                                                  "You do not have any post",
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Color.fromRGBO(
                                                        178, 178, 178, 1),
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: SingleChildScrollView(
                                                  child: Wrap(
                                                    spacing: 18,
                                                    runSpacing: 18,
                                                    children: snapshot2
                                                        .data.docs
                                                        .map((data) {
                                                      return post(data);
                                                    }).toList(),
                                                  ),
                                                ),
                                              );
                                  }),
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("Contests")
                                      .where("participants",
                                          arrayContains: FirebaseAuth
                                              .instance.currentUser.uid)
                                      .snapshots(),
                                  builder: (context, snapshot2) {
                                    return snapshot2.connectionState ==
                                            ConnectionState.waiting
                                        ? Center(
                                            child: Container(
                                            width: 50,
                                            height: 50,
                                            child: Loading(),
                                          ))
                                        : snapshot2.data.docs.length == 0
                                            ? Center(
                                                child: Text(
                                                  "You have not taken part in any competitions yet",
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Color.fromRGBO(
                                                        178, 178, 178, 1),
                                                  ),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemCount:
                                                    snapshot2.data.docs.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return contest(
                                                      context,
                                                      snapshot2
                                                          .data.docs[index],
                                                      snapshot.data);
                                                });
                                  }),
                              snapshot.data.data()["friends"].length == 0
                                  ? Center(
                                      child: Text(
                                        "You haven't followed anybody yet",
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color:
                                              Color.fromRGBO(178, 178, 178, 1),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 60, left: 20, right: 20),
                                        child: ListView.builder(
                                            itemCount: snapshot.data
                                                .data()["friends"]
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Friend(
                                                friend: snapshot.data
                                                    .data()["friends"][index],
                                              );
                                            }),
                                      ),
                                    ),
                              snapshot.data.data()["portfolio"].length == 0
                                  ? Center(
                                      child: Text(
                                        "You do not have any post",
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color:
                                              Color.fromRGBO(178, 178, 178, 1),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: ListView.builder(
                                          itemCount: snapshot.data
                                              .data()["portfolio"]
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              height: 125,
                                              width: 110,
                                              child: Image.network(
                                                snapshot.data
                                                    .data()["portfolio"][index],
                                                fit: BoxFit.contain,
                                              ),
                                            );
                                          })),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  );
          }),
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

  Widget post(QueryDocumentSnapshot documentSnapshot) {
    return Container(
      width: 110,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          Container(
            height: 125,
            width: 110,
            child: Image(
              image: NetworkImage(documentSnapshot.data()["feedurl"]),
              fit: BoxFit.cover,
            ),
          ),
          Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white),
                ),
              ),
              height: 20,
              width: 110,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                      left: 10,
                      child: Icon(
                        Icons.thumb_up,
                        color: Colors.white,
                        size: 15,
                      )),
                  Positioned(
                    left: 30,
                    child: Text(
                      documentSnapshot.data()["likes"].length.toString(),
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                  Positioned(
                      left: 65,
                      child: Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 15,
                      )),
                  Positioned(
                    left: 85,
                    child: Text(
                      documentSnapshot.data()["comments"].toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget contest(BuildContext context, DocumentSnapshot data,
      DocumentSnapshot currentUser) {
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContestResult(
                                  contest: data,
                                  currentuser: currentUser,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 21,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                  color: Color.fromRGBO(0, 255, 148, 1),
                                  width: 0.5),
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 14),
                              child: Center(
                                child: Text(
                                  "Result",
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color.fromRGBO(0, 255, 148, 0.8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 21,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                                color: Color.fromRGBO(178, 178, 178, 1),
                                width: 0.5),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 7),
                            child: Center(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    color: Color.fromRGBO(178, 178, 178, 1),
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Participated",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Color.fromRGBO(178, 178, 178, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget friends() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                CircleAvatar(),
                SizedBox(
                  width: 13,
                ),
                Text(
                  "Hail ho",
                  style: TextStyle(
                      color: Color.fromRGBO(249, 252, 251, 1), fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            height: topHeight(context, 21),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border:
                  Border.all(color: Color.fromRGBO(0, 255, 148, 1), width: 0.5),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 2, horizontal: 14),
              child: Center(
                child: Text(
                  "Unfollow",
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color.fromRGBO(0, 255, 148, 0.8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Friend extends StatefulWidget {
  final DocumentSnapshot currentuser;
  final friend;

  const Friend({Key key, this.friend, this.currentuser}) : super(key: key);
  @override
  _FriendState createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  bool follow = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(widget.friend)
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
                  child: Row(
                    children: [
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
                                        color: Color.fromRGBO(249, 252, 251, 1),
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
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .update({
                                    "friends":
                                        FieldValue.arrayUnion([widget.friend])
                                  });
                                } else {
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .update({
                                    "friends":
                                        FieldValue.arrayRemove([widget.friend])
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
                                          : Color.fromRGBO(255, 196, 45, 1),
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
                                              color: Color.fromRGBO(
                                                  255, 196, 45, 1),
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
                  ),
                );
        });
  }
}
