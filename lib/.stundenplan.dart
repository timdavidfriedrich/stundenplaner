import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '.database.dart';

Map<String, dynamic> stundenplan = {
  "Montag": ["", "", "", "", "", "", "", "", "", ""],
  "Dienstag": ["", "", "", "", "", "", "", "", "", ""],
  "Mittwoch": ["", "", "", "", "", "", "", "", "", ""],
  "Donnerstag": ["", "", "", "", "", "", "", "", "", ""],
  "Freitag": ["", "", "", "", "", "", "", "", "", ""],
};

var fachListe = {};
String newBezeichnung;
Color newFarbe;

Database database;
User user;

Future<void> firebaseConnect() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential result = await auth.signInAnonymously();
  user = result.user;

  database = Database(user.uid);

  if (!(await database.checkIfUserExists())) {
    database.setFach("Fach hinzufügen", Colors.redAccent.value, "", "");
  }

/*
  Stream userStream = database.getStundenplan();
  userStream.listen((snap) => fachListe = snap.data()["fachList"]);
  print("firebaseConnect / fachListe: " + fachListe.toString());
  */
}
