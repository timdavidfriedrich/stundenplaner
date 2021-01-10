import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '.nicerStyle.dart';
import '.settings.dart';
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
  List<Widget> zellen = [];
  List<TableRow> reihen = [];

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
    reihen.add(TableRow(children: head));

    /// Tabellen-Inhalt:
    for (int i = 0; i < anzahlSpalten; i++) {
      zellen.add(
        TableCell(
          child: Container(
            padding: EdgeInsets.all(4),
            child: Container(
              height: blockOnly ? 108 : 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: t("stundenplan_outline"), width: 1.5)),
              child: FlatButton(
                splashColor: t("nice"),
                child: Text("+", style: nice()),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StundenplanEditAlert();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      );
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
