import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_app/tabbar.dart';
import 'package:flutter/material.dart';

class FriendInfosWidget extends StatelessWidget {
  final CollectionReference users;
  final String otherId;
  const FriendInfosWidget({Key key, this.otherId, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(otherId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Row(
            children: [
              SizedBox(
                  height: 24,
                  width: 24,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.arrow_back_ios_outlined),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabBarOrientation()));
                    },
                  )),
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(data['photoUrl']),
              ),
              Padding(padding: EdgeInsets.only(left: 8), child: Text(data['nickname']))
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
