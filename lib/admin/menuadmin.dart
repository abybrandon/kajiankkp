import 'package:flutter/material.dart';
import 'package:testerr/admin/kegiatan/adminkegiatan.dart';
import 'package:testerr/admin/organisasi/adminorganisasi.dart';
import 'package:testerr/login/login.dart';
import 'package:testerr/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'kajian/adminkajian.dart';

class AdminMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: bgBlue,
          centerTitle: true,
          title: Text("Menu Admin", style: regularTextStyle),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  logout(context);
                },
              ),
            ),
          ]),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return AdminKajian();
              }));
            },
            child: Container(
              height: 180,
              width: double.infinity,
              color: bgBlue,
              child: Center(
                  child: Text(
                "Jadwal Kajian",
                style: regularTextStyle.copyWith(
                    color: Colors.white, fontSize: 25),
              )),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return AdminKegiatan();
              }));
            },
            child: Container(
              height: 180,
              width: double.infinity,
              color: bgBlue,
              child: Center(
                  child: Text("Kegiatan Masjid",
                      style: regularTextStyle.copyWith(
                          color: Colors.white, fontSize: 25))),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return AdminOrganisasi();
              }));
            },
            child: Container(
              height: 180,
              width: double.infinity,
              color: bgBlue,
              child: Center(
                  child: Text("Profile Organisasi",
                      style: regularTextStyle.copyWith(
                          color: Colors.white, fontSize: 25))),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> logout(BuildContext context) async {
  CircularProgressIndicator();
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => Login(),
    ),
  );
}
