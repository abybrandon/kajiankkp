import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:testerr/auth/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:testerr/auth/auth_services.dart';

class LoginDummy extends StatelessWidget {
  const LoginDummy({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("Loginned"),
    ));
  }
}

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ini login page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 300,
              height: 100,
              child: TextField(
                decoration: InputDecoration(hintText: "Masukan email"),
                controller: emailController,
              ),
            ),
            Container(
              width: 300,
              height: 100,
              child: TextField(
                decoration: InputDecoration(hintText: "Masukan Password"),
                controller: passwordController,
              ),
            ),
           TextButton(
              onPressed: () async {
                await AuthServices.signInAnonymous();
              },
              child: Text("Sign in anonymous"),
            ),
            TextButton(
              onPressed: () async {
                await AuthServices.signIn(
                    emailController.text, passwordController.text);
              },
              child: Text("Sign in jika sudah daftar"),
            ),
            TextButton(
              onPressed: () async {
                await AuthServices.signUp(
                    emailController.text, passwordController.text);
              },
              child: Text("Sign up firebase"),
            ),
          ],
        ),
      ),
    );
  }
}

class CobaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.firebaseUserStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  final User user;
  MainPage(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ini Main page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user.uid),
            TextButton(
              child: Text("Log out"),
              onPressed: () async {
                await AuthServices.signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
