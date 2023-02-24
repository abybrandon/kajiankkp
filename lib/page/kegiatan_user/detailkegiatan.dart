import 'package:flutter/material.dart';
import 'package:testerr/admin/kegiatan/updatekegiatan.dart';
import 'package:testerr/provider/kegiatan_provider.dart';
import 'package:testerr/provider/model_dummy.dart';

import 'package:testerr/theme.dart';
import 'package:provider/provider.dart';

class DetailKegiatanUser extends StatefulWidget {
  @override
  State<DetailKegiatanUser> createState() => _DetailKegiatanUserState();
}

class _DetailKegiatanUserState extends State<DetailKegiatanUser> {
  @override
  Widget build(BuildContext context) {
    KegiatanNotifier kegiatanNotifier = Provider.of<KegiatanNotifier>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: bgBlue,
                            size: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Detail Kegiatan',
                            style: regularTextStyle.copyWith(
                                color: bgBlue, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.notification_add_rounded,
                                color: bgBlue,
                                size: 25,
                              ),
                            ),
                            Icon(
                              Icons.favorite,
                              color: bgBlue,
                              size: 25,
                            ),
                          ],
                        ))
                  ]),
            ),
            SizedBox(height: 10),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: bgBlue,
                  image: DecorationImage(
                      image: NetworkImage(kegiatanNotifier
                              .currentKegiatan.gambar_kegiatan ??
                          "https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg"))),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                width: 350,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: bgBlue, blurRadius: 20, offset: Offset(0, 10))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 4),
                      child: Text(
                        "Nama Kegiatan:",
                        style: titleTextStyle.copyWith(
                            color: bgBlue, fontSize: 23),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        kegiatanNotifier.currentKegiatan.nama_kegiatan,
                        style: titleTextStyle.copyWith(
                            color: bgBlue, fontSize: 23),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: bgBlue, blurRadius: 20, offset: Offset(0, 10))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text(
                            "Sasaran Kegiatan : ",
                            style: titleTextStyle.copyWith(
                                color: Colors.grey[850], fontSize: 18),
                          ),
                          Text(
                            kegiatanNotifier.currentKegiatan.sasaran_kegiatan,
                            style: titleTextStyle.copyWith(
                                color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text(
                            "Lokasi Kegiatan : ",
                            style: titleTextStyle.copyWith(
                                color: Colors.grey[850], fontSize: 18),
                          ),
                          Text(
                            kegiatanNotifier.currentKegiatan.lokasi_kegiatan,
                            style: titleTextStyle.copyWith(
                                color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                child: Center(
                  child: Text(
                    kegiatanNotifier.currentKegiatan.tanggal_kegiatan ?? "",
                    style: titleTextStyle.copyWith(color: bgBlue, fontSize: 20),
                  ),
                ),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: bgBlue, blurRadius: 20, offset: Offset(0, 10))
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(" Deskripsi :",
                  style:
                      regularTextStyle.copyWith(color: bgBlue, fontSize: 20)),
            ),
            Container(
              width: 500,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: bgBlue, blurRadius: 20, offset: Offset(0, 10))
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    kegiatanNotifier.currentKegiatan.detail_kegiatan ??
                        " Rabu, 14 Rabiul Akhir 1444 H / 9 November 2022 \n Waktu 09.00 - selesai \n Urgensi Kehidupan Hati \n Dari kitab \n Rahasia Kehidupan Hati \n Karya: Ummu Ihsan & Abu Ihsan \n Zoom \n https://bit.ly/3RBpnqF",
                    style: regularTextStyle.copyWith(
                        fontSize: 15, color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
