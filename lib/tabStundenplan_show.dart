import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '.nicerStyle.dart';
import 'tabStundenplan.dart';

class StundenplanShow extends StatefulWidget {
  @override
  StundenplanShowState createState() => StundenplanShowState();
}

class StundenplanShowState extends State<StundenplanShow> {
  //
  List<String> tage = ["MO", "DI", "MI", "DO", "FR"];
  List<TableCell> head = [];
  List<Widget> zelle = [];
  List<TableRow> reihe = [];

  int anzahlSpalten = 5;
  int anzahlZeilen = 8;

  tableCreator() {
    /// Tabellen-Kopf
    for (int i = 0; i < anzahlSpalten; i++)
      head.add(TableCell(
          child: Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Center(child: Text(tage[i], style: niceTableHead)))));

    /// Head als erste Reihe hinzufügen
    reihe.add(TableRow(children: head));

    /// Tabellen-Inhalt:
    for (int i = 0; i < anzahlSpalten; i++) {
      zelle.add(TableCell(
          child: Container(
        padding: EdgeInsets.all(2),

        /// Zellen-Inhalt
        child: Container(),
      )));
    }

    /// Reihen werden erstellt:
    for (int i = 0; i < anzahlZeilen; i++) {
      reihe.add(TableRow(children: zelle));
    }

    /// Gesamte Reihen als Einheit ausgebenen:
    return reihe;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            child: Table(
              children: tableCreator(),
            ),
          )
        ],
      ),
    );
  }
}
