import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Wallet extends StatefulWidget {
  final DocumentSnapshot user;

  const Wallet({Key key, this.user}) : super(key: key);
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool accountEditable = false;
  bool upiEditable = false;
  TextEditingController bankAccount;
  TextEditingController upi;

  @override
  void initState() {
    super.initState();
    bankAccount =
        new TextEditingController(text: widget.user.data()["account_no"]);
    upi = new TextEditingController(text: widget.user.data()["UPI_id"]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 80,
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            "Krispace Wallet",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: "Oswald-Regular"),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 136,
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: Colors.white, width: 0.5),
            bottom: BorderSide(color: Colors.white, width: 0.5),
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "My Earnings",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.money_dollar_circle,
                          color: Color(0xffFFC857),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Rs. " + widget.user.data()["Balance"].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff00FF94),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff1B262C),
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(width: 1, color: Color(0xffFFC857)),
                      ),
                      width: 160,
                      height: 26,
                      child: Center(
                        child: Text(
                          "View History",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Color(0xffFFC857),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 136,
                width: 0.5,
                color: Colors.white,
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "My Balance",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.money_dollar_circle,
                          color: Color(0xffFFC857),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Rs. " + widget.user.data()["Balance"].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff00FF94),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff1B262C),
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(width: 1, color: Color(0xffFFC857)),
                      ),
                      width: 160,
                      height: 26,
                      child: Center(
                        child: Text(
                          "Redeem Now",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Color(0xffFFC857),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.white, width: 0.5),
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Bank Account",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (accountEditable) {
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .update({
                          "account_no": bankAccount.text,
                        });
                      }
                      setState(() {
                        accountEditable = !accountEditable;
                      });
                    },
                    child: Container(
                      width: 60,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          accountEditable
                              ? Text(
                                  "Done",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green),
                                )
                              : SizedBox(),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            accountEditable
                                ? FontAwesomeIcons.checkSquare
                                : FontAwesomeIcons.edit,
                            size: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              accountEditable
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Account Number:",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          height: 25,
                          color: Colors.white,
                          child: TextField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: bankAccount,
                            style: TextStyle(fontSize: 14),
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
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.university,
                          color: Color(0xffFFC857),
                          size: 14,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          bankAccount.text.substring(0, 5) +
                              "XXXXX" +
                              bankAccount.text.substring(10),
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff00FF94),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.white, width: 0.5),
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My UPI ID",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (upiEditable) {
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .update({
                          "UPI_id": upi.text,
                        });
                      }
                      setState(() {
                        upiEditable = !upiEditable;
                      });
                    },
                    child: Container(
                      width: 60,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          upiEditable
                              ? Text(
                                  "Done",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green),
                                )
                              : SizedBox(),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            upiEditable
                                ? FontAwesomeIcons.checkSquare
                                : FontAwesomeIcons.edit,
                            size: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              upiEditable
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "UPI ID:",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          height: 25,
                          color: Colors.white,
                          child: TextField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: upi,
                            style: TextStyle(fontSize: 14),
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
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.caretRight,
                          color: Color(0xffFFC857),
                          size: 14,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          upi.text,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff00FF94),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
        Container(
          height: 94,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.white, width: 0.5),
          )),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Referal Link",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.link,
                        color: Color(0xffFFC857),
                        size: 17,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.user.data()["referal_link"].toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff00FF94),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        FontAwesomeIcons.shareAlt,
                        color: Colors.white,
                        size: 17,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.copy,
                        color: Color(0xffFFC857),
                        size: 17,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
            height: 90,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Manage Subscription",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff1B262C),
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(width: 1, color: Color(0xffFFC857)),
                  ),
                  width: 100,
                  height: 26,
                  child: Center(
                    child: Text(
                      "My Subscriptiion",
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Color(0xffFFC857),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            )),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
