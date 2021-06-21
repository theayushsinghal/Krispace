import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:krispace/models/feed_model.dart';
import 'package:krispace/screens/home/feed/post.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  String postExistId;
  DocumentSnapshot user;
  FeedPage({postExistId, user});
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<DocumentSnapshot> _posts = [];
  bool _loadingPosts = true;
  bool _gettingMorePosts = false;
  bool _morePostsAvailable = true;

  DocumentSnapshot snapshot;
  ScrollController _scrollController = ScrollController();
  DocumentSnapshot _lastDocument;

  _getPosts() async {
    Query q = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("dateTime", descending: true)
        .limit(10);
    setState(() {
      _loadingPosts = true;
    });

    QuerySnapshot querySnapshot = await q.get();
    _posts = querySnapshot.docs;
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    if (this.mounted)
      setState(() {
        _loadingPosts = false;
      });
  }

  _getMorePosts() async {
    if (_morePostsAvailable == false) {
      print('no more posts');
      return;
    }
    if (_gettingMorePosts == true) {
      return;
    }
    _gettingMorePosts = true;
    Query q = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("dateTime", descending: true)
        .limit(10)
        .startAfter([_lastDocument.data()['creation_date']]).limit(10);

    QuerySnapshot querySnapshot = await q.get();
    if (querySnapshot.docs.length < 10) {
      _morePostsAvailable = false;
    }
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    _posts.addAll(querySnapshot.docs);
    setState(() {});
    _gettingMorePosts = false;
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        List<DocumentSnapshot> _posts = [];
        _loadingPosts = true;
        _gettingMorePosts = false;
        _morePostsAvailable = true;

        snapshot;
        _scrollController = new ScrollController();
        _lastDocument;
      });
      _getPosts();
      _scrollController.addListener(() {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.position.pixels;
        double delta = MediaQuery.of(context).size.height * 0.25;
        if (maxScroll - currentScroll <= delta) {
          _getMorePosts();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 60,
      onRefresh: () async {
        return Future.delayed(
          Duration(seconds: 1),
          () async {
            _getPosts();
            _scrollController.addListener(() {
              double maxScroll = _scrollController.position.maxScrollExtent;
              double currentScroll = _scrollController.position.pixels;
              double delta = MediaQuery.of(context).size.height * 0.25;
              if (maxScroll - currentScroll <= delta) {
                _getMorePosts();
              }
            });
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(child: Container(child: _buildListView(context))),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return _loadingPosts == true
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            child: _posts.length == 0
                ? Center(
                    child: Text("No posts to show"),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: _posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final post = FeedModel.fromFirebase(_posts[index]);
                      return ChangeNotifierProvider.value(
                        value: post,
                        child: Posts(),
                      );
                    },
                  ),
          );
  }
}
