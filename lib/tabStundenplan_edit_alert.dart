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

  String selectedFach = "Kein Fach ausgewählt.";

  @override
  void initState() {
    super.initState();
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlatButton(
            onPressed: () {},
            child: Stack(
              children: [
                Text(selectedFach, style: nice()),
                FutureBuilder(
                    future: firebaseConnect(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return StreamBuilder<DocumentSnapshot>(
                          stream: Database(user.uid).getStundenplan(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              Map<String, dynamic> items = snapshot.data.data();
                              var fachItems = items["fachList"].values;

                              var selectedIndex;

                              /////////////////////////////////////////////////////////////////////////////////////////////
                              ////////////////////////////////////// DROPDOWNBUTTON ///////////////////////////////////////
                              /////////////////////////////////////////////////////////////////////////////////////////////
                              return DropdownButton(
                                isExpanded: true,
                                style: nice(),
                                dropdownColor: t("body3"),
                                iconSize: 0,
                                value: selectedIndex,
                                onChanged: (item) {
                                  setState(() {
                                    selectedFach =
                                        item["bezeichnung"].toString();
                                  });
                                  item["bezeichnung"].toString() !=
                                          "Fach hinzufügen"
                                      ? null
                                      : showDialog(
                                          context: context,
                                          builder: (context) {
                                            return NeuesFach();
                                          });
                                },
                                items: fachItems
                                    .map<DropdownMenuItem<dynamic>>((item) {
                                  return DropdownMenuItem<dynamic>(
                                    value: item,
                                    child: Row(
                                      children: <Widget>[
                                        item["bezeichnung"] == "Fach hinzufügen"
                                            ? Icon(
                                                Icons.add_sharp,
                                                color: Colors.redAccent,
                                              )
                                            : Icon(
                                                Icons.bookmark_outline_sharp,
                                                color: Color(item["farbe"]),
                                              ),
                                        SizedBox(width: 10),
                                        Text(
                                          item["bezeichnung"],
                                          style: nice(),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                              /////////////////////////////////////////////////////////////////////////////////////////////
                              ////////////////////////////////////// DROPDOWNBUTTON  ///////////////////////////////////////
                              /////////////////////////////////////////////////////////////////////////////////////////////
                            }
                          },
                        );
                      }
                    }),
              ],
            ),
          ),
        ],
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
