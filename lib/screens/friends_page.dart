import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_app/widgets/users_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatefulWidget {
  FriendsPage({Key key}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  TextEditingController _searchController = TextEditingController();
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final User user = FirebaseAuth.instance.currentUser;
  String _searchingWord = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(hintText: "Search User", contentPadding: EdgeInsets.only(left: 5)),
                    controller: _searchController,
                  )),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _searchingWord = _searchController.text;
                      });
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      margin: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(color: Color(0xff5eedcb), shape: BoxShape.circle),
                      child: Icon(Icons.search, color: Colors.blueGrey[700], size: 23),
                    ),
                  ),
                ],
              ),
              UsersWidget(pageType: "Friends", searchingWord: _searchingWord, user: user, users: users)
            ],
          ),
        ),
      ),
    );
  }
}
