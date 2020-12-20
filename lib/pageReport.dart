import 'package:flutter/cupertino.dart'; //## iOS-Design-Language
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; //## Farben, Icons, etc. (Design)
import 'package:flutter/painting.dart'; //## Schatten, Farben, etc. (spezifischer)
import 'package:flutter/rendering.dart'; //## Render-Zeug

import '.nicerStyle.dart'; //## Importiert eigenes Style-File
import 'main.dart';

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            //color: Colors.white,
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Fehler melden", style: niceBigTitle()),
        Text("Ich bin ein Text", style: nice()),
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
              child: Icon(Icons.arrow_back, color: Colors.grey[400]),
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
              child: Text("Bericht senden", style: nice2()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Spacer(flex: 3)
          ],
        )
      ],
    )));
  }
}
