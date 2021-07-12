import 'package:echo_app/providers/google_sign_in.dart';
import 'package:echo_app/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class SignIn extends StatefulWidget {
//   SignIn({Key key}) : super(key: key);
//   @override
//   _SignInState createState() => _SignInState();
// }

class SignInPage extends StatelessWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          builder: (context, snapshot) {
            return Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Icon(Icons.eco_sharp, color: Color(0xff5eedcb), size: 250),
                ),
                Expanded(
                  child: LoginWidget(),
                ),
                Spacer(),
              ],
            );
          }),
    );
  }
}
