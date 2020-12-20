import 'package:flutter/cupertino.dart'; //## iOS-Design-Language
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; //## Farben, Icons, etc. (Design)
import 'package:flutter/painting.dart'; //## Schatten, Farben, etc. (spezifischer)
import 'package:flutter/rendering.dart'; //## Render-Zeug
import '.settings.dart';

import '.nicerStyle.dart'; //## Importiert eigenes Style-File
import 'main.dart';

import 'handleEintrag.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {},
        child: Scaffold(
            body: Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Einstellungen", style: niceBigTitle(Colors.black)),
                    Text("Ich bin ein Text", style: nice(Colors.black)),
                    // hier könnte ein DropdownButton hingesetzt werden
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Spacer(flex: 3),
                        FlatButton(
                          height: 42,
                          minWidth: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          color: Colors.grey[200],
                          child:
                              Icon(Icons.arrow_back, color: Colors.grey[400]),
                          onPressed: () {
                            Navigator.of(context).pop(); //popAndPushNamed();
                          },
                        ),
                        Spacer(flex: 1),
                        FlatButton(
                          height: 42,
                          minWidth: 200,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          color: Colors.greenAccent[400],
                          child: Text("Speichern", style: nice(Colors.white)),
                          onPressed: () {
                            vertretungHighlight = !vertretungHighlight;
                          },
                        ),
                        Spacer(flex: 3),
                      ],
                    )
                  ],
                ))));
  }
}
