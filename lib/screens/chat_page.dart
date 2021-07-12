import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_app/widgets/friend_infos_widget.dart';
import 'package:echo_app/widgets/message_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatPage extends StatefulWidget {
  final String otherId;
  ChatPage({Key key, this.otherId}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState(otherId: otherId);
}

class _ChatPageState extends State<ChatPage> {
  _ChatPageState({this.otherId});

  final String otherId;
  final User user = FirebaseAuth.instance.currentUser;
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    createChatrooms();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Color(0xff3DBB9E),
        title: FriendInfosWidget(otherId: otherId, users: users),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          MessageWidget(chats: chats, user: user, otherId: otherId),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff3e6e62),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(3),
                  padding: EdgeInsets.only(left: 15),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(hintText: "Say Hi!", hintStyle: TextStyle(color: Color(0xFF3DBB9E), fontStyle: FontStyle.italic)),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff3e6e62),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(right: 3, top: 3, bottom: 3),
                child: IconButton(
                  icon: Icon(Icons.eco_sharp),
                  onPressed: () {
                    createMessages(messageController.text);
                    messageController.text = "";
                  },
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future createChatrooms() async {
    final ids = [user.uid, otherId];
    ids.sort();
    final sortedIds = ids[0] + "-" + ids[1];

    if (user != null) {
      final QuerySnapshot result = await chats.where('userIds', isEqualTo: sortedIds).get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        chats.doc(sortedIds).set({
          "user1id": user.uid,
          "user2id": otherId,
          "userIds": sortedIds,
          "createdAt": DateTime.now(),
        });
        Fluttertoast.showToast(msg: "Chat Created Successfully");
      }
    }
  }

  Future createMessages(message) async {
    final ids = [user.uid, otherId];
    ids.sort();
    final sortedIds = ids[0] + "-" + ids[1];

    if (user != null && message.trim() != "") {
      chats.doc(sortedIds).collection("messages").doc((DateTime.now().millisecondsSinceEpoch).toString()).set({
        "senderId": user.uid,
        "message": message.trim(),
        "createdAt": DateTime.now(),
      });
    }
  }
}
