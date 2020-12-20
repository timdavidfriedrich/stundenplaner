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
};

nice() {
  return GoogleFonts.montserrat(color: theme["nice"][themeHandler()]);
}

nice2() {
  return GoogleFonts.montserrat(color: theme["nice2"][themeHandler()]);
}

niceAppBarTitle() {
  return GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: theme["niceAppBarTitle"][themeHandler()]);
}

niceBigTitle() {
  return GoogleFonts.montserrat(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: theme["niceBigTitle"][themeHandler()]);
}

niceSubtitle(Color i) {
  return GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w400, color: i);
}

var niceBar = GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500);
var niceTableHead = GoogleFonts.montserrat(
    fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800);
var niceTableSide = GoogleFonts.montserrat(
    fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400);

niceSwitch(Color i) {
  return GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w600, color: i);
}
