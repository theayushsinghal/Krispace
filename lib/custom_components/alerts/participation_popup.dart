import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krispace/custom_components/loading.dart';
import 'package:krispace/models/user.dart';
import 'dart:math';
import 'dart:convert';

class ParticipationPopup extends StatefulWidget {
  final DocumentSnapshot contest;

  const ParticipationPopup({Key key, this.contest}) : super(key: key);

  @override
  _ParticipationPopupState createState() => _ParticipationPopupState();
}

class _ParticipationPopupState extends State<ParticipationPopup> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.transparent, //Color(0xff1B262C),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: MediaQuery.of(context).size.width * 4 / 5,
            decoration: BoxDecoration(
              color: Color.fromRGBO(27, 38, 44, 1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color.fromRGBO(0, 255, 148, 1),
                width: 2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Participation',
                    style: TextStyle(
                        color: Color(0xffFFC857),
                        fontSize: 34,
                        fontFamily: 'Oswald-Regular',
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    widget.contest.data()["headline"],
                    style: TextStyle(
                        color: Color(0xff00FF94),
                        fontSize: 20,
                        fontFamily: 'Oswald-Regular',
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Rewards",
                    style: TextStyle(
                        color: Color(0xff00FF94),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 4 / 5,
                    height: 40,
                    child: widget.contest.data()["prizes"].length == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Ist : Rs" +
                                    widget.contest
                                        .data()["prizes"][0]
                                        .toString(),
                                style: TextStyle(
                                    fontFamily: "Oswald-Regular",
                                    fontSize: 14,
                                    color: Color.fromRGBO(255, 196, 45, 1)),
                              )
                            ],
                          )
                        : widget.contest.data()["prizes"].length == 2
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Ist : Rs" +
                                        widget.contest
                                            .data()["prizes"][0]
                                            .toString(),
                                    style: TextStyle(
                                        fontFamily: "Oswald-Regular",
                                        fontSize: 14,
                                        color: Color.fromRGBO(255, 196, 45, 1)),
                                  ),
                                  Text(
                                    "IIst : Rs" +
                                        widget.contest
                                            .data()["prizes"][1]
                                            .toString(),
                                    style: TextStyle(
                                        fontFamily: "Oswald-Regular",
                                        fontSize: 14,
                                        color:
                                            Color.fromRGBO(222, 226, 230, 1)),
                                  ),
                                ],
                              )
                            : widget.contest.data()["prizes"].length == 3
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Ist : Rs" +
                                            widget.contest
                                                .data()["prizes"][0]
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily: "Oswald-Regular",
                                            fontSize: 14,
                                            color: Color.fromRGBO(
                                                255, 196, 45, 1)),
                                      ),
                                      Text(
                                        "IIst : Rs" +
                                            widget.contest
                                                .data()["prizes"][1]
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily: "Oswald-Regular",
                                            fontSize: 14,
                                            color: Color.fromRGBO(
                                                222, 226, 230, 1)),
                                      ),
                                      Text(
                                        "IIIst : Rs" +
                                            widget.contest
                                                .data()["prizes"][2]
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily: "Oswald-Regular",
                                            fontSize: 14,
                                            color: Color.fromRGBO(
                                                212, 162, 118, 1)),
                                      ),
                                    ],
                                  )
                                : SizedBox()),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 4 / 6,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Rules and Regulations :",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 200, 87, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 4 / 6,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.contest.data()["regulation"],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 4 / 6,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Note : " +
                        (widget.contest.data()["paid"]
                            ? "This is a paid contest. To participate please pay the given amount and have a chance to win rewards."
                            : "This is a free contest. You can directly participate and have a chance to win rewards."),
                    style: TextStyle(
                        color: Color(0xff00FF94),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    if (widget.contest.data()["paid"]) {
                      print("pay Rs${widget.contest.data()["fees"]}");
                    } else {
                      FirebaseFirestore.instance
                          .collection("Contests")
                          .doc(widget.contest.id)
                          .update({
                        "participants": FieldValue.arrayUnion(
                            [FirebaseAuth.instance.currentUser.uid])
                      });

                      DocumentSnapshot snap = await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .get();

                      UserModel user = UserModel.fromDocument(snap);

                      FirebaseFirestore.instance
                          .collection("Contests")
                          .doc(widget.contest.id)
                          .collection("Participants")
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .set({
                        "name": user.username,
                        "profileid": user.documentid,
                        "profileurl": user.photourl,
                        "uploadurl": [],
                        "voters": [],
                      });

                      Navigator.of(context).pop();
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return ThankYouPopup(
                              contest: widget.contest,
                            );
                          });
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 200, 87, 1),
                        border: Border.all(
                            color: Color.fromRGBO(255, 160, 100, 1), width: 2)),
                    alignment: Alignment.center,
                    child: Text(
                      widget.contest.data()["paid"]
                          ? "Pay Rs${widget.contest.data()["fees"]}"
                          : "Participate",
                      style: TextStyle(
                          color: Color.fromRGBO(27, 38, 44, 1),
                          fontSize: 20,
                          fontFamily: "Oswald-Regular",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )),
    );
  }
}

class SubmissionPopup extends StatefulWidget {
  final DocumentSnapshot contest;
  final DocumentSnapshot member;
  const SubmissionPopup({Key key, this.contest, this.member}) : super(key: key);

  @override
  _SubmissionPopupState createState() => _SubmissionPopupState();
}

class _SubmissionPopupState extends State<SubmissionPopup> {
  List<File> image = [];
  List<String> uploadedImages = [];
  final picker = ImagePicker();
  bool loading = false;
  Future<File> getImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    return File(pickedImage.path);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < widget.contest.data()["submissionNumber"]; i++) {
      image.add(null);
    }

    for (int i = 0; i < widget.member.data()["uploadurl"].length; i++) {
      uploadedImages.add(widget.member.data()["uploadurl"][i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.transparent, //Color(0xff1B262C),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: MediaQuery.of(context).size.width * 4 / 5,
            decoration: BoxDecoration(
              color: Color.fromRGBO(27, 38, 44, 1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color.fromRGBO(0, 255, 148, 1),
                width: 2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Submission',
                    style: TextStyle(
                        color: Color(0xffFFC857),
                        fontSize: 34,
                        fontFamily: 'Oswald-Regular',
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    widget.contest.data()["headline"],
                    style: TextStyle(
                        color: Color(0xff00FF94),
                        fontSize: 20,
                        fontFamily: 'Oswald-Regular',
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Rewards",
                    style: TextStyle(
                        color: Color(0xff00FF94),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 4 / 5,
                    height: 40,
                    child: widget.contest.data()["prizes"].length == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Ist : Rs" +
                                    widget.contest
                                        .data()["prizes"][0]
                                        .toString(),
                                style: TextStyle(
                                    fontFamily: "Oswald-Regular",
                                    fontSize: 14,
                                    color: Color.fromRGBO(255, 196, 45, 1)),
                              )
                            ],
                          )
                        : widget.contest.data()["prizes"].length == 2
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Ist : Rs" +
                                        widget.contest
                                            .data()["prizes"][0]
                                            .toString(),
                                    style: TextStyle(
                                        fontFamily: "Oswald-Regular",
                                        fontSize: 14,
                                        color: Color.fromRGBO(255, 196, 45, 1)),
                                  ),
                                  Text(
                                    "IIst : Rs" +
                                        widget.contest
                                            .data()["prizes"][1]
                                            .toString(),
                                    style: TextStyle(
                                        fontFamily: "Oswald-Regular",
                                        fontSize: 14,
                                        color:
                                            Color.fromRGBO(222, 226, 230, 1)),
                                  ),
                                ],
                              )
                            : widget.contest.data()["prizes"].length == 3
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Ist : Rs" +
                                            widget.contest
                                                .data()["prizes"][0]
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily: "Oswald-Regular",
                                            fontSize: 14,
                                            color: Color.fromRGBO(
                                                255, 196, 45, 1)),
                                      ),
                                      Text(
                                        "IIst : Rs" +
                                            widget.contest
                                                .data()["prizes"][1]
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily: "Oswald-Regular",
                                            fontSize: 14,
                                            color: Color.fromRGBO(
                                                222, 226, 230, 1)),
                                      ),
                                      Text(
                                        "IIIst : Rs" +
                                            widget.contest
                                                .data()["prizes"][2]
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily: "Oswald-Regular",
                                            fontSize: 14,
                                            color: Color.fromRGBO(
                                                212, 162, 118, 1)),
                                      ),
                                    ],
                                  )
                                : SizedBox()),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 4 / 6,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Rules and Regulations :",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 200, 87, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 4 / 6,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.contest.data()["regulation"],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 4 / 6,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Upload :",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 200, 87, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 4 / 6,
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.contest.data()["submissionNumber"],
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 100,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff1B262C),
                            border: Border.all(
                              color: Color(0xffB2B2B2),
                              width: 1,
                            ),
                          ),
                          child: GestureDetector(
                              onTap: () async {
                                if (uploadedImages.length <= index) {
                                  await getImage().then((imag) {
                                    setState(() {
                                      image[index] = imag;
                                    });
                                  });
                                }
                              },
                              child: image[index] != null ||
                                      uploadedImages.length > index
                                  ? FittedBox(
                                      fit: BoxFit.fill,
                                      child: uploadedImages.length > index
                                          ? Image.network(uploadedImages[index])
                                          : Image.file(
                                              image[index],
                                            ))
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 26,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xffB2B2B2),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            size: 26,
                                          ),
                                        ),
                                      ],
                                    )),
                        );
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 4 / 6,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Note : Once You post it, it cannot be changed.",
                    style: TextStyle(
                        color: Color(0xff00FF94),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                loading
                    ? Loading()
                    : InkWell(
                        onTap: () async {
                          if (widget.contest.data()["submissionNumber"] ==
                              uploadedImages.length) {
                            Navigator.of(context).pop();
                          } else {
                            setState(() {
                              loading = true;
                            });
                            for (int i = 0;
                                i < widget.contest.data()["submissionNumber"];
                                i++) {
                              if (uploadedImages.length <= i &&
                                  image[i] != null)
                                await uploadImageToFirebase(context, i);
                            }
                            setState(() {
                              loading = false;
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 2 / 3,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 200, 87, 1),
                              border: Border.all(
                                  color: Color.fromRGBO(255, 160, 100, 1),
                                  width: 2)),
                          alignment: Alignment.center,
                          child: Text(
                            widget.contest.data()["submissionNumber"] ==
                                    uploadedImages.length
                                ? "Close"
                                : "Submit",
                            style: TextStyle(
                                color: Color.fromRGBO(27, 38, 44, 1),
                                fontSize: 20,
                                fontFamily: "Oswald-Regular",
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )),
    );
  }

  Future uploadImageToFirebase(BuildContext context, int index) async {
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
        'contests/${widget.contest.id}/${FirebaseAuth.instance.currentUser.uid}/${getRandString(6)}');
    UploadTask uploadTask = firebaseStorageRef.putFile(image[index]);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("Contests")
        .doc(widget.contest.id)
        .collection("Participants")
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
}

class ThankYouPopup extends StatelessWidget {
  final DocumentSnapshot contest;

  const ThankYouPopup({Key key, this.contest}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.transparent, //Color(0xff1B262C),
        contentPadding: EdgeInsets.zero,
        content: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff1B262C),
                border: Border.all(
                  width: 3,
                  color: Color(0xff00FF94),
                )),
            height: MediaQuery.of(context).size.width * 4 / 5 + 100,
            width: MediaQuery.of(context).size.width * 4 / 5,
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Container(
                  width: 135,
                  height: 135,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/Images/Group 113.png"),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Successfully Participated",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Oswald-Regular",
                      color: Color.fromRGBO(255, 200, 87, 1)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "in",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Oswald-Regular",
                      color: Color.fromRGBO(255, 200, 87, 1)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  contest.data()["contestName"],
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Oswald-Regular",
                      color: Color.fromRGBO(255, 200, 87, 1)),
                ),
              ],
            )),
      ),
    );
  }
}
