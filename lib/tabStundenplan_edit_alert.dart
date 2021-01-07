import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '.nicerStyle.dart';
import 'tabStundenplan.dart';

class StundenplanEditAlert extends StatefulWidget {
  @override
  _StundenplanEditAlertState createState() => _StundenplanEditAlertState();
}

class _StundenplanEditAlertState extends State<StundenplanEditAlert> {
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
      titleTextStyle: niceAppBarTitle(),
      title: Text('Mittwoch, 5. Std.', style: TextStyle(fontSize: 18)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      /// Content
      content: DropdownButton(
        isExpanded: true,
        style: bNice(),
        underline: DropdownButtonHideUnderline(
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.redAccent)),
          ),
        ),
        iconDisabledColor: Colors.redAccent,
        iconEnabledColor: Colors.black,
        hint: Text("Fach wählen..."),
        value: index == 99 ? null : index,
        items: [
          DropdownMenuItem(
            value: 0,
            child: Text("Mathe"),
          ),
          DropdownMenuItem(
            value: 1,
            child: Text("Biologie"),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text("Deutsch"),
          ),
          DropdownMenuItem(
            value: 3,
            child: Text("+ Fach hinzufügen",
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
        onChanged: (int i) {
          setState(() => index = i);
          index == 3
              ? showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Neues Fach", style: TextStyle(fontSize: 18)),
                      titleTextStyle: niceAppBarTitle(),
                      content: Column(
                        children: [
                          Container(
                            child: TextField(
                              style: nice(),
                              minLines: 1,
                              maxLines: 1,
                              maxLengthEnforced: false,
                              //onChanged: null,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.redAccent, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.redAccent, width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.redAccent[400], width: 2),
                                ),
                                alignLabelWithHint: true,
                                labelText: ' Bezeichnung',
                                labelStyle: nice(),
                                hintText: 'z.B. Mathe, Deutsch, ...',
                                hintStyle: niceHint(),
                                prefixText: '  ',
                                suffixText: '  ',
                              ),
                            ),
                          ),
                          Container(child: Text("hi")),
                        ],
                      ),
                      actionsPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      actions: [
                        FlatButton(
                          //height: 42,
                          minWidth: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          color: t("back_button"),
                          child: Icon(Icons.arrow_back,
                              color: t("on_back_button")),
                          onPressed: () {
                            Navigator.of(context).pop(); //popAndPushNamed();
                          },
                        ),
                        FlatButton(
                          //height: 42,
                          minWidth: 150,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          color: Colors.redAccent,
                          child: Text("Hinzufügen", style: wNice()),
                          onPressed: () {
                            setState(() {
                              neuerIndex = 99;
                              index = neuerIndex;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }).then(showFach())
              : null;
        },
      ),

      /// Buttons
      actionsPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      actions: [
        FlatButton(
          //height: 42,
          minWidth: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          color: t("back_button"),
          child: Icon(Icons.arrow_back, color: t("on_back_button")),
          onPressed: () {
            Navigator.of(context).pop(); //popAndPushNamed();
          },
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

enum MenuOptions { Mathe, Deutsch }
