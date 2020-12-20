import 'package:flutter/material.dart';
import '.settings.dart';
import '.nicerStyle.dart';
import '.vertretung.dart';

colorHandler(c) {
  if (vertretungHighlight == true) {
    return colorKlassenFokus(vertretung["klasse"][c]);
  } else {
    return colorsOhneFokus(vertretung["klasse"][c]);
  }
}

colorKlassenFokus(c) {
  if (c == ichBinHandler()) {
    return t("niceEintragHighlight");
  } else {
    return t("niceEintragBackground"); // Colors.black
  }
}

List k7 = ["7", "7a", "7b", "7c", "7d", "7e"];
List k8 = ["8", "8a", "8b", "8c", "8d", "8e"];
List k9 = ["9", "9a", "9b", "9c", "9d", "9e"];
List k10 = ["10", "10a", "10b", "10c", "10d", "10e"];
List k11 = ["11", "11a", "11b", "11c", "11d", "11e"];
List k12 = ["12", "12a", "12b", "12c", "12d", "12e"];
List k13 = ["13", "13a", "13b", "13c", "13d", "13e"];

colorsOhneFokus(i) {
  if (k7.contains(i)) {
    return Colors.greenAccent[700];
  } else if (k8.contains(i)) {
    return Colors.yellow[600];
  } else if (k9.contains(i)) {
    return Colors.orange[700];
  } else if (k10.contains(i)) {
    return Colors.red[700];
  } else if (k11.contains(i)) {
    return Colors.purple;
  } else if (k12.contains(i)) {
    return Colors.blue[700];
  } else if (k13.contains(i)) {
    return Colors.brown[700];
  } else {
    return Colors.black;
  }
}

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
