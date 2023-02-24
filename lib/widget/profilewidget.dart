import 'package:flutter/material.dart';
import 'package:testerr/theme.dart';

class ProfileTile extends StatelessWidget {
  final String text;
  final IconData icon;
  ProfileTile(this.text, this.icon);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.white,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon),
            ),
            Text(
              text,
              style: regularTextStyle.copyWith(
                  color: Colors.grey[500], fontWeight: FontWeight.normal),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
