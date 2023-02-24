import 'package:flutter/material.dart';
import 'package:testerr/login/login.dart';
import 'package:testerr/theme.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testerr/widget/navigationbar.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showProgress = false;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  TextEditingController emailController1 = TextEditingController(text: "");

  TextEditingController passwordController1 = TextEditingController(text: "");

  bool _isObscure = true;
  bool _isObscure2 = true;
  File file;
  var options = [
    'User',
    'Admin',
  ];
  var _currentItemSelected = "User";
  var rool = "User";

  @override
  void dispose() {
    emailController1.dispose();
    passwordController1.dispose();

    super.dispose();
  }

  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(
                height: 40,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/logo.png'))),
                    ),
                    Text(
                      "Register",
                      style: titleTextStyle.copyWith(
                          color: whiteColor, fontSize: 40),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
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
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
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
                                      emailController1.text = value;
                                    },
                                    controller: emailController1,
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
                                      passwordController1.text = value;
                                    },
                                    obscureText: !_passwordVisible,
                                    controller: passwordController1,
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
                          SizedBox(
                            height: 30,
                          ),
                          DropdownButton<String>(
                            dropdownColor: Colors.blue[900],
                            isDense: true,
                            isExpanded: false,
                            iconEnabledColor: Colors.white,
                            focusColor: Colors.white,
                            items: options.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(
                                  dropDownStringItem,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValueSelected) {
                              setState(() {
                                _currentItemSelected = newValueSelected;
                                rool = newValueSelected;
                              });
                            },
                            value: _currentItemSelected,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                showProgress = true;
                              });
                              signUp(emailController1.text,
                                  passwordController1.text, rool);
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.orange[900]),
                              child: Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                "Already Have Account!",
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: const Text(
                                  "Log In",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ),
                            ],
                          ),
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

  void signUp(String email, String password, String rool) async {
    CircularProgressIndicator();
    if (_formkey.currentState.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, rool)})
          .catchError((e) {});
    }
  }

  postDetailsToFirestore(String email, String rool) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user.uid).set({'email': emailController1.text, 'rool': rool});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }
}
