import 'dart:async';
import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:web_scraper/web_scraper.dart';

import '.settings.dart';

import '.nicerStyle.dart';
import 'tabVertretungsplan_eintrag.dart';

class VertretungsItem {
  String lehrer;
  String block;
  String fach;
  String klasse;
  String raum;
  String bemerkung;

  VertretungsItem(this.lehrer, this.block, this.fach, this.klasse, this.raum,
      this.bemerkung);
}

List<VertretungsItem> vertretung = [];
List<VertretungsItem> raumchange = [];

String annovation = "";

tabVertretungsplanAppBarTitle() {
  return "Vertretungsplan";
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

  bool onlineStatus;

  List<Map<String, dynamic>> rawVertretung;
  List<Map<String, dynamic>> rawRaumchange;
  String rawAnnovation;

  List<VertretungsItem> vertretungTemp = [];
  List<VertretungsItem> vertretungTempOthers = [];

  String urlDatum = DateFormat('yyyyMMdd').format(datumHandler());
  String rawUrl = 'http://www.gymnasium-templin.de';

  void vertretungsplanData(dateInput) async {
    //urlDatum = DateFormat('yyyyMMdd').format(datumHandler());

    final WebScraper webScraper = WebScraper(rawUrl);

    if (await webScraper
        .loadWebPage('/typo3/vertretung/index13mob.php?d=' + dateInput)) {
      rawVertretung = webScraper.getElement(
          'div.clearfix > table.vertretung > tbody > tr > td', ['title']);
      rawRaumchange = webScraper
          .getElement('div.clearfix > table.raum > tbody > tr > td', ['title']);

      if (webScraper
          .getElement('div.clearfix > div.annotationv', ['title'])
          .toList()
          .isEmpty) {
        rawAnnovation = "";
      } else {
        rawAnnovation = webScraper
            .getElement('div.clearfix > div.annotationv', ['title'])
            .toList()[0]['title']
            .toString();
      }
    }

    setState(() {
      int x = (rawVertretung.length ~/ 6);
      int y = (rawRaumchange.length ~/ 6);

      if (rawVertretung[0]['title'] != "Es sind keine Einträge vorhanden.") {
        for (int i = 0; i < x; i++) {
          vertretungTemp.add(VertretungsItem(
            ente(rawVertretung, 0)[i]['title'],
            ente(rawVertretung, 1)[i]['title'],
            ente(rawVertretung, 2)[i]['title'],
            ente(rawVertretung, 3)[i]['title'],
            ente(rawVertretung, 4)[i]['title'],
            ente(rawVertretung, 5)[i]['title'],
          ));
        }
      }

      if (rawRaumchange[0]['title'] != "Es sind keine Einträge vorhanden.") {
        for (int i = 0; i < y; i++) {
          vertretungTemp.add(VertretungsItem(
            ente(rawRaumchange, 0)[i]['title'],
            ente(rawRaumchange, 1)[i]['title'],
            ente(rawRaumchange, 2)[i]['title'],
            ente(rawRaumchange, 3)[i]['title'],
            ente(rawRaumchange, 4)[i]['title'],
            ente(rawRaumchange, 5)[i]['title'],
          ));
          raumchange.add(VertretungsItem(
            ente(rawRaumchange, 0)[i]['title'],
            ente(rawRaumchange, 1)[i]['title'],
            ente(rawRaumchange, 2)[i]['title'],
            ente(rawRaumchange, 3)[i]['title'],
            ente(rawRaumchange, 4)[i]['title'],
            ente(rawRaumchange, 5)[i]['title'],
          ));
        }
      }

      vertretungSort();

      vertretung = vertretungTemp;
      annovation = rawAnnovation;
    });
  }

  vertretungSort() {
    /// SORTIEREN NACH KLASSE (Zahlen aufwärts)
    Comparator<VertretungsItem> sortByKlasse =
        (a, b) => a.klasse.compareTo(b.klasse);
    vertretungTemp.sort(sortByKlasse);

    /// SORTIEREN NACH KLASSE (Zahlen abwärts)
    //vertretung = vertretung.reversed.toList();

    if (ichBin == "lehrer") {
      vertretungTempOthers = vertretungTemp
          .where((item) => !item.lehrer.contains(ichBinHandler().toString()))
          .toList();
      vertretungTemp.removeWhere(
          (item) => !item.lehrer.contains(ichBinHandler().toString()));
      vertretungTemp.addAll(vertretungTempOthers);
    } else {
      vertretungTempOthers = vertretungTemp
          .where((item) => !item.klasse.contains(ichBinHandler().toString()))
          .toList();
      vertretungTemp.removeWhere(
          (item) => !item.klasse.contains(ichBinHandler().toString()));
      vertretungTemp.addAll(vertretungTempOthers);
    }
  }

  vertretungReset() {
    setState(() {
      vertretung = [];
      raumchange = [];
      vertretungTemp = [];
      vertretungTempOthers = [];
    });
  }

  /// p: 0 = Lehrer, 1 = Block, 2 = Fach, 3 = Klasse, 4 = Raum, 5 = Bemerkung
  List<T> ente<T>(List<T> liste, int p) {
    /// Gibt jedes 6te Element der Liste aus
    return List.generate(
        (liste.length / 6).floor(), (i) => liste[((i + 1) * 6 - 1) - (5 - p)]);
  }

  onlineChecker() async {
    bool online = await DataConnectionChecker().hasConnection;
    setState(() => online ? onlineStatus = true : onlineStatus = false);
  }

  eintragHandler() {
    if (onlineStatus == false) {
      return Center(
        child: Icon(
          Icons.wifi_off_sharp,
          color: t("nice"),
          size: 56,
        ),
      );
    } else {
      if (vertretung.isEmpty && raumchange.isEmpty) {
        return Center(
          child: Text("Keine Einträge vorhanden.", style: nice()),
        );
      } else {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 100),

          /// Ränder um Gesamtliste
          itemCount: vertretung.length,

          /// Misst Länge für Einträge
          itemBuilder: (context, int i) {
            /// Geht jede Zeile durch und schreibt den Eintrag
            return VertretungsEintrag(i);
          },
        );
      }
    }
  }

  datumPrint() {
    String datumFormat =
        DateFormat('dd.MM.yyyy', 'de_DE').format(datumHandler());
    String wochentag = DateFormat.EEEE('de').format(datumHandler());
    //return datumFormat.toString();
    return RichText(
        text: TextSpan(style: niceSubtitle2(), children: <TextSpan>[
      TextSpan(text: wochentag, style: niceSubtitle2Bold()),
      TextSpan(text: ", "),
      TextSpan(text: datumFormat),
    ]));
  }

  @override
  void initState() {
    super.initState();
    getPrefs();

    print('URL-Datum: ' + urlDatum);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    Timer(Duration(milliseconds: 200), () => _animationController.forward());

    initializeDateFormatting();
    vertretungReset();
    onlineChecker();
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
        body: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Container(
                    //color: t("body"), /// Hintergrundfarbe
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(child: eintragHandler()),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 25,
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
                            //vertretungsplanReset();
                            showDatePicker(
                              context: context,
                              locale: const Locale("de", "DE"),
                              builder: (BuildContext context, Widget child) {
                                return Container(
                                  color: t("nice").withOpacity(0.06),
                                  child: Theme(
                                    data: ThemeData.dark().copyWith(
                                      colorScheme: ColorScheme.dark(
                                        primary: t("eintragHighlight"),
                                        onPrimary: Colors.white,
                                        surface: t("body"),
                                        onSurface: t("icons"),
                                        onBackground: t("icons"),
                                        secondary: t("eintragHighlight"),
                                        secondaryVariant: t("eintragHighlight"),
                                      ),
                                      dialogBackgroundColor: t("body"),
                                      textSelectionColor: t("nice"),
                                      textSelectionHandleColor:
                                          t("eintragHighlight"),
                                      //fixTextFieldOutlineLabel: true,
                                    ),
                                    child: child,
                                  ),
                                );
                              },
                              cancelText: "AKTUELL ",
                              confirmText: " DATUM WÄHLEN",
                              initialDate:
                                  datumHandler(), //datum == null ? DateTime.now() : datum,
                              firstDate: DateTime(2016, 09, 05),
                              lastDate:
                                  DateTime.now().add(new Duration(days: 30)),
                            ).then((date) {
                              setState(() {
                                datum = date;
                                urlDatum = DateFormat('yyyyMMdd')
                                    .format(datumHandler());
                              });
                              onlineChecker();
                              vertretungReset();
                              vertretungsplanData(urlDatum);
                            });
                          },
                          child: datumPrint(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            annovation == ""
                ? Container()
                : Column(mainAxisSize: MainAxisSize.min, children: [
                    ExpandablePanel(
                      hasIcon: false,
                      header: Container(
                        child: ListTile(
                          title: Text("Weitere Informationen vorhanden!",
                              style: nice()),
                          trailing: Icon(
                            Icons.keyboard_arrow_up_sharp,
                            color: t("nice"),
                          ),
                        ),
                      ),
                      expanded: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        tileColor: t("back_button"),
                        title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(annovation,
                                style: niceCustom(t("niceHint"), 12))),
                      ),
                    ),
                  ]),
          ],
        ));
  }
}
