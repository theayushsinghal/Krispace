import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  final String profileName;
  final String username;
  final String photourl;
  final String bio;
  final String type;
  final String state;
  final String referal;
  final String documentid;

  UserModel(
      {this.profileName,
      this.username,
      this.photourl,
      this.bio,
      this.documentid,
      this.state,
      this.type,
      this.referal});

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      documentid: doc.id,
      username: doc.data()['userid'],
      photourl: doc.data()['url'] ?? "none",
      profileName: doc.data()['name'],
      bio: doc.data()['bio'],
      state: doc.data()['state'],
      type: doc.data()['type'],
      referal: doc.data()['referal_link'],
    );
  }
}
