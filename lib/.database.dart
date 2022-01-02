import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Database {
  final String userID;
  Database(this.userID);

  final CollectionReference stundenplan =
      FirebaseFirestore.instance.collection("stundenplan");

  Stream getStundenplan() {
    print(".database/getStundenplan()");
    return stundenplan.doc(userID).snapshots();
  }

  Future checkIfUserExists() async {
    print(".database/checkIfUserExists()");
    if ((await stundenplan.doc(userID).get()).exists) {
      return true;
    } else {
      return false;
    }
  }

  Future setFach(String id, String bezeichnung, int farbe, String raum,
      String lehrer) async {
    print(".database/setFach");
    return await stundenplan.doc(userID).set({
      "fachList": {
        id: {
          "a_id": id,
          "bezeichnung": bezeichnung,
          "farbe": farbe,
          "raum": raum,
          "lehrer": lehrer,
        }
      }
    }, SetOptions(merge: true));
  }

  Future<Map> getFach(String bezeichung) async {
    print(".database/getFach()");
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
    print(".database/delFach()");
    return await stundenplan.doc(userID).set({
      "fachList": {bezeichnung: FieldValue.delete()}
    }, SetOptions(merge: true));
  }

  Future createStundenplan() async {
    print(".database/createStundenplan()");
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

Database database;
User user;

Future<void> firebaseConnect() async {
  print(".database/firebaseConnect()");
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential result = await auth.signInAnonymously();
  user = result.user;

  database = Database(user.uid);

  if (!(await database.checkIfUserExists())) {
    database.createStundenplan();
    database.setFach(
        "FACH_ADD", "Fach hinzufügen", Colors.redAccent.value, "", "");
  }

/*
  Stream userStream = database.getStundenplan();
  userStream.listen((snap) => fachListe = snap.data()["fachList"]);
  print("firebaseConnect / fachListe: " + fachListe.toString());
  */
}
