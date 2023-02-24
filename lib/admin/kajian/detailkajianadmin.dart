import 'package:flutter/material.dart';
import 'package:testerr/admin/kajian/updatekajian.dart';
import 'package:testerr/provider/dummy_provider.dart';
import 'package:testerr/provider/model_dummy.dart';
import 'package:testerr/theme.dart';
import 'package:provider/provider.dart';

class DetailKajianAdmin extends StatefulWidget {
  @override
  State<DetailKajianAdmin> createState() => _DetailKajianAdminState();
}

class _DetailKajianAdminState extends State<DetailKajianAdmin> {
  @override
  Widget build(BuildContext context) {
    KajianNotifier kajianNotifier = Provider.of<KajianNotifier>(context);

    _onkajianDeleted(Kajian kajian) {
      kajianNotifier.deleteKajian(kajian);
      Navigator.pop(context);
    }

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
                            'Detail Kajian',
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
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 25,
                              ),
                              onPressed: () {
                                deleteKajian(kajianNotifier.currentKajian,
                                    _onkajianDeleted);
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return UpdateKajian(
                                    isUpdating: true,
                                  );
                                }));
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 25,
                              )),
                        ],
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: 10),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: bgBlue,
                  image: DecorationImage(
                      image: NetworkImage(kajianNotifier.currentKajian.gambar ??
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
                        "Tema :",
                        style: regularTextStyle.copyWith(
                            color: bgBlue, fontSize: 23),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        kajianNotifier.currentKajian.tema_kajian,
                        style: titleTextStyle.copyWith(
                            color: bgBlue, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: bgBlue, blurRadius: 20, offset: Offset(0, 10))
                    ]),
                child: Center(
                  child: Text(
                    kajianNotifier.currentKajian.nama_ustad,
                    style: titleTextStyle.copyWith(color: bgBlue, fontSize: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                child: Center(
                  child: Text(
                    
                    kajianNotifier.currentKajian.tanggal_kajian,
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
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                child: Center(
                  child: Text(
                    
                    kajianNotifier.currentKajian.lokasi_kajian,
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
                    kajianNotifier.currentKajian.deskripsi ??
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
