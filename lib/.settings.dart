import 'package:flutter/cupertino.dart'; //## iOS-Design-Language
import 'package:flutter/material.dart'; //## Farben, Icons, etc. (Design)
import 'package:flutter/painting.dart'; //## Schatten, Farben, etc. (spezifischer)
import 'package:flutter/rendering.dart'; //## Render-Zeug

import 'main.dart';
import 'pageReport.dart';
import '.transitions.dart';
import 'handleTabs.dart';

//OVERALL
bool beta = true;
bool dark = true;

var ichBin = "schüler"; // Ich bin: schüler, lehrer, elternteil

//STUNDENPLAN
bool abWoche = true;

// TAGESPLAN
var platzhalter = "lol";

// VERTRETUNGSPLAN
var meineKlasse = "7b";
var meinName = "Frau Strohschein";
bool vertretungHighlight = true;

// Handler
betaChecker(String object, zusatz) {
  if (object == "appBarIcon") {
    if (beta == true) {
      return IconButton(
        //## Report-Button
        icon: Icon(Icons.error_outline_sharp,
            color: tabAppBarIcon[zusatz], size: 25),
        onPressed: () {
          slide(zusatz, Offset(1, 0), Report());
        },
      );
    } else {
      return SizedBox(
        width: 1,
      );
    }
  }
}

ichBinHandler() {
  if (ichBin == "schüler") {
    return meineKlasse;
  } else if (ichBin == "lehrer") {
    return meinName;
  } else if (ichBin == "elternteil") {
    print("lol");
  } else {
    print("lol, ein error");
  }
}
