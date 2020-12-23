import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '.settings.dart';

import '.nicerStyle.dart';
import '.vertretung.dart';
import 'tabVertretungsplan_eintrag.dart';

tabVertretungsplanAppBarTitle() {
  return Text("Vertretungsplan", style: niceAppBarTitle());
  //return Text("Vertretungsplan", style: niceTitle(Colors.black));
}

tabVertretungsplanAppBarIcon() {
  return Colors.greenAccent[700];
}

class TabVertretungsplanBody extends StatefulWidget {
  @override
  _TabVertretungsplanBodyState createState() => _TabVertretungsplanBodyState();
}

class _TabVertretungsplanBodyState extends State<TabVertretungsplanBody>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  DateTime _dateTime;

  datumPrint() {
    var datumFormat = DateFormat.yMd('de').format(datumHandler());
    var wochentag = DateFormat.EEEE('de').format(datumHandler());
    //return datumFormat.toString();
    return RichText(
        text: TextSpan(style: niceSubtitle2(), children: <TextSpan>[
      TextSpan(text: wochentag.toString(), style: niceSubtitle2Bold()),
      TextSpan(text: ", "),
      TextSpan(text: datumFormat.toString()),
    ]));
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    Timer(Duration(milliseconds: 200), () => _animationController.forward());
    super.initState();
    initializeDateFormatting();
  }

  @override
  void dispose() {
    _animationController.forward();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
                //color: t("body"), //## Hintergrundfarbe
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  //## Erstellt für eine dynamische Häufigkeit die Eintröge
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(
                        15, 0, 15, 0), //## Ränder um Gesamtliste
                    itemCount: vertretung["klasse"]
                        .length, //## Misst Länge für Einträge
                    itemBuilder: (context, i) {
                      //## Geht jede Zeile durch und schreibt den Eintrag
                      return vertretungsEintrag(i.toInt());
                    },
                  ),
                ),
              ],
            )),
            /*
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, -1),
                end: Offset.zero,
              ).animate(_animationController),
              child: FadeTransition(
                opacity: _animationController,
                child: */
            Positioned(
              right: 10,
              bottom: 20,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 3),
                  end: Offset.zero,
                )
                    .chain(CurveTween(curve: Curves.elasticOut))
                    .animate(_animationController),
                child: ButtonTheme(
                  minWidth: 160,
                  height: 50,
                  child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: t("fabVertretungsplan"),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        locale: const Locale("de", "DE"),
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: ColorScheme.dark(
                                primary: t("niceEintragHighlight"),
                                onPrimary: Colors.white,
                                surface: t("body"),
                                onSurface: t("icons"),
                                onBackground: t("icons"),
                                secondary: t("niceEintragHighlight"),
                                secondaryVariant: t("niceEintragHighlight"),
                              ),
                              dialogBackgroundColor: t("body"),
                              textSelectionColor: t("nice"),
                              textSelectionHandleColor:
                                  t("niceEintragHighlight"),
                              //fixTextFieldOutlineLabel: true,
                            ),
                            child: child,
                          );
                        },
                        cancelText: "HEUTE ",
                        confirmText: " DATUM WÄHLEN",
                        initialDate: datum == null ? DateTime.now() : datum,
                        firstDate: DateTime(2016, 09, 05),
                        lastDate: DateTime.now().add(new Duration(days: 30)),
                      ).then((date) {
                        setState(() {
                          datum = date;
                        });
                      });
                    },
                    child: datumPrint(),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
