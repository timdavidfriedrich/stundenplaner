import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '.nicerStyle.dart';

import 'tabStundenplan_add.dart';
import '.settings.dart';

wochenHandler() {
  if (abWoche == true) {
    return ListTile(
      //## Datums-Leiste
      //contentPadding: EdgeInsets.all(0),x
      tileColor: Colors.black87,
      leading: Icon(Icons.arrow_left, color: Colors.white),
      title: Text(
        "A-Woche",
        style: niceSubtitle(),
        textAlign: TextAlign.center,
      ),
      trailing: Icon(Icons.arrow_right, color: Colors.white),
    );
  } else {
    return Container(height: 0, width: 0);
  }
}

tabStundenplanAppBarTitle() {
  return Text("Stundenplan", style: niceAppBarTitle());
  //return Text("Stundenplan", style: niceTitle(Colors.black));
}

tabStundenplanAppBarIcon() {
  return Colors.redAccent;
}

tabStundenplanBody() {
  return Scaffold(
    body: Container(
      color: t("body"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          wochenHandler(),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Table(
              children: [
                TableRow(children: [
                  TableCell(
                      child: Container(
                          width: 5,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Center(
                            child: Text("", style: niceTableHead),
                          ))),
                  TableCell(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Center(
                            child: Text("MO", style: niceTableHead),
                          ))),
                  TableCell(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Center(
                            child: Text("DI", style: niceTableHead),
                          ))),
                  TableCell(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Center(
                            child: Text("MI", style: niceTableHead),
                          ))),
                  TableCell(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Center(
                            child: Text("DO", style: niceTableHead),
                          ))),
                  TableCell(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Center(
                            child: Text("FR", style: niceTableHead),
                          ))),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Container(
                          width: 5,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Center(
                            child: Text("1", style: niceTableSide),
                          ))),
                  TableCell(
                    child: Text(""),
                  ),
                  TableCell(
                    child: Text(""),
                  ),
                  TableCell(
                    child: Text(""),
                  ),
                  TableCell(
                    child: Text(""),
                  ),
                  TableCell(
                    child: Text(""),
                  ),
                ]),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

tabStundenplanFab() {
  return FloatingActionButton(
      focusColor: Colors.redAccent[400],
      backgroundColor: Colors.black,
      splashColor: Colors.redAccent,
      child: Icon(Icons.add, color: Colors.white),
      onPressed: () {
        stundenplanAddOverlay();
      });
}

tabStundenplanFabLocation() {
  return FloatingActionButtonLocation.endFloat;
}
