//kelebihan menggunakan provider
//cukup melakukan 1 kl listening, bisa mengupdate tampilan dimana saja;
// ignore_for_file: depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:testerr/provider/model_dummy.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

class KegiatanNotifier with ChangeNotifier {
  List<Kegiatan> _kegiatanList = [];
  Kegiatan _currentKegiatan;

  UnmodifiableListView<Kegiatan> get kegiatanList =>
      UnmodifiableListView(_kegiatanList);
  Kegiatan get currentKegiatan => _currentKegiatan;

  set kegiatanList(List<Kegiatan> kegiatanList) {
    _kegiatanList = kegiatanList;
    notifyListeners();
  }

  set currentKegiatan(Kegiatan kegiatan) {
    _currentKegiatan = kegiatan;
    notifyListeners();
  }

  addKegiatan(Kegiatan kegiatan) {
    _kegiatanList.insert(0, kegiatan);
    notifyListeners();
  }

  deleteKegiatan(Kegiatan kegiatan) {
    _kegiatanList.removeWhere((_kegiatan) => _kegiatan.id == kegiatan.id);
    notifyListeners();
  }
}

getKegiatans(KegiatanNotifier kegiatanNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("kegiatan_masjid").get();

  List<Kegiatan> _kegiatanList = [];

  snapshot.docs.forEach((document) {
    Kegiatan kegiatan = Kegiatan.fromMap(document.data());
    _kegiatanList.add(kegiatan);
  });
  kegiatanNotifier.kegiatanList = _kegiatanList;
}

uploadkegiatanAndImage(
  Kegiatan kegiatan,
  bool isUpdating,
  File localFile,
  Function kegiatanUploaded,
) async {
  if (localFile != null) {
    print("Uploading Image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('kegiatan/images/$uuid$fileExtension');
    //cek lg
    await firebaseStorageRef
        .putFile(localFile)
        .then((onError) => print("haha"))
        .catchError((onError) {
      print(onError);
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");

    _uploadKegiatan(kegiatan, isUpdating, kegiatanUploaded, imageUrl: url);
  } else {
    print("..Skipping image upload");
    _uploadKegiatan(kegiatan, isUpdating, kegiatanUploaded);
  }
}

_uploadKegiatan(
  Kegiatan kegiatan,
  bool isUpdating,
  Function kegiatanUploaded, {
  String imageUrl,
}) async {
  CollectionReference kegiatanRef =
      FirebaseFirestore.instance.collection("kegiatan_masjid");

  if (imageUrl != null) {
    kegiatan.gambar_kegiatan = imageUrl;
  }

  if (isUpdating) {
    kegiatan.updatedAt = Timestamp.now();

    await kegiatanRef
        .doc(kegiatan.id)
        .set(kegiatan.toMap(), SetOptions(merge: true));

    kegiatanUploaded(kegiatan);
    print("updated kegiatan with id: ${kegiatan.id}");
  } else {
    kegiatan.created = Timestamp.now();

    DocumentReference documentRef = await kegiatanRef.add(kegiatan.toMap());

    kegiatan.id = documentRef.id;

    print("uploaded kegiatansucceccfully:  ${kegiatan.toString()}");

    await documentRef.set(kegiatan.toMap());
    kegiatanUploaded(kegiatan);
  }
}

// _uploadKajian(
//   Kajian kajian,
//   bool isUpdating,
//   Function kajianUploaded,
// ) async {
//   CollectionReference kajianRef =
//       FirebaseFirestore.instance.collection("jadwal_kajian");
//   var uuid = Uuid().v4();

//   if (isUpdating = true) {
//     await kajianRef.doc(kajian.id).set(kajian.toMap(), SetOptions(merge: true));

//     kajianUploaded(kajian);
//   } else {
//     DocumentReference documentRef = await kajianRef.add(
//       kajian.toMap(),
//     );
//     kajian.id = documentRef.id;

//     kajianUploaded(kajian);
//   }
// }

deleteKegiatan(Kegiatan kegiatan, Function kegiatanDeleted) async {
  await FirebaseFirestore.instance
      .collection('kegiatan_masjid')
      .doc(kegiatan.id)
      .delete();
  kegiatanDeleted(kegiatan);
}
