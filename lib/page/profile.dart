import 'package:flutter/material.dart';
import 'package:testerr/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testerr/widget/profilewidget.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: getClipper(),
            child: Container(
              color: bgBlue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 10, 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("Profile Page",
                    style: titleTextStyle.copyWith(
                        fontSize: 35, color: Colors.white))),
          ),
          Positioned(
            width: 400.0,
            top: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: <Widget>[
                Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(user.photoURL ??
                              "https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ]),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10)),
                  height: 130,
                  width: MediaQuery.of(context).size.width * 0.89,
                  child: Column(
                    children: <Widget>[
                      ProfileTile(
                          "Username : Abybrandon ", Icons.verified_user),
                      ProfileTile("Email :  " + user.email, Icons.email),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 250,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // ignore: todo
    // TODO: implement shouldReclip
    return true;
  }
}
