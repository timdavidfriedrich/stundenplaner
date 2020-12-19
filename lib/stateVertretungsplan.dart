import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:stundenplaner/actualSettings.dart';

import 'nicerStyle.dart';
import 'fakeVertretung.dart';
import 'vertretungsEintrag.dart';

stateVertretungsplanBarTitle() {
  return Text("Vertretungsplan", style: niceTitle(Colors.greenAccent[700]));
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
  );
}

stateVertretungsplanFab() {
  return FlatButton(
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
  );
  /*
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,;
    */
}

stateVertretungsplanFabLocation() {
  return FloatingActionButtonLocation.centerFloat;
}
