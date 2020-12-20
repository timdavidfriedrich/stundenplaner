import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '.settings.dart';

themeHandler() {
  if (dark == false) {
    return 0;
  } else {
    return 1;
  }
}

Map theme = {
//name: [helles Thema, dunkles Thema]
  "nice": [Colors.black, Colors.white],
  "nice2": [Colors.white, Colors.black],
  "niceAppBarTitle": [Colors.black, Colors.white],
  "niceBigTitle": [Colors.black, Colors.white],
  "niceSubtitle": [Colors.black, Colors.white],

  "niceEintragBackground": [Colors.black, Colors.grey[850]],
  "niceEintragFont": [Colors.white, Colors.white],

  "appBar": [Colors.white, Colors.black],
  "body": [Colors.white, Colors.black],
  "page": [Colors.white, Colors.black],
  "bottomBar": [Colors.white, Colors.black],
  "icons": [Colors.black, Colors.white],
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

var niceBar = GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500);

var niceTableHead = GoogleFonts.montserrat(
    fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black);
var niceTableSide = GoogleFonts.montserrat(
    fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black);

niceSwitch(Color i) {
  return GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w600, color: i);
}
