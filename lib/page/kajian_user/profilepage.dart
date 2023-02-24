import 'package:flutter/material.dart';
import 'package:testerr/main.dart';
import 'package:testerr/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
              clipper: MyClipper(),
              child: Container(
                color: bgBlue,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 40, 0, 10),
                child: Text(
                  "Jadwal Kajian",
                  style: titleTextStyle.copyWith(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                child: Text(
                  "Masjid Nurul Qalbi Sakinah",
                  style: titleTextStyle.copyWith(fontSize: 24),
                ),
              ),
              SizedBox(
                height: 90,
              ),
              Container(
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(width: 3, color: bgBlue))),
              ),
              Expanded(child: Dummy())
            ],
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 220);
    path.quadraticBezierTo(size.width / 4, 160 /*180*/, size.width / 2, 175);
    path.quadraticBezierTo(3 / 4 * size.width, 190, size.width, 130);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
