import 'dart:async';
import 'package:intl/intl.dart';
import 'package:web_scraper/web_scraper.dart';

import '.settings.dart';

Map vertretung = {
  "lehrer": [],
  "block": [],
  "fach": [],
  "klasse": [],
  "raum": [],
  "bemerkung": [],
};
/*
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

  vertretung['lehrer'] = ente(filteredVertretung, 0);
  vertretung['block'] = ente(filteredVertretung, 1);
  vertretung['fach'] = ente(filteredVertretung, 2);
  vertretung['klasse'] = ente(filteredVertretung, 3);
  vertretung['raum'] = ente(filteredVertretung, 4);
  vertretung['bemerkung'] = ente(filteredVertretung, 5);

  print('VP SORTIERT / Klasse: ' + ente(filteredVertretung, 3).toString());
}

/// p: 0 = Lehrer, 1 = Block, 2 = Fach, 3 = Klasse, 4 = Raum, 5 = Bemerkung
List<T> ente<T>(List<T> liste, int p) {
  /// Gibt jedes 6te Element der Liste aus
  return List.generate(
      (liste.length / 6).floor(), (i) => liste[((i + 1) * 6 - 1) - (5 - p)]);
}
*/
