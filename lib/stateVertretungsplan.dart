import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

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

stateVertretungsplanBody2() {
  return Container(
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
              padding:
                  EdgeInsets.fromLTRB(15, 0, 15, 15), //## Ränder um Gesamtliste
              itemCount:
                  vertretung["klasse"].length, //## Misst Länge für Einträge
              itemBuilder: (context, i) {
                //## Geht jede Zeile durch und schreibt den Eintrag
                return vertretungsEintrag(i.toInt());
              },
            ),
          ),
        ],
      ));
}
