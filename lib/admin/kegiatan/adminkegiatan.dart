import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testerr/admin/kegiatan/detailkegiatanadmin.dart';
import 'package:testerr/admin/menuadmin.dart';
import 'package:testerr/admin/kegiatan/updatekegiatan.dart';
import 'package:testerr/provider/kegiatan_provider.dart';

import 'package:testerr/theme.dart';

import 'package:provider/provider.dart';

class AdminKegiatan extends StatefulWidget {
  @override
  State<AdminKegiatan> createState() => _AdminKegiatanState();
}

class _AdminKegiatanState extends State<AdminKegiatan> {
  @override
  void initState() {
    KegiatanNotifier kegiatanNotifier =
        Provider.of<KegiatanNotifier>(context, listen: false);
    getKegiatans(kegiatanNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    KegiatanNotifier kegiatanNotifier = Provider.of<KegiatanNotifier>(context);
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: GestureDetector(
              onTap: () {
                kegiatanNotifier.currentKegiatan =
                    kegiatanNotifier.kegiatanList[index];
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return DetailKegiatan();
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
                                image: NetworkImage(kegiatanNotifier
                                        .kegiatanList[index].gambar_kegiatan ??
                                    "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png"))),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        kegiatanNotifier.kegiatanList[index].nama_kegiatan ??
                            "",
                        textAlign: TextAlign.center,
                        style: regularTextStyle.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                          kegiatanNotifier
                                  .kegiatanList[index].tanggal_kegiatan ??
                              "",
                          style: regularTextStyle.copyWith(
                              color: Colors.white, fontSize: 13)),
                      Text(
                        kegiatanNotifier.kegiatanList[index].lokasi_kegiatan,
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          );
        },
        itemCount: kegiatanNotifier.kegiatanList.length,
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
          kegiatanNotifier.currentKegiatan = null;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return UpdateKegiatan(
              isUpdating: false,
            );
          }));
        },
      ),
    );
  }
}
