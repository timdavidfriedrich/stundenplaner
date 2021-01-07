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
  List<Widget> zellen = [];
  List<TableRow> reihen = [];

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
    reihen.add(TableRow(children: head));

    /// Tabellen-Inhalt:
    for (int i = 0; i < anzahlSpalten; i++) {
      zellen.add(TableCell(
          child: Container(
        padding: EdgeInsets.all(2),

        /// Zellen-Inhalt
        child: Container(),
      )));
    }

    /// Reihen werden erstellt:
    for (int i = 0; i < anzahlZeilen; i++) {
      reihen.add(TableRow(children: zellen));
    }

    /// Gesamte Reihen als Einheit ausgebenen:
    return reihen;
  }

  @override
  void initState() {
    tableCreator();
    super.initState();
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
              children: reihen,
            ),
          )
        ],
      ),
    );
  }
}
