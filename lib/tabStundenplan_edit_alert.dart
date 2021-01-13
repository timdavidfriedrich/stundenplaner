import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '.nicerStyle.dart';
import '.settings.dart';
import '.transitions.dart';
import '.database.dart';
import '.stundenplan.dart';

import 'tabStundenplan_neuesFach.dart';
import 'tabStundenplan.dart';

class StundenplanEditAlert extends StatefulWidget {
  @override
  _StundenplanEditAlertState createState() => _StundenplanEditAlertState();
}

class _StundenplanEditAlertState extends State<StundenplanEditAlert> {
  //

  Item selectedIndex;

  List<Item> fachItems = <Item>[
    const Item('Fach hinzufügen', Colors.redAccent),
  ];

  getItems() async {
    DocumentSnapshot snap =
        await Database(user.uid).stundenplan.doc(user.uid).get();

    setState(() {
      for (int i = 0; i < snap.data()["fachList"].length; i++) {
        String _bezeichnung =
            snap.data()["fachList"].values.elementAt(i).toString();
        print(_bezeichnung);
        fachItems.add(Item(_bezeichnung, Colors.red));
      }
    });
  }

  itemReset() {
    setState(() {
      fachItems = <Item>[
        const Item('Fach hinzufügen', Colors.redAccent),
      ];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems();
    //firebaseConnect();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Title
      backgroundColor: t("body2"),
      titleTextStyle: niceAppBarTitle(),
      title: Text('Mittwoch, 5. Std.', style: TextStyle(fontSize: 18)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      /// Content
      content: DropdownButton(
        isExpanded: true,
        style: nice(),
        dropdownColor: t("body3"),
        underline: Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.redAccent, width: 2),
            ),
          ),
        ),
        icon: Icon(Icons.arrow_drop_down_sharp),
        iconDisabledColor: Colors.redAccent,
        iconEnabledColor: t("nice"),
        hint: Text("Fach wählen...", style: TextStyle(color: t("nice"))),
        value: selectedIndex,
        onChanged: (value) async {
          setState(() async {
            value.bezeichnung.toString() != "Fach hinzufügen"
                ? selectedIndex = value
                : selectedIndex = await showDialog(
                    context: context,
                    builder: (context) {
                      return NeuesFach();
                    });
          });
          itemReset();
          getItems();
        },
        items: (fachItems.length == 1)
            ? [
                DropdownMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.add_sharp, color: Colors.redAccent),
                      SizedBox(width: 10),
                      Text("Fach hinzufügen")
                    ],
                  ),
                ),
              ]
            : fachItems.map((Item fachItem) {
                return DropdownMenuItem<Item>(
                  value: fachItem,
                  child: Row(
                    children: <Widget>[
                      fachItem.bezeichnung == "Fach hinzufügen"
                          ? Icon(
                              Icons.add_sharp,
                              color: fachItem.farbe,
                            )
                          : Icon(
                              Icons.bookmark_outline_sharp,
                              color: fachItem.farbe,
                            ),
                      SizedBox(width: 10),
                      Text(
                        fachItem.bezeichnung,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              }).toList(),
      ),

      /// Buttons
      actionsPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: FlatButton(
            //height: 42,
            minWidth: 50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            color: t("back_button2"),
            child: Icon(Icons.arrow_back, color: t("on_back_button")),
            onPressed: () {
              Navigator.of(context).pop(); //popAndPushNamed();
            },
          ),
        ),
        FlatButton(
          //height: 42,
          minWidth: 150,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          color: Colors.redAccent,
          child: Text("Auswählen", style: wNice()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class Item {
  final String bezeichnung;
  final Color farbe;
  const Item(this.bezeichnung, this.farbe);
}
