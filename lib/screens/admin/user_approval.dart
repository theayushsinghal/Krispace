import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krispace/models/user.dart';
import 'package:krispace/screens/admin/user_profile.dart';

class AdminApproval extends StatefulWidget {
  @override
  _AdminApprovalState createState() => _AdminApprovalState();
}

class _AdminApprovalState extends State<AdminApproval> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .where("type", isEqualTo: "User")
            .where("state", isEqualTo: "Pending")
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
                            "Pending Approvals",
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
                            "Users Request List",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Pending Approvals : ${snapshot.data.docs.length}",
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
                            }))
                  ],
                );
        });
  }

  Widget userListTab(DocumentSnapshot data) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(
              userModel: UserModel.fromDocument(data),
            ),
          ),
        );
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
                          image: DecorationImage(
                            image: NetworkImage(data.data()["url"]),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                          color: Colors.blueGrey,
                          border: Border.all(
                              color: Color.fromRGBO(0, 255, 148, 1))),
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Text(
                      data.data()["name"],
                      style: TextStyle(
                          color: Color.fromRGBO(249, 252, 251, 1),
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              data.data()["state"] == "Pending"
                  ? Container(
                      width: 56,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                            color: Color.fromRGBO(0, 255, 148, 1), width: 0.5),
                      ),
                      child: Center(
                        child: Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Color.fromRGBO(0, 255, 148, 0.8),
                          ),
                        ),
                      ),
                    )
                  : Container(
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
                            "Approved",
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Color.fromRGBO(178, 178, 178, 1),
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
  }
}
