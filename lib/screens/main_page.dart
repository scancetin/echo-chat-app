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
    return Column(
      children: [
        UsersWidget(pageType: "Main", searchingWord: "null", user: user, users: users),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.all(15),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
