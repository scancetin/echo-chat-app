import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_app/tabbar.dart';
import 'package:echo_app/widgets/users_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final User user = FirebaseAuth.instance.currentUser;
  TextEditingController _searchController = TextEditingController();
  String _searchingWord = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ECHO", style: TextStyle(color: Color(0xff5eedcb)))),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: TextField(
                      decoration: InputDecoration(hintText: "Search User", contentPadding: EdgeInsets.only(left: 5)),
                      controller: _searchController,
                    )),
                Expanded(
                  child: GestureDetector(
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
                ),
              ],
            ),
          ),
          UsersWidget(pageType: "Search", searchingWord: _searchingWord, user: user, users: users)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabBarOrientation()));
        },
        child: Icon(Icons.arrow_back_ios_outlined),
      ),
    );
  }
}
