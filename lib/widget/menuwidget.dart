import 'package:flutter/material.dart';
import 'package:testerr/theme.dart';

class MenuBar extends StatelessWidget {
  final String imageUrl;
  MenuBar({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: bgBlue, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(imageUrl))),
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imageUrl;
  final String nameCat;
  Category(this.imageUrl, this.nameCat);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 4, 30),
      child: Column(
        children: [
          Card(
            shadowColor: Colors.blue,
            surfaceTintColor: Colors.blue,
            semanticContainer: true,
            elevation: 10,
            borderOnForeground: true,
            child: SizedBox(
              height: 47,
              width: 100,
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage(imageUrl),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                nameCat,
                style: regularTextStyle.copyWith(
                    color: Colors.grey[600], fontSize: 13),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Bannerr extends StatelessWidget {
  //final String imageUrl;
  final Color warna;
  final String katakata;
  Bannerr(this.warna, this.katakata);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 250,
          height: 150,
          decoration: BoxDecoration(
            color: warna,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.format_quote_sharp,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  katakata,
                  style: regularTextStyle.copyWith(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 180),
                child: Icon(
                  Icons.format_quote_sharp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
