import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_app/screens/search_page.dart';
import 'package:echo_app/widgets/users_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(5),
          child: UsersWidget(pageType: "Main", searchingWord: "null", user: user, users: users),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchPage()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
