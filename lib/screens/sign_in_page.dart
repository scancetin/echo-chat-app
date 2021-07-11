import 'package:echo_app/providers/google_sign_in.dart';
import 'package:echo_app/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => GoogleSignInProvider(),
            builder: (context, snapshot) {
              return Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(bottom: 100),
                      child: Icon(Icons.eco_sharp, color: Color(0xff5eedcb), size: 250),
                    ),
                    LoginWidget()
                  ],
                ),
              );
            }),
      ),
    );
  }
}
