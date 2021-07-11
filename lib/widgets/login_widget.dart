import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_app/providers/google_sign_in.dart';
import 'package:echo_app/tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.only(bottom: 100),
            child: GestureDetector(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(100)),
                child: Text("Sign In with Google", style: TextStyle(color: Colors.black, fontSize: 18)),
              ),
              onTap: () {
                final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                if (snapshot.hasData) {
                  addToFirestore();
                } else {
                  provider.login();
                }
              },
            ),
          );
        });
  }

  Future addToFirestore() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final currentUser = auth.currentUser;

    if (currentUser != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('id', isEqualTo: currentUser.uid).get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
          "nickname": currentUser.displayName,
          "photoUrl": currentUser.photoURL,
          "id": currentUser.uid,
          "createdAt": DateTime.now(),
          "chattingWith": "",
          "friends": "",
          "status": "About Me"
        });
      }
      print(currentUser.displayName);
      print(currentUser.email);
      print(currentUser.photoURL);

      Fluttertoast.showToast(msg: "Login Succesfully");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabBarOrientation()));
    }
  }
}
