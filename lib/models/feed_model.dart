import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedModel with ChangeNotifier {
  final String postId;
  final String ownerId;
  final Timestamp timestamp;
  List likes;
  int comments;
  final String username;
  final String headline;
  final String description;
  final String feedurl;
  final String userurl;
  final bool paid;
  final DocumentSnapshot documentSnapshot;

  FeedModel(
      {this.postId,
      this.ownerId,
      this.timestamp,
      this.likes,
      this.username,
      this.headline,
      this.description,
      this.feedurl,
      this.userurl,
      this.paid,
      this.comments,
      this.documentSnapshot});

  factory FeedModel.fromFirebase(DocumentSnapshot doc) {
    final map = doc.data();
    return FeedModel(
      postId: map["postId"],
      ownerId: map["ownerId"],
      timestamp: map["dateTime"],
      likes: map["likes"],
      username: map["username"],
      description: map["description"],
      headline: map["headline"],
      feedurl: map["feedurl"],
      userurl: map["profileurl"],
      paid: map["paid"],
      comments: map["comments"],
      documentSnapshot: doc,
    );
  }
}
