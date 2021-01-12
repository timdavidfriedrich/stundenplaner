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

  List fach = ["Deutsch", "Mathe", "Biologie"];
  int index = 99;
  int neuerIndex = 99;

  showFach() {
    setState(() => index = neuerIndex);
  }

  var dropdownItemList = [];

  void dropdownItems() {
    for (int i = 0; i < 4; i++) {
      dropdownItemList.add(
        DropdownMenuItem(
          value: i,
          child: Row(
            children: [
              Icon(Icons.add_sharp, color: Colors.redAccent),
              SizedBox(width: 10),
              Text('items["fachList"].values.elementAt(i).toString()')
            ],
          ),
        ),
      );
    }
    dropdownItemList.add(
      DropdownMenuItem(
        value: 'items["fachList"].values.length + 1',
        child: Row(
          children: [
            Icon(Icons.add_sharp, color: Colors.redAccent),
            SizedBox(width: 10),
            Text("Fach hinzufügen")
          ],
        ),
      ),
    );
  }

  var bezeichnungList = [];
  var farbeList = [];
  var raumList = [];
  var lehrerList = [];

  void sortItems(items) {
    for (int i = 0; i < items["fachList"].length; i++) {
      /*
      setState(() {
        bezeichnungList.add(items["fachList"].values.elementAt(i).toString());
      });
      */
      bezeichnungList.add(items["fachList"].values.elementAt(i).toString());
      print("TEST ALLA: " + bezeichnungList.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseConnect();
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
      content: FutureBuilder(
          future: firebaseConnect(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return StreamBuilder(
                stream: database.getStundenplan(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    Map<String, dynamic> items = snapshot.data.data();
                    sortItems(items);
                    dropdownItems();

                    return DropdownButton(
                      isExpanded: true,
                      style: nice(),
                      dropdownColor: t("body3"),
                      underline: Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: Colors.redAccent, width: 2),
                          ),
                        ),
                      ),
                      icon: Icon(Icons.arrow_drop_down_sharp),
                      iconDisabledColor: Colors.redAccent,
                      iconEnabledColor: t("nice"),
                      hint: Text("Fach wählen...",
                          style: TextStyle(color: t("nice"))),
                      value: index == 99 ? null : index,
                      items: (items == null)
                          ? DropdownMenuItem(
                              value: 0,
                              child: Row(
                                children: [
                                  Icon(Icons.search_off_outlined,
                                      color: t("icons")),
                                  SizedBox(width: 10),
                                  Text("Oweia, nichts gefunden!")
                                ],
                              ),
                            )
                          : bezeichnungList.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value.toString()),
                              );
                            }),
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
                    );
                  }
                },
              );
            }
          }),

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
