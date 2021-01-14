import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Database {
  final String userID;
  Database(this.userID);

  final CollectionReference stundenplan =
      FirebaseFirestore.instance.collection("stundenplan");

  Stream getStundenplan() {
    return stundenplan.doc(userID).snapshots();
  }

  Future setFach(
      String bezeichnung, int farbe, String raum, String lehrer) async {
    return await stundenplan.doc(userID).set({
      "fachList": {
        bezeichnung: {
          "bezeichnung": bezeichnung,
          "farbe": farbe,
          "raum": raum,
          "lehrer": lehrer,
        }
      }
    }, SetOptions(merge: true));
  }

  Future checkIfUserExists() async {
    if ((await stundenplan.doc(userID).get()).exists) {
      return true;
    } else {
      return false;
    }
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
