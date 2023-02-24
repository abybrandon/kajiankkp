import 'package:flutter/material.dart';
import 'package:testerr/admin/organisasi/adminorganisasi.dart';
import 'package:testerr/auth/auth_services.dart';
import 'package:testerr/login/login.dart';
import 'package:testerr/main.dart';
import 'package:testerr/page/kegiatan_user/kegiatanmasjid.dart';
import 'package:testerr/page/organisasi_user/organisasipage.dart';
import 'package:testerr/page/kajian_user/profilepage.dart';
import 'package:testerr/provider/model_dummy.dart';
import 'package:testerr/widget/menuwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter, colors: [bgBlue, whiteColor])),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    size: 22,
                                  ),
                                ),
                                Text(
                                  "Jakarta Timur",
                                  style:
                                      regularTextStyle.copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: TextButton(
                                onPressed: () async {
                                  await AuthServices.signOut();
                                   Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: Icon(
                                  Icons.logout_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            "Sabtu, 05 November 2022",
                            style: regularTextStyle.copyWith(
                                fontSize: 12, color: Colors.grey[100]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: Container(
                              width: screenWidth - 60,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border(
                                    left: BorderSide(
                                        width: 1, color: Colors.grey[350]),
                                    right: BorderSide(
                                        width: 1, color: Colors.grey[350]),
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey[350]),
                                    top: BorderSide(
                                        width: 1, color: Colors.grey[350])),
                              ),
                            ),
                          ),
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
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: SingleChildScrollView(
                              child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(children: <Widget>[
                                    Image(
                                      image: AssetImage("assets/bismillah.png"),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 110,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfilePage()),
                                              );
                                            },
                                            child: Category('assets/cat6.png',
                                                'Daftar  Kajian'),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        KegiatanPage()),
                                              );
                                            },
                                            child: Category('assets/cat7.png',
                                                'Kegiatan Masjid'),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BgOrganisasi1()),
                                                );
                                              },
                                              child: Category('assets/cat9.png',
                                                  'Organisasi')),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Doa harian',
                                          style: regularTextStyle.copyWith(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 95,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.blue[100]),
                                          child: Center(
                                            child: Text(
                                              "Lihat Semua",
                                              style: regularTextStyle.copyWith(
                                                  color: bgBlue),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Bannerr(bgBlue,
                                              "Barang siapa yang bersungguh-sungguh berjalan pada jalannya maka pasti ia akan sampai pada tujuannya"),
                                          Bannerr(bgBlue,
                                              "Janganlah kamu berduka cita, sesungguhnya Allah selalu bersama kita. (QS At Taubah 40)"),
                                          Bannerr(bgBlue,
                                              "Kita hidup di jaman sholat lima waktu sudah dianggap orang sholeh")
                                        ],
                                      ),
                                    )
                                  ])))))
                ])));
  }
}
