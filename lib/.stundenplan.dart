import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '.database.dart';

Map<String, dynamic> stundenplan = {
  "Montag": ["", "", "", "", "", "", "", "", "", ""],
  "Dienstag": ["", "", "", "", "", "", "", "", "", ""],
  "Mittwoch": ["", "", "", "", "", "", "", "", "", ""],
  "Donnerstag": ["", "", "", "", "", "", "", "", "", ""],
  "Freitag": ["", "", "", "", "", "", "", "", "", ""],
};

var fachListe = {};

Database database;
User user;

Future<void> firebaseConnect() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential result = await auth.signInAnonymously();
  user = result.user;

  database = Database(user.uid);

  Stream userStream = database.getStundenplan();
  userStream.listen((snap) => fachListe = snap.data()["fachList"]);
  print("Hihi: " + fachListe.toString());
}
