

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart  ';


class DatabaseServices {
//pertama buat dan ngehubungin collection
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection('category');
  //untuk read

  static Future<DocumentSnapshot> getProduct(String id) async {
    return await productCollection.doc(id).get();
  }

  //delete

}
