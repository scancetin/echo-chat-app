import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_app/screens/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsersWidget extends StatelessWidget {
  final CollectionReference users;
  final User user;
  final String searchingWord;
  final String pageType;
  const UsersWidget({Key key, this.searchingWord, this.user, this.users, this.pageType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return Expanded(
          child: new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              if (getTypeResult(pageType, document)) {
                return Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  color: Colors.teal[800],
                  child: new ListTile(
                    leading: new CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(document.get("photoUrl")),
                    ),
                    title: new Text(document.get("nickname")),
                    subtitle: new Text(document.get("status")),
                    trailing: GestureDetector(
                      onTap: () {
                        if (pageType == "Search") {
                          addToFriends(document.get("id"), document.get("friends"), document.get("chattingWith"));
                        }
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatPage(otherId: document.get("id"))));
                      },
                      child: Icon(Icons.eco_sharp, color: Color(0xff5eedcb), size: 40),
                    ),
                  ),
                );
              }
            }).toList(),
          ),
        );
      },
    );
  }

  bool getTypeResult(pageType, document) {
    if (pageType == "Main") {
      return document.get("chattingWith").contains(user.uid);
    } else if (pageType == "Friends") {
      return document.get("friends").contains(user.uid) && document.get("nickname").contains(searchingWord);
    } else if (pageType == "Search") {
      return searchingWord != "" && document.get("nickname").contains(searchingWord) && document.get("id") != user.uid;
    } else {
      return false;
    }
  }

  Future<void> addToFriends(otherId, friends, chattingWith) async {
    if (!friends.contains(user.uid)) {
      users.doc(otherId).update({"friends": friends + "-" + user.uid}).then((value) => print("Friend Added")).catchError((error) => print("Failed to update user: $error"));
      users
          .doc(otherId)
          .update({"chattingWith": chattingWith + "-" + user.uid})
          .then((value) => print("Friend Added"))
          .catchError((error) => print("Failed to update user: $error"));
      users.doc(user.uid).update({"chattingWith": otherId}).then((value) => print("Friend Added")).catchError((error) => print("Failed to update user: $error"));
    }
  }
}
