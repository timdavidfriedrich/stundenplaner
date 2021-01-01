import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:web_scraper/web_scraper.dart';

import '.settings.dart';

import '.nicerStyle.dart';
import '.vertretungsplan.dart';
import 'tabVertretungsplan_eintrag.dart';

tabVertretungsplanAppBarTitle() {
  return Text("Vertretungsplan", style: niceAppBarTitle());
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

  datumPrint() {
    String datumFormat = DateFormat.yMd('de').format(datumHandler());
    String wochentag = DateFormat.EEEE('de').format(datumHandler());
    //return datumFormat.toString();
    return RichText(
        text: TextSpan(style: niceSubtitle2(), children: <TextSpan>[
      TextSpan(text: wochentag, style: niceSubtitle2Bold()),
      TextSpan(text: ", "),
      TextSpan(text: datumFormat),
    ]));
  }

  List<Map<String, dynamic>> rawVertretung;

  String urlDatum = DateFormat('yyyyMMdd').format(datumHandler());
//String urlDatum = '';
  String rawUrl = 'http://www.gymnasium-templin.de';
//String urlExtension = '/typo3/vertretung/index13mob.php?d=20180820';
//String urlExtension = '/typo3/vertretung/index13mob.php?d=' + urlDatum;

  void vertretungsplanData(dateInput) async {
    //urlDatum = DateFormat('yyyyMMdd').format(datumHandler());

    final WebScraper webScraper = WebScraper(rawUrl);
    List filteredVertretung = [];

    if (await webScraper
        .loadWebPage('/typo3/vertretung/index13mob.php?d=' + dateInput)) {
      rawVertretung = webScraper.getElement(
          'div.clearfix > table.vertretung > tbody > tr > td', ['title']);
      print('VP ROHFORMAT: ' + rawVertretung.toString());
      // filterVertretung()
      // rawVertretung.toString()
    } else {
      print("VP LÄDT...");
    }

    for (int i = 0; i < rawVertretung.length; i++) {
      filteredVertretung.add(rawVertretung[i]['title']);
    }
    print('--- VP DATUM: ' + dateInput);
    print('VP GEFILTERT: ' + filteredVertretung.toString());

    setState(() {
      vertretung['lehrer'] = ente(filteredVertretung, 0);
      vertretung['block'] = ente(filteredVertretung, 1);
      vertretung['fach'] = ente(filteredVertretung, 2);
      vertretung['klasse'] = ente(filteredVertretung, 3);
      vertretung['raum'] = ente(filteredVertretung, 4);
      vertretung['bemerkung'] = ente(filteredVertretung, 5);
    });

    print('VP SORTIERT / Klasse: ' + ente(filteredVertretung, 3).toString());
  }

  /// p: 0 = Lehrer, 1 = Block, 2 = Fach, 3 = Klasse, 4 = Raum, 5 = Bemerkung
  List<T> ente<T>(List<T> liste, int p) {
    /// Gibt jedes 6te Element der Liste aus
    return List.generate(
        (liste.length / 6).floor(), (i) => liste[((i + 1) * 6 - 1) - (5 - p)]);
  }

  leererEintrag() {
    if (vertretung['klasse'].isEmpty) {
      return Center(
        child: Text("Keine Einträge vorhanden.", style: nice()),
      );
    } else {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(15, 0, 15, 100),

        /// Ränder um Gesamtliste
        itemCount: vertretung["klasse"].length,

        /// Misst Länge für Einträge
        itemBuilder: (context, i) {
          /// Geht jede Zeile durch und schreibt den Eintrag
          return VertretungsEintrag(i.toInt());
        },
      );
    }
  }

  @override
  void initState() {
    print('URL-Datum: ' + urlDatum);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    Timer(Duration(milliseconds: 200), () => _animationController.forward());
    super.initState();
    initializeDateFormatting();
    vertretungsplanData(urlDatum);

    setState(() {
      urlDatum = DateFormat('yyyyMMdd').format(datumHandler());
      vertretungsplanData(urlDatum);
    });
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
                //color: t("body"), /// Hintergrundfarbe
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /*
                Text('    // URL-DATUM: ' + urlDatum,
                    style: TextStyle(color: Colors.red[900])),
                    */
                Expanded(child: leererEintrag()),
              ],
            )),
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
                          urlDatum =
                              DateFormat('yyyyMMdd').format(datumHandler());
                        });
                        vertretungsplanData(urlDatum);
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
