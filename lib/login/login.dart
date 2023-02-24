import 'package:flutter/material.dart';
import 'package:testerr/admin/menuadmin.dart';
import 'package:testerr/login/signup.dart';
import 'package:testerr/page/homepage.dart';
import 'package:testerr/page/splash_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testerr/theme.dart';
import 'package:testerr/widget/navigationbar.dart';
import '../auth/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _passwordVisible;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter, colors: [bgBlue, whiteColor])),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 140,
                      width: 140,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/logo.png'))),
                    ),
                    Text(
                      "SIGN IN",
                      style: titleTextStyle.copyWith(
                          color: whiteColor, fontSize: 40),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: const Radius.circular(60))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 60,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: bgBlue,
                                      blurRadius: 20,
                                      offset: const Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Email cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      emailController.text = value;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        hintText: "Email Address",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Password cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      passwordController.text = value;
                                    },
                                    keyboardType: TextInputType.text,
                                    obscureText: !_passwordVisible,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                        ),
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                "Don't have an account! ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                visible = true;
                              });
                              signIn(emailController.text,
                                  passwordController.text);
                            },
                            child: Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.green[800]),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              visible: visible,
                              child: Container(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ))),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void route() {
    User user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "Admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminMenu(),
            ),
          );
        } else {
          (documentSnapshot.get('rool') == "User");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NavigatorScreen(),
            ),
          );
        }
      } else {
        var snackBar = SnackBar(content: Text("Belum Regist"));
        return ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>> signIn(
      String email, String password) async {
    if (_formkey.currentState.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          var snackBar = SnackBar(content: Text(e.code));
          return ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          var snackBar = SnackBar(content: Text(e.code));
          return ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
