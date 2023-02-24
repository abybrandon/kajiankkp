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

class OrganisasiNotifier with ChangeNotifier {
  List<Organisasi> _organisasiList = [];
  Organisasi _currentOrganisasi;

  UnmodifiableListView<Organisasi> get organisasiList =>
      UnmodifiableListView(_organisasiList);
  Organisasi get currentOrganisasi => _currentOrganisasi;

  set organisasiList(List<Organisasi> organisasiList) {
    _organisasiList = organisasiList;
    notifyListeners();
  }

  set currentOrganisasi(Organisasi organisasi) {
    _currentOrganisasi = organisasi;
    notifyListeners();
  }

  addOrganisasi(Organisasi organisasi) {
    _organisasiList.insert(0, organisasi);
    notifyListeners();
  }

  deleteOrganisasi(Organisasi organisasi) {
    _organisasiList
        .removeWhere((_organisasi) => _organisasi.id == organisasi.id);
    notifyListeners();
  }
}

getOrganisasis(OrganisasiNotifier organisasiNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("organisasi").get();

  List<Organisasi> _organisasiList = [];

  snapshot.docs.forEach((document) {
    Organisasi organisasi = Organisasi.fromMap(document.data());
    _organisasiList.add(organisasi);
  });
  organisasiNotifier.organisasiList = _organisasiList;
}

uploadOrganisasi(
  Organisasi organisasi,
  bool isUpdating,
  Function organisasiUploaded,
) async {
  CollectionReference organisasiRef =
      FirebaseFirestore.instance.collection("organisasi");

  if (isUpdating) {
    organisasi.updatedAt = Timestamp.now();

    await organisasiRef
        .doc(organisasi.id)
        .set(organisasi.toMap(), SetOptions(merge: true));

    organisasiUploaded(organisasi);
    print("updated organisasi  with id: ${organisasi.id}");
  } else {
    organisasi.created = Timestamp.now();

    DocumentReference documentRef = await organisasiRef.add(organisasi.toMap());

    organisasi.id = documentRef.id;

    print("uploaded organisasi succeccfully:  ${organisasi.toString()}");

    await documentRef.set(organisasi.toMap());
    organisasiUploaded(organisasi);
  }
}

deleteOrganisasi(Organisasi organisasi, Function organisasiDeleted) async {
  await FirebaseFirestore.instance
      .collection('organisasi')
      .doc(organisasi.id)
      .delete();
  organisasiDeleted(organisasi);
}
