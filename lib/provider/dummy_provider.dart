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

class FoodNotifier with ChangeNotifier {
  List<Food> _foodList = [];
  Food _currentFood;

  UnmodifiableListView<Food> get foodList => UnmodifiableListView(_foodList);
  Food get currentFood => _currentFood;

  set foodList(List<Food> foodList) {
    _foodList = foodList;
    notifyListeners();
  }

  set currentFood(Food food) {
    _currentFood = food;
    notifyListeners();
  }
}

getFoods(FoodNotifier foodNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("food").get();

  List<Food> _foodList = [];

  snapshot.docs.forEach((document) {
    Food food = Food.fromMap(document.data());
    _foodList.add(food);
  });
  foodNotifier.foodList = _foodList;
}

class KajianNotifier with ChangeNotifier {
  List<Kajian> _kajianList = [];
  Kajian _currentKajian;

  UnmodifiableListView<Kajian> get kajianList =>
      UnmodifiableListView(_kajianList);
  Kajian get currentKajian => _currentKajian;

  set kajianList(List<Kajian> kajianList) {
    _kajianList = kajianList;
    notifyListeners();
  }

  set currentKajian(Kajian kajian) {
    _currentKajian = kajian;
    notifyListeners();
  }

  addKajian(Kajian kajian) {
    _kajianList.insert(0, kajian);
    notifyListeners();
  }

  deleteKajian(Kajian kajian) {
    _kajianList.removeWhere((_kajian) => _kajian.id == kajian.id);
    notifyListeners();
  }
}

getKajians(KajianNotifier kajianNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("jadwal_kajian").get();

  List<Kajian> _kajianList = [];

  snapshot.docs.forEach((document) {
    Kajian kajian = Kajian.fromMap(document.data());
    _kajianList.add(kajian);
  });
  kajianNotifier.kajianList = _kajianList;
}

uploadKajianAndImage(
  Kajian kajian,
  bool isUpdating,
  File localFile,
  Function kajianUploaded,
) async {
  if (localFile != null) {
    print("Uploading Image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('kajian/images/$uuid$fileExtension');
    //cek lg
    await firebaseStorageRef
        .putFile(localFile)
        .then((onError) => print("haha"))
        .catchError((onError) {
      print(onError);
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");

    _uploadKajian(kajian, isUpdating, kajianUploaded, imageUrl: url);
  } else {
    print("..Skipping image upload");
    _uploadKajian(kajian, isUpdating, kajianUploaded);
  }
}

_uploadKajian(
  Kajian kajian,
  bool isUpdating,
  Function kajianUploaded, {
  String imageUrl,
}) async {
  CollectionReference kajianRef =
      FirebaseFirestore.instance.collection("jadwal_kajian");

  if (imageUrl != null) {
    kajian.gambar = imageUrl;
  }

  if (isUpdating) {
    kajian.updatedAt = Timestamp.now();

    await kajianRef.doc(kajian.id).set(kajian.toMap(), SetOptions(merge: true));

    kajianUploaded(kajian);
    print("updated Kajian with id: ${kajian.id}");
  } else {
    kajian.created = Timestamp.now();

    DocumentReference documentRef = await kajianRef.add(kajian.toMap());

    kajian.id = documentRef.id;

    print("uploaded Kajian succeccfully:  ${kajian.toString()}");

    await documentRef.set(kajian.toMap());
    kajianUploaded(kajian);
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

deleteKajian(Kajian kajian, Function kajianDeleted) async {
  await FirebaseFirestore.instance
      .collection('jadwal_kajian')
      .doc(kajian.id)
      .delete();
  kajianDeleted(kajian);
}
