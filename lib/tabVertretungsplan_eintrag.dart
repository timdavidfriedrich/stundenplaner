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
  @override
  Widget build(BuildContext context) {
    return Card(
        color: colorBackHandler(widget.c),
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
                        vertretung[widget.c].klasse.length < 6
                            ? vertretung[widget.c].klasse
                            : vertretung[widget.c].klasse.substring(0, 5) +
                                vertretung[widget.c]
                                    .klasse
                                    .substring(5)
                                    .replaceAll(" ", "\n"),
                        style: GoogleFonts.montserrat(
                            color: t("eintragFont"),
                            fontSize: vertretung[widget.c].klasse.length < 6
                                ? 22
                                : 12,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              lehrerHandler(vertretung[widget.c].lehrer),
                              style: GoogleFonts.montserrat(
                                  color: t("eintragFont"),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                vertretung[widget.c].fach,
                                style: GoogleFonts.montserrat(
                                    color: t("eintragFont"),
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
                              blockHandler(vertretung[widget.c].block),
                              style: GoogleFonts.montserrat(
                                  color: t("eintragFont"),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800),
                            )),
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  raumHandler(vertretung[widget.c].raum),
                                  style: GoogleFonts.montserrat(
                                      color: t("eintragFont"),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )),
                          ]),
                    ),
                  ],
                ),
                Container(child: Text(" ")),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    bemerkungHandler(widget.c),
                    style: GoogleFonts.montserrat(
                        color: t("eintragFont"),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            )));
  }
}
