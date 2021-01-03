import 'package:flutter/material.dart';
import '.settings.dart';
import '.nicerStyle.dart';
import 'tabVertretungsplan.dart';

colorHandler(c) {
  if (vertretung["klasse"][c] == ichBinHandler()) {
    return t("eintragHighlight");
  } else {
    return t("eintragBackground"); // Colors.black
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
