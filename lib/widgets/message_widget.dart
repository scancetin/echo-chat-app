import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  final User currentUser;
  final String otherId;
  final CollectionReference chats;
  const MessageWidget({Key key, this.currentUser, this.otherId, this.chats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ids = [currentUser.uid, otherId];
    ids.sort();
    final sortedIds = ids[0] + "-" + ids[1];

    return StreamBuilder<QuerySnapshot>(
        stream: chats.doc(sortedIds).collection("messages").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return Expanded(
            child: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return ListTile(
                  title: Align(
                      alignment: document.get("senderId") == currentUser.uid ? Alignment.bottomRight : Alignment.bottomLeft,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: document.get("senderId") == currentUser.uid ? Color(0xff3e6e62) : Color(0xFF3DBB9E),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(document.get("message")),
                          ),
                          Container(
                            child: Text(
                              DateFormat("dd MMM kk:mm").format(DateTime.fromMicrosecondsSinceEpoch(document.get("createdAt").microsecondsSinceEpoch)),
                              style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                            ),
                          )
                        ],
                      )),
                );
              }).toList(),
            ),
          );
        });
  }
}
