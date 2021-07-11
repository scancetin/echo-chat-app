import 'package:echo_app/providers/google_sign_in.dart';
import 'package:echo_app/screens/friends_page.dart';
import 'package:echo_app/screens/main_page.dart';
import 'package:echo_app/screens/sign_in_page.dart';
import 'package:echo_app/screens/status_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabBarOrientation extends StatefulWidget {
  TabBarOrientation({Key key}) : super(key: key);

  @override
  _TabBarOrientationState createState() => _TabBarOrientationState();
}

class _TabBarOrientationState extends State<TabBarOrientation> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text("ECHO", style: TextStyle(color: Color(0xff5eedcb))),
              actions: [
                ChangeNotifierProvider(
                    create: (context) => GoogleSignInProvider(),
                    builder: (context, snapshot) {
                      return GestureDetector(
                        onTap: () {
                          final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                          provider.logout();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(Icons.exit_to_app, color: Color(0xff5eedcb)),
                        ),
                      );
                    })
              ],
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: "Chats"),
                  Tab(text: "Friends"),
                  Tab(text: "Status"),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            MainPage(),
            FriendsPage(),
            StatusPage(),
          ],
        ),
      ),
    );
  }
}
