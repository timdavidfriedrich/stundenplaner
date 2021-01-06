import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '.settings.dart';

themeHandler() {
  if (dark == true) return 1;
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
  "eintragFont": [Colors.white, Colors.white],
  "kalender": [Colors.black, Colors.white],
  "back_button": [Colors.grey[200], Colors.grey[800]],
  "on_back_button": [Colors.grey[400], Colors.white],

  "tableHead": [Colors.redAccent, Colors.redAccent],

  "appBar": [Colors.white, Colors.black],
  "body": [Colors.white, Colors.black],
  "page": [Colors.white, Colors.black],
  "bottomBar": [Colors.white, Colors.black],
  "icons": [Colors.black, Colors.white],
  "fabStundenplan": [Colors.redAccent, Colors.redAccent],
  "fabVertretungsplan": [
    Colors.greenAccent[700],
    Colors.greenAccent[700]
  ], // Colors.greenAccent[700]
};

t(String j) {
  return theme[j][themeHandler()];
}

nice() {
  return GoogleFonts.montserrat(color: t("nice"));
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
