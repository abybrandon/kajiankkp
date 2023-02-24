import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testerr/admin/kajian/detailkajianadmin.dart';
import 'package:testerr/admin/menuadmin.dart';
import 'package:testerr/admin/kajian/updatekajian.dart';

import 'package:testerr/theme.dart';

import 'package:provider/provider.dart';

import 'package:testerr/provider/dummy_provider.dart';

class AdminKajian extends StatefulWidget {
  @override
  State<AdminKajian> createState() => _AdminKajianState();
}

class _AdminKajianState extends State<AdminKajian> {
  @override
  void initState() {
    KajianNotifier kajianNotifier =
        Provider.of<KajianNotifier>(context, listen: false);
    getKajians(kajianNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    KajianNotifier kajianNotifier = Provider.of<KajianNotifier>(context);
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: GestureDetector(
              onTap: () {
                kajianNotifier.currentKajian = kajianNotifier.kajianList[index];
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return DetailKajianAdmin();
                }));
              },
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight,
                        colors: [
                          Color(0xFF004558),
                          bgBlue,
                          Color(0xFF8AE1F7)
                        ])),
                child: Row(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 120,
                        width: 140,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(kajianNotifier
                                        .kajianList[index].gambar ??
                                    "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png"))),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        kajianNotifier.kajianList[index].tema_kajian ?? "",
                        textAlign: TextAlign.center,
                        style: regularTextStyle.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(kajianNotifier.kajianList[index].nama_ustad ?? "",
                          style: regularTextStyle.copyWith(
                              color: Colors.white, fontSize: 13)),
                      Text(
                       kajianNotifier.kajianList[index].tanggal_kajian ?? "",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          );
        },
        itemCount: kajianNotifier.kajianList.length,
        separatorBuilder: (BuildContext context, int index) {
          // ignore: prefer_const_constructors
          return Divider(
            color: Colors.white,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.red,
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: () {
          kajianNotifier.currentKajian = null;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return UpdateKajian(
              isUpdating: false,
            );
          }));
        },
      ),
    );
  }
}
