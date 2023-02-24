import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testerr/admin/kegiatan/detailkegiatanadmin.dart';
import 'package:testerr/admin/kegiatan/updatekegiatan.dart';
import 'package:testerr/admin/menuadmin.dart';
import 'package:testerr/admin/organisasi/updateorganisasi.dart';
import 'package:testerr/page/kajian_user/profilepage.dart';
import 'package:testerr/provider/organisasi_provider.dart';
import 'package:testerr/theme.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:provider/provider.dart';

class OrganisasiPage extends StatefulWidget {
  @override
  State<OrganisasiPage> createState() => _OrganisasiPageState();
}

class _OrganisasiPageState extends State<OrganisasiPage> {
  @override
  void initState() {
    OrganisasiNotifier organisasiNotifier =
        Provider.of<OrganisasiNotifier>(context, listen: false);
    getOrganisasis(organisasiNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrganisasiNotifier organisasiNotifier =
        Provider.of<OrganisasiNotifier>(context);
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: GestureDetector(
                // onTap: () {
                //   organisasiNotifier.currentOrganisasi =
                //       organisasiNotifier.organisasiList[index];
                //   Navigator.of(context)
                //       .push(MaterialPageRoute(builder: (BuildContext context) {
                //     return DetailKegiatan();
                //   }));
                // },
                child: Card(
              elevation: 5,
              child: ListTile(
                subtitle: Text(
                  "Jabatan : " +
                          organisasiNotifier.organisasiList[index].jabatan ??
                      "Kosong",
                  style: regularTextStyle.copyWith(color: Colors.grey[800]),
                ),
                title: Text(
                    organisasiNotifier.organisasiList[index].nama ?? "Kosong"),
              ),
            )),
          );
        },
        itemCount: organisasiNotifier.organisasiList.length,
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
          organisasiNotifier.currentOrganisasi = null;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return UpdateOrganisasi(
              isUpdating: false,
            );
          }));
        },
      ),
    );
  }
}

class BgOrganisasi1 extends StatelessWidget {
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
                  "Sturktur Organisasi",
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
              Expanded(child: OrganisasiPage())
            ],
          )
        ],
      ),
    );
  }
}
