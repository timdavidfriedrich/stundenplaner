import 'dart:async';
import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '.nicerStyle.dart';
import '.settings.dart';
import '.transitions.dart';
import '.database.dart';

import 'tabStundenplan_neuesFach.dart';
import 'tabStundenplan.dart';

class StundenplanEditAlert extends StatefulWidget {
  @override
  _StundenplanEditAlertState createState() => _StundenplanEditAlertState();
}

class _StundenplanEditAlertState extends State<StundenplanEditAlert> {
  //
  String user = "testUser";

  Future<void> getFach() {
    Stream userStream = Database(user).getDoc();
    userStream.listen((documentSnapshot) =>
        print("STREAM: " + documentSnapshot.data.toString()));
  }

  List fach = ["Deutsch", "Mathe", "Biologie"];
  int index = 99;
  int neuerIndex = 99;

  showFach() {
    setState(() => index = neuerIndex);
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
        value: index == 99 ? null : index,
        items: [
          DropdownMenuItem(
            value: 0,
            child: Row(
              children: [
                Icon(Icons.bookmark_outline_sharp, color: Colors.red),
                SizedBox(
                  width: 10,
                ),
                Text("Mathe")
              ],
            ),
          ),
          DropdownMenuItem(
            value: 1,
            child: Row(
              children: [
                Icon(Icons.bookmark_outline_sharp, color: Colors.green),
                SizedBox(
                  width: 10,
                ),
                Text("Biologie")
              ],
            ),
          ),
          DropdownMenuItem(
            value: 2,
            child: Row(
              children: [
                Icon(Icons.bookmark_outline_sharp, color: Colors.blue),
                SizedBox(
                  width: 10,
                ),
                /*
                FutureBuilder(
                    future: getFach(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Text("Lädt..."));
                      } else {
                        return StreamBuilder<DocumentSnapshot>(
                          stream: Database(user).getDoc(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            return Text(snapshot.toString());
                          },
                        );
                      }
                    }),
                    */
              ],
            ),
          ),
          DropdownMenuItem(
            value: 3,
            child: Row(children: [
              Icon(Icons.add_sharp, color: Colors.redAccent),
              SizedBox(
                width: 10,
              ),
              Text("Fach hinzufügen")
            ]),
          ),
        ],
        onChanged: (int i) {
          setState(() => index = i);
          index == 3
              ? showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NeuesFach();
                  })
              : null;
        },
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
