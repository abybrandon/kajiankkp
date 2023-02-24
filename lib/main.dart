// ignore_for_file: depend_on_referenced_packages, duplicate_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testerr/admin/menuadmin.dart';
import 'package:testerr/login/login.dart';
import 'package:testerr/page/kajian_user/detailkajian.dart';
import 'package:testerr/page/splash_login.dart';
import 'package:testerr/provider/kegiatan_provider.dart';
import 'package:testerr/provider/organisasi_provider.dart';

import 'package:testerr/theme.dart';

import 'package:provider/provider.dart';
import 'package:testerr/provider/dummy_provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("20eeb6a7-c617-4e4d-a3f9-cc938a97f754");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => KegiatanNotifier(),
          ),
          ChangeNotifierProvider(
            create: (context) => KajianNotifier(),
          ),
          ChangeNotifierProvider(
            create: (context) => OrganisasiNotifier(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Login(),
        ),
      );
}

class Dummy extends StatefulWidget {
  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
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
                  return DetailScreen();
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
                        "Jumat 11 November 2022 ",
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
    );
  }
}

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:testerr/login/signup.dart';
// import 'package:testerr/testloginrole/registerrole.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Colors.blue[900],
//       ),
//       home: SignUp(),
//     );
//   }
// }
