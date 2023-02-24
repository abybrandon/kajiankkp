import 'package:flutter/material.dart';
import 'package:testerr/admin/menuadmin.dart';
import 'package:testerr/auth/LoginDummy.dart';
import 'package:testerr/theme.dart';

class SplashLogin extends StatelessWidget {
  const SplashLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlue,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Select Ur Role",
                  style: titleTextStyle.copyWith(fontSize: 30),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => CobaLogin()));
                },
                child: Container(
                  height: 150,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: whiteColor,
                        blurRadius: 20,
                        offset: Offset(0, 10))
                  ], color: whiteColor),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/user.png"))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Center(
                          child: Text(
                            "Login as User",
                            style: titleTextStyle.copyWith(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminMenu()),
                  );
                },
                child: Container(
                  height: 150,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: whiteColor,
                        blurRadius: 20,
                        offset: Offset(0, 10))
                  ], color: whiteColor),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/adminn.png"))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Center(
                          child: Text(
                            "Login as Admin",
                            style: titleTextStyle.copyWith(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
