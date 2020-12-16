import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

import 'nicerStyle.dart';
import 'random.dart';
import 'fakeVertretung.dart';
import 'eintragHandler.dart';


class vertretungsEintrag extends StatelessWidget {
  final int c;
  const vertretungsEintrag(this.c);
  @override
  Widget build(BuildContext context) {
    return Card(
        color: colorHandler(c), //## colorHandler(klasse) oder colorHandler2(klasse) oder rdmColor()
        elevation: 0,
        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Container(
          padding: EdgeInsets.fromLTRB(12,10,12,13),
          child:
            Column(
              children: [
                Row(
                  children: [
                    Container(child: Text(vertretung["klasse"][c], style: GoogleFonts.montserrat(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),)),
                    Spacer(),
                    Container(
                      child:
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Container(child: Text(lehrerHandler(vertretung["lehrer"][c]), style: GoogleFonts.montserrat(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),)),
                          Container(alignment: Alignment.topLeft, child: Text(vertretung["fach"][c], 
                                style: GoogleFonts.montserrat(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),)),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              
                            ],
                          ),
                          ],
                        ),
                    ),
                    Spacer(flex: 10,),
                    Container(
                      child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(child: Text(blockHandler(vertretung["block"][c]), style: GoogleFonts.montserrat(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),)),
                            Container(alignment: Alignment.topLeft, child: Text(raumHandler(vertretung["raum"][c]), 
                                style: GoogleFonts.montserrat(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),)),
                          ]
                        ),
                    ),
                  ],),
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
                  child: Text(vertretung["bemerkung"][c], style: GoogleFonts.montserrat(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic),),),
              ],
            )
        )
    );
}}
