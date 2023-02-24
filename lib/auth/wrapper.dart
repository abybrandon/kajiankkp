import 'package:flutter/material.dart';
import 'package:testerr/auth/LoginDummy.dart';
import 'package:testerr/login/login.dart';
import 'package:testerr/login/signup.dart';
import 'package:testerr/page/homepage.dart';
import 'package:testerr/widget/navigationbar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User firebaseUser = Provider.of<User>(context);
    return (firebaseUser == null) ? Login() : NavigatorScreen();
  }
}
