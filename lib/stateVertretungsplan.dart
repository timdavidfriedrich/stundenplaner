import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:stundenplaner/actualSettings.dart';

import 'nicerStyle.dart';
import 'fakeVertretung.dart';
import 'vertretungsEintrag.dart';

stateVertretungsplanBarTitle() {
  return Text("Vertretungsplan", style: niceTitle);
}

stateVertretungsplanBody() {
  return Scaffold(
    body: Container(
        color: Color.fromRGBO(0, 0, 0, 0.05), //## Hintergrundfarbe
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              //## Erstellt für eine dynamische Häufigkeit die Eintröge
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(
                    15, 0, 15, 15), //## Ränder um Gesamtliste
                itemCount:
                    vertretung["klasse"].length, //## Misst Länge für Einträge
                itemBuilder: (context, i) {
                  //## Geht jede Zeile durch und schreibt den Eintrag
                  return vertretungsEintrag(i.toInt());
                },
              ),
            ),
          ],
        )),
    floatingActionButton: FlatButton(
      onPressed: () {
        print("hi");
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Container(
          //padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.white70,
              spreadRadius: 0,
              blurRadius: 10,
              //offset: Offset(0, 3),
            ),
          ], borderRadius: BorderRadius.circular(40), color: Colors.white),
          child: ListTile(
            //## Datums-Leiste
            //contentPadding: EdgeInsets.all(0),
            //tileColor: Colors.black12,
            leading: Icon(Icons.arrow_left, color: Colors.black),
            title: Text(
              "Montag, 14. Dezember 2020",
              style: niceBottomSwitch(Colors.black),
              textAlign: TextAlign.center,
            ),
            trailing: Icon(Icons.arrow_right, color: Colors.black),
          ),
        ),
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
  );
}

stateVertretungsplanBody2() {
  return Scaffold(
    body: Container(
        color: Color.fromRGBO(0, 0, 0, 0.05), //## Hintergrundfarbe
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              //## Erstellt für eine dynamische Häufigkeit die Eintröge
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(
                    15, 0, 15, 15), //## Ränder um Gesamtliste
                itemCount:
                    vertretung["klasse"].length, //## Misst Länge für Einträge
                itemBuilder: (context, i) {
                  //## Geht jede Zeile durch und schreibt den Eintrag
                  return vertretungsEintrag(i.toInt());
                },
              ),
            ),
          ],
        )),
    floatingActionButton: FlatButton(
      onPressed: () {
        print("hi");
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Container(
          //padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Color.fromRGBO(199, 244, 210, 0.99)),
          child: ListTile(
            //## Datums-Leiste
            //contentPadding: EdgeInsets.all(0),
            //tileColor: Colors.black12,
            leading: Icon(Icons.arrow_left, color: Colors.greenAccent[700]),
            title: Text(
              "Montag, 14. Dezember 2020",
              style: niceBottomSwitch(Colors.greenAccent[700]),
              textAlign: TextAlign.center,
            ),
            trailing: Icon(Icons.arrow_right, color: Colors.greenAccent[700]),
          ),
        ),
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
  );
}

stateVertretungsplanBody3() {
  return Scaffold(
      body: Container(
          color: Color.fromRGBO(0, 0, 0, 0.05), //## Hintergrundfarbe
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                //## Datums-Leiste
                //contentPadding: EdgeInsets.all(0),
                tileColor: Colors.black87,
                leading: Icon(Icons.arrow_left, color: Colors.white),
                title: Text(
                  "Montag, 14. Dezember 2020",
                  style: niceSubtitle,
                  textAlign: TextAlign.center,
                ),
                trailing: Icon(Icons.arrow_right, color: Colors.white),
              ),
              Expanded(
                //## Erstellt für eine dynamische Häufigkeit die Eintröge
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(
                      15, 0, 15, 15), //## Ränder um Gesamtliste
                  itemCount:
                      vertretung["klasse"].length, //## Misst Länge für Einträge
                  itemBuilder: (context, i) {
                    //## Geht jede Zeile durch und schreibt den Eintrag
                    return vertretungsEintrag(i.toInt());
                  },
                ),
              ),
            ],
          )));
}
