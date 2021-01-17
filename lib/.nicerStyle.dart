import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '.settings.dart';
import '.sharedprefs.dart';

themeHandler() {
  if (dark) return 1;
  return 0;
}

Map theme = {
//name: [helles Thema, dunkles Thema]
  "nice": [Colors.black, Colors.white],
  "nice2": [Colors.white, Colors.black],
  "wNice": [Colors.white, Colors.white],
  "bNice": [Colors.black, Colors.black],
  "niceError": [Colors.red, Colors.redAccent[400]],
  "niceAppBarTitle": [Colors.black, Colors.white],
  "niceBigTitle": [Colors.black, Colors.white],
  "niceSubtitle": [Colors.black, Colors.white],
  "niceHint": [Colors.grey, Colors.grey],

  "eintragHighlight": [Colors.greenAccent[700], Colors.greenAccent[700]],
  "eintragBackground": [Colors.black, Colors.grey[850]],
  "eintragRaumHighlight": [Colors.blueAccent[400], Colors.blueAccent[400]],
  "eintragFont": [Colors.white, Colors.white],

  "fabVertretungsplan": [
    Colors.grey[800],
    Colors.grey[800]
  ], // Colors.greenAccent[700]
  "kalender": [Colors.black, Colors.white],

  "back_button": [Colors.grey[200], Colors.grey[900]],
  "back_button2": [Colors.grey[200], Colors.grey[700]],
  "on_back_button": [Colors.grey[400], Colors.white],
  "disabled_button": [Colors.grey[850], Colors.grey[700]],
  "stundenplanHint": [Colors.grey[850], Colors.grey[500]],
  "clip": [Colors.grey[200], Colors.grey[700]],
  "clipIcon": [Colors.grey[750], Colors.grey[200]],

  "switch_off": [Colors.grey, Colors.grey[200]],

  "fabStundenplan": [Colors.redAccent, Colors.redAccent],
  "tableHead": [Colors.redAccent, Colors.redAccent],

  "stundenplan_outline": [Colors.grey[800], Colors.grey[400]],

  "appBar": [Colors.white, Colors.black],
  "body": [Colors.white, Colors.black],
  "body2": [Colors.white, Colors.grey[850]],
  "body3": [Colors.white, Colors.grey[800]],
  "page": [Colors.white, Colors.black],
  "bottomBar": [Colors.white, Colors.black],
  "icons": [Colors.black, Colors.white],
};

t(String j) {
  return theme[j][themeHandler()];
}

stundenplanHint() {
  return GoogleFonts.montserrat(
    fontSize: 16,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w500,
    color: t("stundenplanHint"),
  );
}

nice() {
  return GoogleFonts.montserrat(color: t("nice"));
}

niceColor(Color color) {
  return GoogleFonts.montserrat(color: color);
}

niceSize(double size) {
  return GoogleFonts.montserrat(fontSize: size);
}

niceCustom(color, [double size]) {
  return GoogleFonts.montserrat(
      color: color, fontSize: size == null ? null : size);
}

nice2() {
  return GoogleFonts.montserrat(color: t("nice2"));
}

niceError() {
  return GoogleFonts.montserrat(color: t("niceError"));
}

niceHint() {
  return GoogleFonts.montserrat(color: t("niceHint"));
}

wNice() {
  return GoogleFonts.montserrat(color: t("wNice"));
}

bNice() {
  return GoogleFonts.montserrat(color: t("bNice"));
}

niceAppBarTitle() {
  return GoogleFonts.montserrat(
      fontSize: 24, fontWeight: FontWeight.w600, color: t("niceAppBarTitle"));
}

niceBigTitle() {
  return GoogleFonts.montserrat(
      fontSize: 32, fontWeight: FontWeight.w600, color: t("niceBigTitle"));
}

niceSubtitle() {
  return GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w400, color: t("niceSubtitle"));
}

niceSubtitle2() {
  return GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w400, color: t("wNice"));
}

niceSubtitle2Bold() {
  return GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w800, color: t("wNice"));
}

tableHead() {
  return GoogleFonts.montserrat(
      fontSize: 18, fontWeight: FontWeight.w800, color: t("tableHead"));
}

var niceBar = GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500);

var niceTableHead = GoogleFonts.montserrat(
    fontSize: 18, fontWeight: FontWeight.w800, color: t("nice"));

niceSwitch(Color i) {
  return GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w600, color: i);
}
