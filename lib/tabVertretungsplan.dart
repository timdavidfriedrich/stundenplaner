import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

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
      appBar: null,
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
              //color: t("body"), //## Hintergrundfarbe
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                //## Erstellt für eine dynamische Häufigkeit die Eintröge
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(
                      15, 0, 15, 0), //## Ränder um Gesamtliste
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
          Positioned(
            right: -50,
            bottom: 90,
            child: Transform.rotate(
              angle: pi / 2,
              child: FlatButton(
                height: 42,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: t("fabVertretungsplan"),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.arrow_left),
                    Text("Montag, 14.12.2020", style: niceSubtitle()),
                    Icon(Icons.arrow_right),
                  ],
                ),
              ),
            ),
          )
        ],
      ));
}

tabVertretungsplanFab() {
  return null;
}

tabVertretungsplanFab1() {
  return Transform.rotate(
      angle: pi / 2,
      child: FloatingActionButton.extended(
          backgroundColor: t("fabVertretungsplan"),
          onPressed: () {
            print("hi");
          },
          label: Container(
              child: Row(children: [
            Icon(Icons.arrow_left_sharp, color: t("icons")),
            Text("Montag, 14.12.2020", style: niceSubtitle()),
            Icon(Icons.arrow_right_sharp, color: t("icons")),
          ]))));
}

tabVertretungsplanFab3() {
  return FlatButton(
    onPressed: () {
      print("hi");
    },
    child: Container(
      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Container(
        //padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            //color: Color.fromRGBO(199, 244, 210, 0.99),
            color: t("fabVertretungsplan"),
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
          leading: Icon(Icons.arrow_left, color: t("nice")),
          title: Text(
            "Montag, 14.12.2020",
            style: niceSubtitle(),
            textAlign: TextAlign.center,
          ),
          trailing: Icon(Icons.arrow_right, color: t("nice")),
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
