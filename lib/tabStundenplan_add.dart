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
import '.sharedprefs.dart';

import 'tabStundenplan_new_edit.dart';
import 'tabStundenplan.dart';

class StundenplanAdd extends StatefulWidget {
  @override
  _StundenplanAddState createState() => _StundenplanAddState();
}

class _StundenplanAddState extends State<StundenplanAdd> {
  //

  String selectedFach = "Fach wählen";
  Color selectedFarbe = t("disabled_button");

  newEditFachDialog(editMode,
      [bezeichnungInput, farbeInput, raumInput, lehrerInput]) async {
    Map<String, dynamic> callback = await showDialog<Map<String, dynamic>>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return NewEditFach(
              editMode, bezeichnungInput, farbeInput, raumInput, lehrerInput);
        });
    if (callback["bezeichnung"] != "x") {
      setState(() {
        selectedFach = callback["bezeichnung"];
        selectedFarbe = Color(callback["farbe"]);
      });
    } else {
      setState(() {
        selectedFach = "Fach wählen";
        selectedFarbe = t("disabled_button");
      });
    }
  }

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
      title: FutureBuilder(
          future: firebaseConnect(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(selectedFarbe)));
            } else {
              return StreamBuilder<DocumentSnapshot>(
                stream: Database(user.uid).getStundenplan(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(selectedFarbe)));
                  } else {
                    Map<String, dynamic> items = snapshot.data.data();
                    var fachItems = items["fachList"].values;

                    var selectedIndex;

                    /////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////// DROPDOWNBUTTON ///////////////////////////////////////
                    /////////////////////////////////////////////////////////////////////////////////////////////
                    return FlatButton(
                      padding: EdgeInsets.zero,
                      color: selectedFarbe,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {},
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          style: nice(),
                          dropdownColor: t("body3"),
                          iconSize: 0,
                          value: selectedIndex,
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(selectedFach, style: wNice()),
                          ),
                          onChanged: (item) {
                            setState(() {
                              selectedFach = item["bezeichnung"].toString();
                              selectedFarbe = Color(item["farbe"]);
                            });
                            item["bezeichnung"].toString() != "Fach hinzufügen"
                                ? null
                                : newEditFachDialog(false);
                          },
                          items:
                              fachItems.map<DropdownMenuItem<dynamic>>((item) {
                            return DropdownMenuItem<dynamic>(
                                value: item,
                                child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading:
                                        item["bezeichnung"] == "Fach hinzufügen"
                                            ? Icon(
                                                Icons.add_sharp,
                                                color: t("nice"),
                                              )
                                            : Icon(
                                                Icons.bookmark_outline_sharp,
                                                color: Color(item["farbe"]),
                                              ),
                                    title: Text(item["bezeichnung"],
                                        style: nice()),
                                    trailing: item["bezeichnung"] !=
                                            "Fach hinzufügen"
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  newEditFachDialog(
                                                      true,
                                                      item["bezeichnung"],
                                                      Color(item["farbe"]),
                                                      item["raum"],
                                                      item["lehrer"]);
                                                  setState(() {
                                                    selectedFach =
                                                        "Fach wählen";
                                                    selectedFarbe =
                                                        t("disabled_button");
                                                  });
                                                },
                                                icon: Icon(Icons.edit_outlined,
                                                    color: t("nice")),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  await database.delFach(
                                                      item["bezeichnung"]);
                                                  setState(() {
                                                    selectedFach =
                                                        "Fach wählen";
                                                    selectedFarbe =
                                                        t("disabled_button");
                                                  });
                                                },
                                                icon: Icon(
                                                    Icons.delete_outline_sharp,
                                                    color: t("nice")),
                                              ),
                                            ],
                                          )
                                        : SizedBox(width: 1, height: 1))
                                /*
                              Row(
                                children: <Widget>[
                                  item["bezeichnung"] == "Fach hinzufügen"
                                      ? Icon(
                                          Icons.add_sharp,
                                          color: t("nice"),
                                        )
                                      : Icon(
                                          Icons.bookmark_outline_sharp,
                                          color: Color(item["farbe"]),
                                        ),
                                  Spacer(flex: 1),
                                  Text(item["bezeichnung"]),
                                  Spacer(flex: 4),
                                  Icon(Icons.delete_outline_sharp,
                                      color: t("nice"))
                                ],
                              ),
                              */
                                );
                          }).toList(),
                        ),
                      ),
                    );
                    /////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////// DROPDOWNBUTTON  //////////////////////////////////////
                    /////////////////////////////////////////////////////////////////////////////////////////////
                  }
                },
              );
            }
          }),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      /// Content
      contentPadding: EdgeInsets.fromLTRB(25, 10, 25, 20),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Text("Wann?", style: stundenplanHint()),
            Wrap(
              spacing: 10,
              children: [
                Chip(
                  label: Text('Mo, 5. Std.', style: nice()),
                  backgroundColor: t("clip"),
                  deleteIconColor: t("clipIcon"),
                  onDeleted: () {},
                ),
                Chip(
                  label: Text('Do, 1. Std.', style: nice()),
                  backgroundColor: t("clip"),
                  deleteIconColor: t("clipIcon"),
                  onDeleted: () {},
                ),
                Chip(
                  label: Text('Fr, 8. Std.', style: nice()),
                  backgroundColor: t("clip"),
                  deleteIconColor: t("clipIcon"),
                  onDeleted: () {},
                ),
                FlatButton(
                  minWidth: 36,
                  padding: EdgeInsets.all(5.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  color: t("body2").withOpacity(0.0),
                  child: Icon(Icons.add_sharp, color: t("nice")),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  minWidth: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  color: t("back_button2"),
                  child: Icon(Icons.arrow_back, color: t("on_back_button")),
                  onPressed: () {
                    Navigator.pop(
                        context, {"fach": selectedFach, "done": false});
                  },
                ),
                FlatButton(
                  minWidth: 150,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  color: Colors.redAccent,
                  child: Text("Auswählen", style: wNice()),
                  onPressed: () {
                    selectedFach != "Fach wählen"
                        ? Navigator.pop(
                            context, {"fach": selectedFach, "done": true})
                        : null;
                  },
                ),
              ],
            ),
          ]),
    );
  }
}
