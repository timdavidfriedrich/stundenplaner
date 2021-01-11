import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/material.dart';

class Database {
  final String userID;
  Database(this.userID);

  final CollectionReference stundenplan =
      FirebaseFirestore.instance.collection("stundenplan");

  Stream getDoc() {
    return stundenplan.doc(userID).snapshots();
  }

  Future setFach(
      String bezeichnung, String farbe, String raum, String lehrer) async {
    return await stundenplan.doc(userID).set({
      "fachList": {
        bezeichnung: {
          "bezeichung": bezeichnung,
          "farbe": farbe,
          "raum": raum,
          "lehrer": lehrer,
        }
      }
    }, SetOptions(merge: true));
  }

  Future<Map> getFach(String bezeichung) async {
    var x;
    await stundenplan
        .doc(userID)
        .get()
        .then<dynamic>((DocumentSnapshot snapshot) async {
      x = snapshot.data;
    });
    return x;
  }
}
