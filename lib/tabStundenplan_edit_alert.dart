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
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Title
      titleTextStyle: niceAppBarTitle(),
      title: Text('Mittwoch, 5. Std.', style: TextStyle(fontSize: 18)),

      /// Content
      content: Container(
        child: TextField(
          style: nice(),
          minLines: 1,
          maxLines: 1,
          //onChanged: (){},
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.redAccent, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.redAccent, width: 2),
            ),
            alignLabelWithHint: true,
            labelText: ' Fach',
            labelStyle: nice(),
            hintText: 'z.B. Mathe',
            hintStyle: niceHint(),
            prefixText: '  ',
            suffixText: '  ',
          ),
        ),
      ),

      /// Buttons
      actionsPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      actions: [
        Spacer(flex: 3),
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
        Spacer(flex: 1),
        FlatButton(
          //height: 42,
          minWidth: 150,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          color: Colors.redAccent,
          child: Text("Hinzufügen", style: wNice()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Spacer(flex: 3)
      ],
    );
  }
}
