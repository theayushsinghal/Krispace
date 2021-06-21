import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:krispace/custom_components/alerts/alert_pop_up.dart';
import 'package:krispace/custom_components/alerts/create_profile_pop_up.dart';
import 'package:krispace/models/feed_model.dart';
import 'package:provider/provider.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  TextEditingController controller = new TextEditingController();
  bool showComment = false;

  initState() {
    // print(''recordFeed.imgURL);
    super.initState();
  }

  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedModel>(
      builder: (context, feedModel, child) => Material(
        child: Container(
            color: Color.fromRGBO(27, 38, 44, 1),
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.blueGrey,
                                ),
                                width: 30,
                                height: 30,
                                child: Image(
                                  image: NetworkImage(feedModel.userurl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 7, top: 2, bottom: 2),
                                child: Column(
                                  children: [
                                    Text(
                                      feedModel.username,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Icon(
                            FontAwesomeIcons.ellipsisV,
                            color: Colors.grey,
                            size: 24,
                          ),
                        )
                      ],
                    )),
                InkWell(
                  onTap: () {
                    if (FirebaseAuth.instance.currentUser == null) {
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return CreateProfilePopup();
                          });
                    } else {
                      if (feedModel.paid) {
                        showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return Alert_PopUp();
                            });
                      }
                    }
                  },
                  child: Container(
                    child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Opacity(
                            opacity: feedModel.paid ? 0.5 : 1,
                            child: Image(
                              image: NetworkImage(feedModel.feedurl),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          feedModel.paid
                              ? Icon(
                                  FontAwesomeIcons.lock,
                                  color: Colors.white,
                                  size: 32,
                                )
                              : SizedBox(),
                        ]),
                  ),
                ),
                Container(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 15, left: 20),
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (FirebaseAuth.instance.currentUser ==
                                          null) {
                                        showDialog<void>(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return CreateProfilePopup();
                                            });
                                      } else {
                                        setState(() {
                                          if (!feedModel.likes.contains(
                                              FirebaseAuth
                                                  .instance.currentUser.uid)) {
                                            FirebaseFirestore.instance
                                                .collection("Posts")
                                                .doc(feedModel.postId)
                                                .update({
                                              "likes": FieldValue.arrayUnion([
                                                FirebaseAuth
                                                    .instance.currentUser.uid
                                              ])
                                            });
                                            feedModel.likes.add(FirebaseAuth
                                                .instance.currentUser.uid);
                                          } else {
                                            FirebaseFirestore.instance
                                                .collection("Posts")
                                                .doc(feedModel.postId)
                                                .update({
                                              "likes": FieldValue.arrayRemove([
                                                FirebaseAuth
                                                    .instance.currentUser.uid
                                              ])
                                            });
                                            feedModel.likes.remove(FirebaseAuth
                                                .instance.currentUser.uid);
                                          }
                                        });
                                      }
                                    },
                                    child: (!feedModel.likes.contains(
                                            FirebaseAuth.instance.currentUser ==
                                                    null
                                                ? "0"
                                                : FirebaseAuth
                                                    .instance.currentUser.uid))
                                        ? Icon(
                                            Icons.favorite_border,
                                            color: Colors.white,
                                            size: 26,
                                          )
                                        : Icon(
                                            Icons.favorite,
                                            color: Colors.pink,
                                            size: 26,
                                          ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    feedModel.likes.length.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.chat_bubble_2,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    feedModel.comments.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.shareAlt,
                                color: Colors.white,
                                size: 26,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Share",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width - 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          feedModel.headline,
                          maxLines: readMore ? 100 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      readMore
                          ? Container(
                              child: Text(
                                feedModel.description,
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 10),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  readMore = true;
                                });
                              },
                              child: Container(
                                child: Text(
                                  "Read more",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: readMore ? 7 : 0,
                      ),
                      readMore
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  readMore = false;
                                });
                              },
                              child: Container(
                                child: Text(
                                  "Read less",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${feedModel.comments.toString()} Comments",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                showComment = !showComment;
                              });
                            },
                            child: Text(
                              showComment ? "Hide" : "Show",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                showComment
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("Posts")
                                .doc(feedModel.postId)
                                .collection("Comments")
                                .snapshots(),
                            builder: (context, snapshot) {
                              return snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? Center(
                                      child: Container(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator()))
                                  : Column(
                                      children: [
                                        ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                height: 60,
                                                child: Comment.fromDocument(
                                                    snapshot.data.docs[index]),
                                              );
                                            }),
                                      ],
                                    );
                            }),
                      )
                    : SizedBox(),
                Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            color: Colors.blueGrey,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3, left: 5),
                            width: MediaQuery.of(context).size.width * 5 / 8,
                            child: TextField(
                              style: TextStyle(fontSize: 14),
                              maxLines: 1,
                              controller: controller,
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Add a comment ...."),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          if (FirebaseAuth.instance.currentUser == null) {
                            showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return CreateProfilePopup();
                                });
                          } else {
                            if (feedModel.paid) {
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return Alert_PopUp();
                                  });
                            } else {
                              if (controller.text.length != 0) {
                                FirebaseFirestore.instance
                                    .collection("Posts")
                                    .doc(feedModel.postId)
                                    .update(
                                        {"comments": FieldValue.increment(1)});
                                DocumentSnapshot currentuser =
                                    await FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(FirebaseAuth
                                            .instance.currentUser.uid)
                                        .get();
                                FirebaseFirestore.instance
                                    .collection("Posts")
                                    .doc(feedModel.postId)
                                    .collection("Comments")
                                    .doc()
                                    .set({
                                  "text": controller.text,
                                  "user": currentuser.data()['userid'],
                                  "url": currentuser.data()["url"],
                                  "userid":
                                      FirebaseAuth.instance.currentUser.uid,
                                  "dateTime": DateTime.now(),
                                });
                              }
                            }
                          }
                          setState(() {
                            controller = new TextEditingController();
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          child: Icon(Icons.send),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String userId;
  final String avatarUrl;
  final String comment;
  final Timestamp timestamp;

  Comment(
      {this.username,
      this.userId,
      this.avatarUrl,
      this.comment,
      this.timestamp});

  factory Comment.fromDocument(DocumentSnapshot document) {
    var data = document.data();
    return Comment(
      username: data['user'],
      userId: data['userId'],
      comment: data["text"],
      timestamp: data["dateTime"],
      avatarUrl: data["url"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(avatarUrl),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  username,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      comment,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
