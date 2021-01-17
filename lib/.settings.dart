import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';
import 'pageReport.dart';
import '.transitions.dart';
import 'handleTabs.dart';
import '.database.dart';
import '.sharedprefs.dart';

final prefs = SharedPrefs();

getPrefs() async {
  bool _darkMode = await prefs.getBool("darkMode");
  bool _abWoche = await prefs.getBool("abWoche");
  bool _blockOnly = await prefs.getBool("blockOnly");
  dark = _darkMode;
  abWoche = _abWoche;
  blockOnly = _blockOnly;
}

/// OVERALL
bool beta = true;
bool dark = false;
//bool dark;
bool dev = false;

DateTime datum;

var ichBin = "schüler";

/// Ich bin: schüler, lehrer, elternteil

/// STUNDENPLAN
bool abWoche = false;
bool blockOnly = false;

/// TAGESPLAN
var platzhalter = "lol";

/// VERTRETUNGSPLAN
var meineKlasse = "9b";
var meinName = "Strohschein";
bool vertretungHighlight = true;

/// Handler

betaChecker(context, String object, i) {
  if (object == "appBarIcon") {
    if (beta == true) {
      return IconButton(
        /// Report-Button
        icon: Icon(
          Icons.error_outline_sharp,
          color: tabAppBarIcon[i],
          size: 25,
        ),
        onPressed: () {
          slide(context, Offset(1, 0), Report());
        },
      );
    } else {
      return SizedBox(
        width: 1,
      );
    }
  }
}

datumHandler() {
  if (datum == null) {
    if (DateFormat.EEEE('de').format(DateTime.now()).toString() == 'Samstag') {
      return DateTime.now().add(Duration(days: 2));
    } else if (DateFormat.EEEE('de').format(DateTime.now()).toString() ==
        'Sonntag') {
      return DateTime.now().add(Duration(days: 1));
    } else {
      return DateTime.now();
    }
  } else {
    return datum;
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
