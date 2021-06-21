import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminWallet extends StatefulWidget {
  @override
  _AdminWalletState createState() => _AdminWalletState();
}

class _AdminWalletState extends State<AdminWallet> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .orderBy("state", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator()))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pending Payments",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: "Oswald-Regular"),
                          ),
                          Icon(
                            Icons.download_sharp,
                            color: Colors.white,
                            size: 24,
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
                            "Users Earning List",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Pending Payments : ",
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
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return userListTab(snapshot.data.docs[index]);
                            })),
                  ],
                );
        });
  }

  Widget userListTab(DocumentSnapshot data) {
    return Container(
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
                  CircleAvatar(),
                  SizedBox(
                    width: 13,
                  ),
                  Text(
                    data.data()["userid"],
                    style: TextStyle(
                        color: Color.fromRGBO(249, 252, 251, 1), fontSize: 12),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Text(
                    "( Rs. ${data.data()["wallet"]} )",
                    style: TextStyle(
                        color: Color.fromRGBO(0, 255, 148, 1), fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              height: 20,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                    color: Color.fromRGBO(255, 200, 87, 1), width: 0.5),
              ),
              child: Container(
                child: Center(
                  child: Text(
                    "Pay ",
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Color.fromRGBO(255, 200, 87, 1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
