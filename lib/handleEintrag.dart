import 'package:flutter/material.dart';
import '.settings.dart';
import '.nicerStyle.dart';
import 'tabVertretungsplan.dart';

checkBemerkung(c) {
  var raumchangeLehrer = [];
  var raumchangeBlock = [];
  var raumchangeFach = [];
  var raumchangeKlasse = [];
  var raumchangeRaum = [];
  var raumchangeBemerkung = [];

  for (int i = 0; i < raumchange.length; i++) {
    raumchangeLehrer.add(raumchange[i].lehrer);
    raumchangeBlock.add(raumchange[i].block);
    raumchangeFach.add(raumchange[i].fach);
    raumchangeKlasse.add(raumchange[i].klasse);
    raumchangeRaum.add(raumchange[i].raum);
    raumchangeBemerkung.add(raumchange[i].bemerkung);
  }

  if (raumchangeLehrer.contains(vertretung[c].lehrer) &&
      raumchangeBlock.contains(vertretung[c].block) &&
      raumchangeFach.contains(vertretung[c].fach) &&
      raumchangeKlasse.contains(vertretung[c].klasse) &&
      raumchangeRaum.contains(vertretung[c].raum) &&
      raumchangeBemerkung.contains(vertretung[c].bemerkung)) {
    return true;
  } else {
    return false;
  }
}

colorBackHandler(c) {
  if (vertretung[c].klasse.contains(ichBinHandler().toString()) ||
      vertretung[c].lehrer.contains(ichBinHandler().toString())) {
    if (checkBemerkung(c)) {
      return t("eintragRaumHighlight");
    } else {
      return t("eintragHighlight");
    }
  } else {
    return t("eintragBackground"); // Colors.black
  }
}

bemerkungHandler(c) {
  if (checkBemerkung(c)) {
    return (vertretung[c].bemerkung == "")
        ? "Raumänderung"
        : ("Raumänderung\n") + ("(" + vertretung[c].bemerkung + ")");
  } else {
    return vertretung[c].bemerkung;
  }
}

List k7 = ["7", "7a", "7b", "7c", "7d", "7e"];
List k8 = ["8", "8a", "8b", "8c", "8d", "8e"];
List k9 = ["9", "9a", "9b", "9c", "9d", "9e"];
List k10 = ["10", "10a", "10b", "10c", "10d", "10e"];
List k11 = ["11", "11a", "11b", "11c", "11d", "11e"];
List k12 = ["12", "12a", "12b", "12c", "12d", "12e"];
List k13 = ["13", "13a", "13b", "13c", "13d", "13e"];

String lehrerHandler(String i) {
  if (i == "") {
    return "(kein Lehrer)";
  } else {
    return i.toString();
  }
}

String blockHandler(String i) {
  List<String> j = ["1", "2", "3", "4", "04", "5"];
  if (j.contains(i)) {
    return i.toString() + ". Block";
  } else {
    return i.toString();
  }
}

String raumHandler(String i) {
  if (i == "") {
    return "(kein Raum)";
  } else {
    return i.toString();
  }
}
