import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

nice(Color i) {
  return GoogleFonts.montserrat(color: i);
}

niceTitle(Color i) {
  return GoogleFonts.montserrat(
      fontSize: 20, fontWeight: FontWeight.w600, color: i);
}

niceBigTitle(Color i) {
  return GoogleFonts.montserrat(
      fontSize: 32, fontWeight: FontWeight.w600, color: i);
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
