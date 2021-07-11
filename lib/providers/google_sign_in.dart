import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSignIn;

  GoogleSignInProvider() {
    _isSignIn = false;
  }

  bool get isSignIn => _isSignIn;

  set isSignIn(bool isSignIn) {
    _isSignIn = isSignIn;
    notifyListeners();
  }

  Future login() async {
    isSignIn = true;
    final user = await googleSignIn.signIn();
    if (user == null) {
      isSignIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      isSignIn = false;
    }
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
