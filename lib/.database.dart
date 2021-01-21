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

  Future checkIfUserExists() async {
    if ((await stundenplan.doc(userID).get()).exists) {
      return true;
    } else {
      return false;
    }
  }

  Future setFach(String id, String bezeichnung, int farbe, String raum,
      String lehrer) async {
    return await stundenplan.doc(userID).set({
      "fachList": {
        id: {
          "id": id,
          "bezeichnung": bezeichnung,
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

  Future delFach(String bezeichnung) async {
    return await stundenplan.doc(userID).set({
      "fachList": {bezeichnung: FieldValue.delete()}
    }, SetOptions(merge: true));
  }

  Future createStundenplan() async {
    List tagesListe = ['1', '2', '3', '4', '5'];
    List planList = ["plan_A", "plan_B", "plan_C"];
    for (int ab = 0; ab < 2; ab++) {
      for (int i = 0; i < tagesListe.length; i++) {
        await stundenplan.doc(userID).set({
          planList[ab]: {
            tagesListe[i]: {
              "1": "",
              "2": "",
              "3": "",
              "4": "",
            }
          }
        }, SetOptions(merge: true));
      }
    }
    for (int i = 0; i < tagesListe.length; i++) {
      await stundenplan.doc(userID).set({
        planList[2]: {
          tagesListe[i]: {
            "1": "",
            "2": "",
            "3": "",
            "4": "",
            "5": "",
            "6": "",
            "7": "",
            "8": "",
          }
        }
      }, SetOptions(merge: true));
    }
  }

  Future setStundenplanEintrag(
      String plan, String tag, String block, String fach) async {
    return await stundenplan.doc(userID).set({
      plan: {
        tag: {block: fach}
      }
    }, SetOptions(merge: true));
  }
}
