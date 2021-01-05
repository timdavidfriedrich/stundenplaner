import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:intl/intl.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import 'pageReport_dev.dart';
import '.nicerStyle.dart';
import '.settings.dart';

/// Importiert eigenes Style-File
import 'main.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  void initState() {
    initFirebase();
    super.initState();
  }

  bool onlineStatus;
  bool close = false;

  String nachricht;

  devHandler() {
    List devPass = [
      "/gamemode 1",
      "/gamemode1",
      "/Gamemode 1",
      "/gm 1",
      "/gm1",
    ];
    if (devPass.contains(nachricht)) {
      return true;
    }
  }

  /// Firebase
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference reports =
      FirebaseFirestore.instance.collection('reports');
  bool uploadError = false;

  void initFirebase() async {
    try {
      await Firebase.initializeApp();
      print('FB INIT: Successful');
    } on FirebaseException catch (e) {
      print('FB INIT (ERROR): ' + e.toString());
    }
  }

  Future addReport() async {
    String zeit = DateFormat('yyyy.MM.dd').format(DateTime.now()).toString() +
        DateFormat(' - hh:mm:ss').format(DateTime.now()).toString();
    return reports.doc(zeit).set({
      "datum": Timestamp.now(),
      "nachricht": nachricht,
    }).catchError((error) {
      setState(() => uploadError = true);
      print("FB ADD (ERROR): $error");
    });
  }

  void onlineChecker() async {
    bool online = await DataConnectionChecker().hasConnection;
    setState(() => online ? onlineStatus = true : onlineStatus = false);
  }

  popper() {
    if (close == true) {
      return Navigator.of(context).pop();
    }
  }

  alertHandler() {
    if (onlineStatus == false || uploadError == true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            //return alertHandler();
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              contentTextStyle: bNice(),
              //titleTextStyle: bNice(),
              titleTextStyle: niceAppBarTitle(),
              title:
                  Text('Senden fehlgeschlagen', style: TextStyle(fontSize: 18)),
              content: Text(
                  'Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('ZURÜCK'),
                  onPressed: () {
                    setState(() => uploadError = false);
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    } else {
      if (nachricht == null) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              //return alertHandler();
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentTextStyle: bNice(),
                //titleTextStyle: bNice(),
                //title: Text('Senden fehlgeschlagen'),
                content: Text('Das Textfeld darf nicht leer sein.'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('ZURÜCK'),
                    onPressed: () {
                      setState(() => uploadError = false);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      } else {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              //return alertHandler();
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: Text(
                    'Vielen Dank für das Feedback.\nIhre Nachricht wird weitergeleitet.'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OKAY'),
                    onPressed: () {
                      setState(() {
                        close = true;
                        uploadError = false;
                      });
                      popper();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    }
  }

  void nachrichtRefresh(String text) {
    setState(() {
      nachricht = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return dev
        ? ReportDev()
        : Scaffold(
            appBar: AppBar(
              leading: SizedBox(),
              elevation: 0,
              toolbarHeight: 200,
              bottom: AppBar(
                title: Text("Feedback", style: niceBigTitle()),
                centerTitle: true,
                leading: SizedBox(),
                elevation: 0,
                toolbarHeight: 100,
              ),
            ),
            body: Container(
                //color: Colors.white,
                child: ListView(
              physics: BouncingScrollPhysics(),
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  //color: Colors.red,
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 25),
                  child: TextField(
                    style: nice(),
                    minLines: 10,
                    maxLines: 100,
                    maxLength: 420,
                    maxLengthEnforced: false,
                    onChanged: nachrichtRefresh,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.redAccent[400], width: 2),
                      ),
                      alignLabelWithHint: true,
                      labelText: ' Nachricht',
                      labelStyle: nice(),
                      hintText: 'Lob, Kritik, Fehler gefunden, ...',
                      hintStyle: niceHint(),
                      prefixText: '  ',
                      suffixText: '  ',
                    ),
                  ),
                ),
              ],
            )),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Spacer(flex: 3),
                  FlatButton(
                    height: 42,
                    minWidth: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: t("back_button"),
                    child: Icon(Icons.arrow_back, color: t("on_back_button")),
                    onPressed: () {
                      Navigator.of(context).pop(); //popAndPushNamed();
                    },
                  ),
                  Spacer(flex: 1),
                  FlatButton(
                    height: 42,
                    minWidth: 200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: Colors.blueAccent,
                    child: Text("Nachricht senden", style: wNice()),
                    onPressed: () async {
                      if (devHandler() == true) {
                        setState(() => dev = true);
                      } else {
                        onlineChecker();
                        if (onlineStatus != false) addReport();
                        return alertHandler();
                      }
                    },
                  ),
                  Spacer(flex: 3)
                ],
              ),
            ),
          );
  }
}
