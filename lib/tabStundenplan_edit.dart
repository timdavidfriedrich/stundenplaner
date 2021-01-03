import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '.nicerStyle.dart';
import 'tabStundenplan.dart';
import 'tabStundenplan_edit_alert.dart';

class StundenplanEdit extends StatefulWidget {
  @override
  StundenplanEditState createState() => StundenplanEditState();
}

class StundenplanEditState extends State<StundenplanEdit> {
  //
  List<String> tage = ["MO", "DI", "MI", "DO", "FR"];
  List<TableCell> head = [];
  List<Widget> zelle = [];
  List<TableRow> reihe = [];

  bool blockOnly = false;

  int anzahlSpalten = 5;
  int anzahlZeilen;

  blockUnterricht() {
    return anzahlZeilen = blockOnly ? 4 : 8;
  }

  tableCreator() {
    blockUnterricht();

    /// Tabellen-Kopf
    for (int i = 0; i < anzahlSpalten; i++)
      head.add(TableCell(
          child: Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Center(child: Text(tage[i], style: tableHead())))));

    /// Head als erste Reihe hinzufügen
    reihe.add(TableRow(children: head));

    /// Tabellen-Inhalt:
    for (int i = 0; i < anzahlSpalten; i++) {
      zelle.add(TableCell(
          child: Container(
        padding: EdgeInsets.all(4),
        child: Container(
            height: blockOnly ? 108 : 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: t("nice"), width: 1.5)),
            child: FlatButton(
              splashColor: t("nice"),
              child: Text("+"),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StundenplanEditAlert();
                  },
                );
              },
            )),
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
