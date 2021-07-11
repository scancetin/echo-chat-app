import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StatusPage extends StatefulWidget {
  StatusPage({Key key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAbout = TextEditingController();
  final User user = FirebaseAuth.instance.currentUser;
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(user.uid).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(data["photoUrl"]),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(hintText: data["nickname"], contentPadding: EdgeInsets.only(left: 5)),
                  controller: _controllerName,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(hintText: data["status"], contentPadding: EdgeInsets.only(left: 5)),
                  controller: _controllerAbout,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 50),
                child: GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(100)),
                    child: Text("Update Profile", style: TextStyle(color: Colors.black, fontSize: 18)),
                  ),
                  onTap: () {
                    updateUser();
                  },
                ),
              )
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<void> updateUser() {
    if (_controllerAbout.text.length > 3) {
      users.doc(user.uid).update({"status": _controllerAbout.text}).then((value) => print("User Updated")).catchError(
            (error) => print("Failed to update user: $error"),
          );
    }
    if (_controllerName.text.length > 3) {
      users.doc(user.uid).update({"nickname": _controllerName.text}).then((value) => print("User Updated")).catchError(
            (error) => print("Failed to update user: $error"),
          );
      return Fluttertoast.showToast(msg: "Updated Succesfully");
    } else {
      return Fluttertoast.showToast(msg: "Update Error");
    }
  }
}
