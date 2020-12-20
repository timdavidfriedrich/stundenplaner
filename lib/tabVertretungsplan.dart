import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import '.settings.dart';

import '.nicerStyle.dart';
import '.vertretung.dart';
import 'tabVertretungsplan_eintrag.dart';

tabVertretungsplanAppBarTitle() {
  return Text("Vertretungsplan", style: niceAppBarTitle());
  //return Text("Vertretungsplan", style: niceTitle(Colors.black));
}

tabVertretungsplanAppBarIcon() {
  return Colors.greenAccent[700];
}

tabVertretungsplanBody() {
  return Scaffold(
    body: Container(
        color: Colors.black.withOpacity(0.03), //## Hintergrundfarbe
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

tabVertretungsplanFab() {
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
            //color: Color.fromRGBO(199, 244, 210, 0.99),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300].withOpacity(0.5),
                offset: Offset.zero,
                blurRadius: 10,
                spreadRadius: 1,
              )
            ]),
        child: ListTile(
          //## Datums-Leiste
          //contentPadding: EdgeInsets.all(0),
          //tileColor: Colors.black12,
          leading: Icon(Icons.arrow_left, color: Colors.greenAccent[700]),
          title: Text(
            "Montag, 14. Dezember 2020",
            style: niceSwitch(Colors.greenAccent[700]),
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

tabVertretungsplanFabLocation() {
  return FloatingActionButtonLocation.centerFloat;
}
