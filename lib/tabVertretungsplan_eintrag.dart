import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

import '.nicerStyle.dart';
import 'tabVertretungsplan.dart';
import 'handleEintrag.dart';

class VertretungsEintrag extends StatefulWidget {
  final int c;
  const VertretungsEintrag(this.c);

  @override
  _VertretungsEintragState createState() => _VertretungsEintragState();
}

class _VertretungsEintragState extends State<VertretungsEintrag> {
  /// vertretungsplanData();
  /// filterVertretung();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: colorHandler(widget.c),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Container(
            padding: EdgeInsets.fromLTRB(12, 10, 12, 13),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        child: Text(
                      vertretung["klasse"][widget.c],
                      style: GoogleFonts.montserrat(
                          color: t("eintragFont"),

                          /// FARBE FÜR KLASSE
                          fontSize: 22,
                          fontWeight: FontWeight.w800),
                    )),
                    Spacer(),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            lehrerHandler(vertretung["lehrer"][widget.c]),
                            style: GoogleFonts.montserrat(
                                color: t("eintragFont"),

                                /// FARBE FÜR LEHRER
                                fontSize: 14,
                                fontWeight: FontWeight.w800),
                          )),
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                vertretung["fach"][widget.c],
                                style: GoogleFonts.montserrat(
                                    color: t("eintragFont"),

                                    /// FARBE FÜR FACH
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [],
                          ),
                        ],
                      ),
                    ),
                    Spacer(
                      flex: 10,
                    ),
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                child: Text(
                              blockHandler(vertretung["block"][widget.c]),
                              style: GoogleFonts.montserrat(
                                  color: t("eintragFont"),

                                  /// FARBE FÜR BLOCK
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800),
                            )),
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  raumHandler(vertretung["raum"][widget.c]),
                                  style: GoogleFonts.montserrat(
                                      color: t("eintragFont"),

                                      /// FARBE FÜR RAUM
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )),
                          ]),
                    ),
                  ],
                ),
                /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(alignment: Alignment.topLeft, child: Text(vertretung["fach"][c], 
                        style: GoogleFonts.montserrat(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),)),
                    Container(alignment: Alignment.topLeft, child: Text(raum(vertretung["raum"][c]), 
                        style: GoogleFonts.montserrat(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),)),
                    ],),
                    */
                Container(child: Text(" ")),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    vertretung["bemerkung"][widget.c],
                    style: GoogleFonts.montserrat(
                        color: t("eintragFont"),

                        /// FARBE FÜR BEMERKUNG
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            )));
  }
}
