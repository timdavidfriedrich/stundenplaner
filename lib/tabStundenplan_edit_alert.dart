import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '.nicerStyle.dart';
import '.settings.dart';
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
            child: Row(
              children: [
                Icon(Icons.fiber_manual_record, color: Colors.red),
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
                Icon(Icons.fiber_manual_record, color: Colors.green),
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
                Icon(Icons.fiber_manual_record, color: Colors.blue),
                SizedBox(
                  width: 10,
                ),
                Text("Deutsch")
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
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Text("Neues Fach", style: TextStyle(fontSize: 18)),
                      titleTextStyle: niceAppBarTitle(),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              child: NiceTextField(
                                  "Bezeichnung",
                                  "z.B. Mathe, Deutsch, ...",
                                  Colors.redAccent,
                                  Icon(Icons.school_sharp,
                                      color: Colors.black))),
                          // FARBE
                          SizedBox(height: 10),
                          Container(
                              child: NiceTextField(
                                  "Raum",
                                  "z.B. 1.37, 2.15, ...",
                                  Colors.redAccent,
                                  Icon(Icons.room_sharp, color: Colors.black))),
                          SizedBox(height: 10),
                          Container(
                              child: ichBin == "lehrer"
                                  ? null
                                  : NiceTextField(
                                      "Lehrer",
                                      "z.B. Herr Geschwend, Frau Strohschein...",
                                      Colors.redAccent,
                                      Icon(Icons.person_sharp,
                                          color: Colors.black))),
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

class NiceTextField extends StatefulWidget {
  final String label;
  final String hint;
  final Color color;
  final Icon icon;

  const NiceTextField(this.label, this.hint, this.color, this.icon);

  @override
  NiceTextFieldState createState() => NiceTextFieldState();
}

class NiceTextFieldState extends State<NiceTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        style: nice(),
        minLines: 1,
        maxLines: 1,
        //onChanged: null,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: widget.color, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: widget.color, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.redAccent[400], width: 2),
          ),
          alignLabelWithHint: true,
          labelText: ' ' + widget.label,
          labelStyle: nice(),
          hintText: widget.hint,
          hintStyle: niceHint(),
          prefixText: '  ',
          suffixText: '  ',
        ),
      ),
    );
  }
}
